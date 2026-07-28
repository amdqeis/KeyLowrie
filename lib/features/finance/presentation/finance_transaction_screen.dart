import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/features/finance/presentation/finance_ui.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class FinanceTransactionScreen extends ConsumerStatefulWidget {
  const FinanceTransactionScreen({required this.id, super.key});

  final String id;

  @override
  ConsumerState<FinanceTransactionScreen> createState() =>
      _FinanceTransactionScreenState();
}

class _FinanceTransactionScreenState
    extends ConsumerState<FinanceTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _amount = TextEditingController();
  final _notes = TextEditingController();
  FinancialTransactionType _type = FinancialTransactionType.expense;
  DateTime _date = DateTime.now();
  String? _categoryId;
  bool _isReimburse = false;
  String? _loadedId;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _amount.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transaction = ref.watch(financeTransactionProvider(widget.id));
    final categories = ref.watch(allFinanceCategoriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL TRANSAKSI'),
        actions: [
          IconButton(
            tooltip: 'Hapus transaksi',
            onPressed: _saving ? null : _delete,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: transaction.when(
        data: (value) {
          if (value == null) {
            return const EmptyState(
              title: 'TRANSAKSI TIDAK DITEMUKAN',
              message: 'Data mungkin telah dihapus dari perangkat ini.',
            );
          }
          _initialize(value);
          return categories.when(
            data: (values) => _form(value, values),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const EmptyState(
              title: 'KATEGORI GAGAL DIMUAT',
              message: 'Coba kembali sebelum mengedit transaksi.',
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const EmptyState(
          title: 'DETAIL BELUM DAPAT DIBUKA',
          message: 'Coba kembali dari halaman riwayat.',
        ),
      ),
    );
  }

  void _initialize(FinanceTransactionRecord transaction) {
    if (_loadedId == transaction.id) return;
    _loadedId = transaction.id;
    _name.text = transaction.name;
    _amount.text = transaction.amount.toString();
    _notes.text = transaction.notes ?? '';
    _type = transaction.type;
    _date = transaction.transactionDate;
    _categoryId = transaction.categoryId;
    _isReimburse = transaction.isReimburse;
  }

  Widget _form(
    FinanceTransactionRecord transaction,
    List<FinancialCategory> categories,
  ) {
    final eligible = categories
        .where(
          (category) =>
              category.type == _type.storageValue &&
              (category.isActive || category.id == _categoryId),
        )
        .toList(growable: false);
    if (!eligible.any((item) => item.id == _categoryId)) {
      _categoryId = _fallbackCategory(categories, _type).id;
    }
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const BrutalCard(
            color: Color(0xFFFFD60A),
            child: Row(
              children: [
                Icon(Icons.currency_exchange),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'MATA UANG IDR — KONVERSI TIDAK TERSEDIA',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<FinancialTransactionType>(
            key: ValueKey('transaction-type-${_type.name}'),
            isExpanded: true,
            initialValue: _type,
            decoration: const InputDecoration(labelText: 'Tipe transaksi'),
            items: const [
              DropdownMenuItem(
                value: FinancialTransactionType.expense,
                child: Text('Pengeluaran'),
              ),
              DropdownMenuItem(
                value: FinancialTransactionType.income,
                child: Text('Pemasukan'),
              ),
            ],
            onChanged: _saving
                ? null
                : (value) {
                    if (value == null || value == _type) return;
                    setState(() {
                      _type = value;
                      _categoryId = _fallbackCategory(categories, value).id;
                      if (value == FinancialTransactionType.income) {
                        _isReimburse = false;
                      }
                    });
                  },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _name,
            enabled: !_saving,
            textInputAction: TextInputAction.next,
            maxLength: 200,
            decoration: const InputDecoration(labelText: 'Nama transaksi'),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Nama wajib diisi.'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _amount,
            enabled: !_saving,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Nominal',
              prefixText: 'Rp ',
            ),
            validator: (value) {
              final amount = int.tryParse(value ?? '');
              return amount == null || amount <= 0
                  ? 'Nominal harus lebih dari 0.'
                  : null;
            },
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _saving ? null : _pickDate,
            icon: const Icon(Icons.calendar_month),
            label: Text('Tanggal: ${formatFinanceDate(_date)}'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: ValueKey('transaction-category-${_type.name}-$_categoryId'),
            isExpanded: true,
            initialValue: _categoryId,
            decoration: const InputDecoration(labelText: 'Kategori'),
            items: eligible
                .map(
                  (category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(
                      '${category.name}${category.isActive ? '' : ' (nonaktif)'}',
                    ),
                  ),
                )
                .toList(growable: false),
            onChanged: _saving
                ? null
                : (value) => setState(() => _categoryId = value),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _notes,
            enabled: !_saving,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Catatan opsional'),
          ),
          if (_type == FinancialTransactionType.expense) ...[
            const SizedBox(height: 8),
            Material(
              color: Colors.transparent,
              child: SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: const Text('Reimburse'),
                subtitle: const Text(
                  'Tetap masuk pengeluaran, tetapi tidak mengurangi budget.',
                ),
                value: _isReimburse,
                onChanged: _saving
                    ? null
                    : (value) => setState(() => _isReimburse = value),
              ),
            ),
          ],
          const SizedBox(height: 20),
          BrutalButton(
            label: _saving ? 'MENYIMPAN…' : 'SIMPAN PERUBAHAN',
            icon: Icons.save,
            onPressed: _saving ? null : () => _save(transaction),
          ),
        ],
      ),
    );
  }

  FinancialCategory _fallbackCategory(
    List<FinancialCategory> categories,
    FinancialTransactionType type,
  ) {
    final eligible = categories.where(
      (item) => item.type == type.storageValue && item.isActive,
    );
    return eligible.firstWhere(
      (item) => item.name.toLowerCase() == 'lainnya',
      orElse: () => eligible.first,
    );
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (value != null && mounted) setState(() => _date = value);
  }

  Future<void> _save(FinanceTransactionRecord transaction) async {
    if (!(_formKey.currentState?.validate() ?? false) || _categoryId == null) {
      return;
    }
    setState(() => _saving = true);
    try {
      await ref
          .read(financeRepositoryProvider)
          .updateTransaction(
            transaction.id,
            FinanceTransactionInput(
              id: transaction.id,
              type: _type,
              name: _name.text,
              amount: int.parse(_amount.text),
              transactionDate: _date,
              categoryId: _categoryId!,
              notes: _notes.text,
              isReimburse:
                  _type == FinancialTransactionType.expense && _isReimburse,
            ),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Transaksi diperbarui.')));
    } on Object {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaksi belum dapat disimpan.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('HAPUS TRANSAKSI?'),
        content: const Text('Tindakan ini tidak dapat diurungkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('BATAL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('HAPUS'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _saving = true);
    try {
      await ref.read(financeRepositoryProvider).deleteTransaction(widget.id);
      if (mounted) context.pop();
    } on Object {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaksi belum dapat dihapus.')),
      );
    }
  }
}
