import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/finance/presentation/finance_providers.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class FinanceSettingsScreen extends ConsumerStatefulWidget {
  const FinanceSettingsScreen({super.key});

  @override
  ConsumerState<FinanceSettingsScreen> createState() =>
      _FinanceSettingsScreenState();
}

class _FinanceSettingsScreenState extends ConsumerState<FinanceSettingsScreen> {
  final _defaultBudget = TextEditingController();
  final _activeBudget = TextEditingController();
  int? _cycleDay;
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _defaultBudget.dispose();
    _activeBudget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(financeSettingsProvider);
    final activePeriod = ref.watch(activeFinancePeriodProvider);
    final categories = ref.watch(allFinanceCategoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('PENGATURAN KEUANGAN')),
      body: settings.when(
        data: (value) => activePeriod.when(
          data: (period) {
            _initialize(value, period);
            return ListView(
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
                          'V1 HANYA IDR — TANPA KONVERSI ATAU AGREGASI LINTAS MATA UANG',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'SIKLUS & BUDGET',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  isExpanded: true,
                  initialValue: _cycleDay,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal mulai siklus (1–28)',
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
                      : (value) => setState(() => _cycleDay = value),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Perubahan berlaku setelah periode aktif berakhir. Histori tidak dihitung ulang; periode jembatan dibuat bila diperlukan.',
                ),
                const SizedBox(height: 12),
                _budgetField(
                  controller: _defaultBudget,
                  label: 'Budget default periode baru',
                ),
                const SizedBox(height: 12),
                _budgetField(
                  controller: _activeBudget,
                  label: 'Budget periode aktif: ${period.name}',
                ),
                const SizedBox(height: 16),
                BrutalButton(
                  label: _saving ? 'MENYIMPAN…' : 'SIMPAN PENGATURAN',
                  icon: Icons.save,
                  onPressed: _saving ? null : () => _save(value, period),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'KATEGORI',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _saving ? null : _createCategory,
                      icon: const Icon(Icons.add),
                      label: const Text('TAMBAH'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                categories.when(
                  data: _categoryList,
                  loading: () => const LinearProgressIndicator(),
                  error: (_, _) => const EmptyState(
                    title: 'KATEGORI GAGAL DIMUAT',
                    message: 'Coba kembali dari halaman ini.',
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => const EmptyState(
            title: 'PERIODE AKTIF GAGAL DIMUAT',
            message: 'Pengaturan belum dapat diubah.',
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const EmptyState(
          title: 'PENGATURAN GAGAL DIMUAT',
          message: 'Data lokal tetap aman. Coba kembali.',
        ),
      ),
    );
  }

  void _initialize(FinanceSetting settings, FinancialPeriod period) {
    if (_initialized) return;
    _initialized = true;
    _cycleDay = settings.cycleStartDay;
    _defaultBudget.text = settings.defaultBudgetAmount.toString();
    _activeBudget.text = period.budgetAmount.toString();
  }

  Widget _budgetField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      enabled: !_saving,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: label, prefixText: 'Rp '),
    );
  }

  Widget _categoryList(List<FinancialCategory> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: FinancialTransactionType.values
          .map((type) {
            final values = categories
                .where((item) => item.type == type.storageValue)
                .toList(growable: false);
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: BrutalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      type == FinancialTransactionType.expense
                          ? 'PENGELUARAN'
                          : 'PEMASUKAN',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const Divider(),
                    ...values.map(
                      (category) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(category.name),
                        subtitle: Text(
                          category.isSystem
                              ? 'Kategori sistem'
                              : 'Kategori custom',
                        ),
                        leading: Icon(
                          category.isActive
                              ? Icons.check_circle
                              : Icons.pause_circle,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch.adaptive(
                              value: category.isActive,
                              onChanged: _saving
                                  ? null
                                  : (value) =>
                                        _setCategoryActive(category, value),
                            ),
                            if (!category.isSystem)
                              IconButton(
                                tooltip: 'Hapus ${category.name}',
                                onPressed: _saving
                                    ? null
                                    : () => _deleteCategory(category),
                                icon: const Icon(Icons.delete_outline),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
          .toList(growable: false),
    );
  }

  Future<void> _save(FinanceSetting settings, FinancialPeriod period) async {
    final defaultBudget = int.tryParse(_defaultBudget.text);
    final activeBudget = int.tryParse(_activeBudget.text);
    if (_cycleDay == null || defaultBudget == null || activeBudget == null) {
      _message('Cycle day dan budget wajib berupa angka valid.');
      return;
    }
    setState(() => _saving = true);
    try {
      final repository = ref.read(financeRepositoryProvider);
      if (_cycleDay != settings.cycleStartDay) {
        await repository.updateCycleStartDay(
          _cycleDay!,
          effectiveDate: DateTime.now(),
        );
      }
      await repository.updateDefaultBudget(defaultBudget);
      await repository.updatePeriodBudget(period.id, activeBudget);
      ref.invalidate(activeFinancePeriodProvider);
      if (mounted) _message('Pengaturan keuangan disimpan.');
    } on Object {
      if (mounted) _message('Pengaturan belum dapat disimpan.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _setCategoryActive(
    FinancialCategory category,
    bool value,
  ) async {
    try {
      await ref
          .read(financeRepositoryProvider)
          .setCategoryActive(category.id, isActive: value);
    } on Object {
      if (mounted) _message('Status kategori belum dapat diubah.');
    }
  }

  Future<void> _createCategory() async {
    final name = TextEditingController();
    var type = FinancialTransactionType.expense;
    final result = await showDialog<(String, FinancialTransactionType)>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('TAMBAH KATEGORI'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                autofocus: true,
                maxLength: 100,
                decoration: const InputDecoration(labelText: 'Nama kategori'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<FinancialTransactionType>(
                isExpanded: true,
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Tipe'),
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
                onChanged: (value) {
                  if (value != null) setDialogState(() => type = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('BATAL'),
            ),
            FilledButton(
              onPressed: () {
                if (name.text.trim().isNotEmpty) {
                  Navigator.pop(dialogContext, (name.text.trim(), type));
                }
              },
              child: const Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
    name.dispose();
    if (result == null || !mounted) return;
    try {
      await ref
          .read(financeRepositoryProvider)
          .createCategory(name: result.$1, type: result.$2);
      if (mounted) _message('Kategori ditambahkan.');
    } on Object {
      if (mounted) _message('Nama kategori sudah dipakai atau tidak valid.');
    }
  }

  Future<void> _deleteCategory(FinancialCategory category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('HAPUS KATEGORI?'),
        content: Text(
          '${category.name} hanya dapat dihapus bila belum digunakan transaksi.',
        ),
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
    try {
      await ref.read(financeRepositoryProvider).deleteCategory(category.id);
      if (mounted) _message('Kategori dihapus.');
    } on Object {
      if (mounted) {
        _message('Kategori masih digunakan; nonaktifkan untuk histori lama.');
      }
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
