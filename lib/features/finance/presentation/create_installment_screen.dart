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

class CreateInstallmentScreen extends ConsumerStatefulWidget {
  const CreateInstallmentScreen({super.key});

  @override
  ConsumerState<CreateInstallmentScreen> createState() =>
      _CreateInstallmentScreenState();
}

class _CreateInstallmentScreenState
    extends ConsumerState<CreateInstallmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _totalAmount = TextEditingController();
  final _installmentCount = TextEditingController();
  final _monthlyAmount = TextEditingController();
  final _notes = TextEditingController();
  InstallmentType _type = InstallmentType.evenSplit;
  DateTime _startDate = DateTime.now();
  int _dayOfMonth = DateTime.now().day.clamp(1, 28);
  String? _categoryId;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _totalAmount.dispose();
    _installmentCount.dispose();
    _monthlyAmount.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(allFinanceCategoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('BUAT CICILAN')),
      body: categories.when(
        data: (values) => _form(values),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const EmptyState(
          title: 'KATEGORI GAGAL DIMUAT',
          message: 'Coba kembali sebelum membuat cicilan.',
        ),
      ),
    );
  }

  Widget _form(List<FinancialCategory> categories) {
    final expenseCategories = categories
        .where(
          (category) =>
              category.type == 'expense' &&
              (category.isActive || category.id == _categoryId),
        )
        .toList(growable: false);
    if (_categoryId == null && expenseCategories.isNotEmpty) {
      _categoryId = _fallbackCategory(expenseCategories).id;
    }
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const BrutalCard(
            color: Color(0xFFB7E4C7),
            child: Row(
              children: [
                Icon(Icons.credit_card),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'CICILAN OTOMATIS — TRANSAKSI DIBUAT SETIAP BULAN',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _name,
            enabled: !_saving,
            textInputAction: TextInputAction.next,
            maxLength: 200,
            decoration: const InputDecoration(
              labelText: 'Nama cicilan',
              hintText: 'Contoh: Cicilan Laptop',
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Nama wajib diisi.'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _totalAmount,
            enabled: !_saving,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Total harga',
              prefixText: 'Rp ',
              hintText: 'Contoh: 12000000',
            ),
            validator: (value) {
              final amount = int.tryParse(value ?? '');
              return amount == null || amount <= 0
                  ? 'Total harga harus lebih dari 0.'
                  : null;
            },
          ),
          const SizedBox(height: 16),
          _buildTypeSelector(),
          const SizedBox(height: 12),
          if (_type == InstallmentType.evenSplit) ...[
            TextFormField(
              controller: _installmentCount,
              enabled: !_saving,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Jumlah bulan cicilan',
                hintText: 'Contoh: 12',
              ),
              validator: (value) {
                final count = int.tryParse(value ?? '');
                return count == null || count < 2
                    ? 'Minimal 2 bulan.'
                    : null;
              },
            ),
          ] else ...[
            TextFormField(
              controller: _monthlyAmount,
              enabled: !_saving,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Cicilan per bulan',
                prefixText: 'Rp ',
                hintText: 'Contoh: 500000',
              ),
              validator: (value) {
                final amount = int.tryParse(value ?? '');
                if (amount == null || amount <= 0) {
                  return 'Cicilan harus lebih dari 0.';
                }
                final total = int.tryParse(_totalAmount.text);
                if (total != null && amount >= total) {
                  return 'Cicilan per bulan harus kurang dari total harga.';
                }
                return null;
              },
            ),
          ],
          const SizedBox(height: 12),
          _buildDayOfMonthPicker(),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _saving ? null : _pickStartDate,
            icon: const Icon(Icons.calendar_month),
            label: Text('Mulai: ${formatFinanceDate(_startDate)}'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: ValueKey('installment-category-$_categoryId'),
            isExpanded: true,
            initialValue: _categoryId,
            decoration: const InputDecoration(labelText: 'Kategori'),
            items: expenseCategories
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
          const SizedBox(height: 16),
          _buildPreview(),
          const SizedBox(height: 20),
          BrutalButton(
            label: _saving ? 'MENYIMPAN…' : 'BUAT CICILAN',
            icon: Icons.add_card,
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TIPE CICILAN',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        SegmentedButton<InstallmentType>(
          segments: const [
            ButtonSegment(
              value: InstallmentType.evenSplit,
              label: Text('Bagi Rata'),
              icon: Icon(Icons.horizontal_split),
            ),
            ButtonSegment(
              value: InstallmentType.fixedMonthly,
              label: Text('Tetap/Bulan'),
              icon: Icon(Icons.attach_money),
            ),
          ],
          selected: {_type},
          onSelectionChanged: _saving
              ? null
              : (value) => setState(() => _type = value.first),
        ),
      ],
    );
  }

  Widget _buildDayOfMonthPicker() {
    return DropdownButtonFormField<int>(
      isExpanded: true,
      initialValue: _dayOfMonth,
      decoration: const InputDecoration(
        labelText: 'Tanggal jatuh tempo setiap bulan',
      ),
      items: List.generate(
        28,
        (index) => DropdownMenuItem(
          value: index + 1,
          child: Text('Tanggal ${index + 1}'),
        ),
      ),
      onChanged: _saving
          ? null
          : (value) {
              if (value != null) setState(() => _dayOfMonth = value);
            },
    );
  }

  Widget _buildPreview() {
    final total = int.tryParse(_totalAmount.text);
    if (total == null || total <= 0) return const SizedBox.shrink();

    int? months;
    int? perMonth;
    if (_type == InstallmentType.evenSplit) {
      months = int.tryParse(_installmentCount.text);
      if (months != null && months >= 2) {
        perMonth = total ~/ months;
      }
    } else {
      perMonth = int.tryParse(_monthlyAmount.text);
      if (perMonth != null && perMonth > 0 && perMonth < total) {
        months = (total / perMonth).ceil();
      }
    }

    if (months == null || perMonth == null) return const SizedBox.shrink();

    final lastAmount = total - (perMonth * (months - 1));

    return BrutalCard(
      color: const Color(0xFFF0F0F0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PREVIEW',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text('Total: ${formatIdr(total)}'),
          Text('Cicilan per bulan: ${formatIdr(perMonth)}'),
          Text('Jumlah bulan: $months'),
          if (lastAmount != perMonth)
            Text('Cicilan terakhir: ${formatIdr(lastAmount)}'),
          Text('Tanggal jatuh tempo: setiap tanggal $_dayOfMonth'),
        ],
      ),
    );
  }

  FinancialCategory _fallbackCategory(
    List<FinancialCategory> categories,
  ) {
    final active = categories.where((item) => item.isActive);
    return active.firstWhere(
      (item) => item.name.toLowerCase() == 'lainnya',
      orElse: () => active.first,
    );
  }

  Future<void> _pickStartDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (value != null && mounted) setState(() => _startDate = value);
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false) || _categoryId == null) {
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(financeRepositoryProvider).createInstallmentPlan(
        InstallmentPlanInput(
          name: _name.text,
          totalAmount: int.parse(_totalAmount.text),
          installmentType: _type,
          dayOfMonth: _dayOfMonth,
          categoryId: _categoryId!,
          startDate: _startDate,
          totalInstallments: _type == InstallmentType.evenSplit
              ? int.parse(_installmentCount.text)
              : null,
          monthlyAmount: _type == InstallmentType.fixedMonthly
              ? int.parse(_monthlyAmount.text)
              : null,
          notes: _notes.text,
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cicilan berhasil dibuat.')),
      );
      context.pop();
    } on Object {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cicilan belum dapat disimpan.')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
