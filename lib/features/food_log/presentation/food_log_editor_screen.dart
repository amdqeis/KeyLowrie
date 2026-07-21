import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_log/domain/food_log_input.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class FoodLogEditorScreen extends ConsumerStatefulWidget {
  const FoodLogEditorScreen({required this.id, super.key, this.initialDate});

  final String id;
  final String? initialDate;

  @override
  ConsumerState<FoodLogEditorScreen> createState() =>
      _FoodLogEditorScreenState();
}

class _FoodLogEditorScreenState extends ConsumerState<FoodLogEditorScreen> {
  final _notes = TextEditingController();
  final _items = <_ItemControllers>[];
  var _mealType = 'lainnya';
  late DateTime _consumedAt;
  var _loading = true;
  var _saving = false;
  var _wasDraft = false;
  String? _error;

  bool get _isNew => widget.id == 'new';

  @override
  void initState() {
    super.initState();
    _consumedAt = widget.initialDate == null
        ? DateTime.now()
        : DateTime.parse(widget.initialDate!).add(
            Duration(
              hours: DateTime.now().hour,
              minutes: DateTime.now().minute,
            ),
          );
    _load();
  }

  Future<void> _load() async {
    if (_isNew) {
      _items.add(_ItemControllers());
      setState(() => _loading = false);
      return;
    }
    final detail = await ref.read(foodLogRepositoryProvider).detail(widget.id);
    if (detail == null) {
      setState(() {
        _loading = false;
        _error = 'Food Log tidak ditemukan.';
      });
      return;
    }
    final log = detail.log as FoodLog;
    _wasDraft = log.status == 'draft';
    _mealType = log.mealType;
    _consumedAt = log.consumedAtUtc.toLocal();
    _notes.text = log.notes ?? '';
    for (final item in detail.items.cast<FoodItem>()) {
      _items.add(_ItemControllers.fromItem(item));
    }
    if (_items.isEmpty) _items.add(_ItemControllers());
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _notes.dispose();
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isNew ? 'CATAT MANUAL' : 'EDIT FOOD LOG')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_error != null) ...[
                  StatusBadge(
                    label: _error!,
                    icon: Icons.error_outline,
                    color: Theme.of(context).colorScheme.errorContainer,
                  ),
                  const SizedBox(height: 14),
                ],
                Row(
                  children: [
                    Expanded(
                      child: BrutalButton(
                        label: localDateKey(_consumedAt),
                        icon: Icons.calendar_today,
                        secondary: true,
                        onPressed: _pickDate,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _mealType,
                        decoration: const InputDecoration(
                          labelText: 'Meal type',
                        ),
                        items:
                            const [
                                  'sarapan',
                                  'makan_siang',
                                  'makan_malam',
                                  'snack',
                                  'lainnya',
                                ]
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value.replaceAll('_', ' ')),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) =>
                            setState(() => _mealType = value ?? _mealType),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ..._items.indexed.map(
                  (entry) => _itemEditor(entry.$1, entry.$2),
                ),
                BrutalButton(
                  label: 'TAMBAH ITEM',
                  icon: Icons.add,
                  secondary: true,
                  onPressed: () =>
                      setState(() => _items.add(_ItemControllers())),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _notes,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Catatan (opsional)',
                  ),
                ),
                const SizedBox(height: 20),
                BrutalButton(
                  label: _saving ? 'MENYIMPAN…' : 'SIMPAN FOOD LOG',
                  icon: Icons.save,
                  onPressed: _saving ? null : _save,
                ),
                if (!_isNew) ...[
                  const SizedBox(height: 12),
                  BrutalButton(
                    label: 'DUPLIKASI KE SEKARANG',
                    icon: Icons.copy,
                    secondary: true,
                    onPressed: _duplicate,
                  ),
                ],
              ],
            ),
    );
  }

  Widget _itemEditor(int index, _ItemControllers item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: BrutalCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ITEM ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                if (_items.length > 1)
                  IconButton(
                    tooltip: 'Hapus item',
                    onPressed: () => setState(() {
                      _items.removeAt(index).dispose();
                    }),
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
            TextField(
              controller: item.name,
              decoration: const InputDecoration(labelText: 'Nama makanan'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _number(item.calories, 'Kalori')),
                const SizedBox(width: 8),
                Expanded(child: _number(item.protein, 'Protein g')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _number(item.carbs, 'Karbo g')),
                const SizedBox(width: 8),
                Expanded(child: _number(item.fat, 'Lemak g')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _number(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
    );
  }

  FoodLogInput _input() {
    final items = _items.map((item) {
      final calories = double.tryParse(item.calories.text.replaceAll(',', '.'));
      if (item.name.text.trim().isEmpty || calories == null || calories < 0) {
        throw const FormatException('Nama dan kalori setiap item wajib valid.');
      }
      return FoodItemInput(
        name: item.name.text.trim(),
        caloriesKcal: calories,
        proteinG: _optionalNumber(item.protein.text),
        carbsG: _optionalNumber(item.carbs.text),
        fatG: _optionalNumber(item.fat.text),
      );
    }).toList();
    return FoodLogInput(
      consumedAt: _consumedAt,
      mealType: _mealType,
      items: items,
      originalUserText: items.map((item) => item.name).join(', '),
      notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
    );
  }

  double? _optionalNumber(String value) {
    final cleaned = value.trim();
    if (cleaned.isEmpty) return null;
    final parsed = double.tryParse(cleaned.replaceAll(',', '.'));
    if (parsed == null || parsed < 0 || !parsed.isFinite) {
      throw const FormatException('Nilai nutrisi harus non-negatif.');
    }
    return parsed;
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final input = _input();
      final repository = ref.read(foodLogRepositoryProvider);
      if (_isNew && await repository.isPotentialDuplicate(input)) {
        if (!mounted) return;
        final proceed =
            await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('KEMUNGKINAN DUPLIKAT'),
                content: const Text(
                  'Ada catatan dengan waktu dan total serupa. Tetap simpan?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('BATAL'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('SIMPAN'),
                  ),
                ],
              ),
            ) ??
            false;
        if (!proceed) return;
      }
      if (_isNew) {
        await repository.saveManual(input);
      } else {
        await repository.update(widget.id, input);
        if (_wasDraft) await repository.confirmDraft(widget.id);
      }
      await ref
          .read(reminderCoordinatorProvider)
          .reconcileDate(localDateKey(input.consumedAt));
      if (mounted) context.pop();
    } on FormatException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } on Object {
      if (mounted) setState(() => _error = 'Food Log belum berhasil disimpan.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _duplicate() async {
    await ref
        .read(foodLogRepositoryProvider)
        .duplicate(widget.id, DateTime.now());
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Food Log diduplikasi')));
      context.pop();
    }
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _consumedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (value != null) {
      setState(() {
        _consumedAt = DateTime(
          value.year,
          value.month,
          value.day,
          _consumedAt.hour,
          _consumedAt.minute,
        );
      });
    }
  }
}

class _ItemControllers {
  _ItemControllers();

  factory _ItemControllers.fromItem(FoodItem item) {
    final value = _ItemControllers();
    value.name.text = item.displayName;
    value.calories.text = _format(item.caloriesKcal);
    value.protein.text = _formatOptional(item.proteinG);
    value.carbs.text = _formatOptional(item.carbsG);
    value.fat.text = _formatOptional(item.fatG);
    return value;
  }

  final name = TextEditingController();
  final calories = TextEditingController();
  final protein = TextEditingController();
  final carbs = TextEditingController();
  final fat = TextEditingController();

  void dispose() {
    name.dispose();
    calories.dispose();
    protein.dispose();
    carbs.dispose();
    fat.dispose();
  }

  static String _format(double value) => value == value.roundToDouble()
      ? value.round().toString()
      : value.toStringAsFixed(1);
  static String _formatOptional(double? value) =>
      value == null ? '' : _format(value);
}
