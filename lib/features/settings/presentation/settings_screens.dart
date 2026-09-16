import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/features/targets/domain/target_calculator.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStreamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('PENGATURAN')),
      body: settings.when(
        data: (value) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Model Gemini ──────────────────────────────────
            Text(
              'MODEL AI',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            _GeminiModelPicker(currentModel: value.geminiModel),
            const SizedBox(height: 18),
            // ── Tema ─────────────────────────────────────────
            DropdownButtonFormField<String>(
              initialValue: value.themeMode,
              decoration: const InputDecoration(labelText: 'Tema'),
              items:
                  const {'system': 'Sistem', 'light': 'Terang', 'dark': 'Gelap'}
                      .entries
                      .map(
                        (entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
              onChanged: (next) {
                if (next != null) {
                  ref.read(settingsRepositoryProvider).setThemeMode(next);
                }
              },
            ),
            const SizedBox(height: 18),
            _SettingsTile(
              icon: Icons.flag,
              title: 'Target & Profil',
              subtitle: 'Target manual atau estimasi BMR/TDEE',
              route: AppRoutes.profile,
            ),
            _SettingsTile(
              icon: Icons.key,
              title: 'API Key Pool',
              subtitle: 'Tambah, urutkan, tes, dan pilih Active Key',
              route: AppRoutes.apiKeys,
            ),
            _SettingsTile(
              icon: Icons.notifications,
              title: 'Reminder',
              subtitle: 'Satu reminder lokal berikutnya',
              route: AppRoutes.reminders,
            ),
            _SettingsTile(
              icon: Icons.account_balance_wallet,
              title: 'Keuangan',
              subtitle: 'Siklus, budget IDR, dan kategori',
              route: AppRoutes.financeSettings,
            ),
            _SettingsTile(
              icon: Icons.privacy_tip,
              title: 'Privasi & Data',
              subtitle: 'Cara KeySpace menyimpan dan mengirim data',
              route: AppRoutes.data,
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('Pengaturan belum dapat dibuka.')),
      ),
    );
  }
}

/// Widget model picker — daftar semua model Gemini yang tersedia, bisa di-tap.
class _GeminiModelPicker extends ConsumerWidget {
  const _GeminiModelPicker({required this.currentModel});
  final String currentModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final models = ProviderConfig.availableModels;
    return Column(
      children: [
        for (final m in models)
          _ModelTile(
            modelId: m.id,
            label: m.label,
            note: m.note,
            isActive: m.id == currentModel,
            isRecommended: m.id == ProviderConfig.model,
            onTap: () async {
              if (m.id == currentModel) return;
              await ref
                  .read(settingsRepositoryProvider)
                  .updateGeminiModel(m.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Model diubah ke ${m.label}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}

class _ModelTile extends StatelessWidget {
  const _ModelTile({
    required this.modelId,
    required this.label,
    required this.note,
    required this.isActive,
    required this.isRecommended,
    required this.onTap,
  });

  final String modelId;
  final String label;
  final String note;
  final bool isActive;
  final bool isRecommended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isActive ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? colorScheme.primary.withAlpha(20)
                : colorScheme.surface,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              // Radio indicator
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: isActive
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.primary,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              // Label + note
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          label,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: isActive
                                ? FontWeight.w900
                                : FontWeight.w600,
                          ),
                        ),
                        if (isRecommended) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD60A),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '⭐ Rekomendasi',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                        if (isActive && !isRecommended) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Aktif',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      note,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TargetProfileScreen extends ConsumerStatefulWidget {
  const TargetProfileScreen({super.key});

  @override
  ConsumerState<TargetProfileScreen> createState() =>
      _TargetProfileScreenState();
}

class _TargetProfileScreenState extends ConsumerState<TargetProfileScreen> {
  final _target = TextEditingController();
  final _weight = TextEditingController(text: '65');
  final _height = TextEditingController(text: '165');
  final _age = TextEditingController(text: '30');
  var _sex = FormulaSex.female;
  var _activity = ActivityLevel.moderate;
  var _goal = CalorieGoal.maintenance;
  String? _message;

  @override
  void dispose() {
    _target.dispose();
    _weight.dispose();
    _height.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TARGET & PROFIL')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'TARGET MANUAL',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _target,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'kcal per hari'),
          ),
          const SizedBox(height: 10),
          BrutalButton(label: 'TERAPKAN HARI INI', onPressed: _saveManual),
          const SizedBox(height: 28),
          Text(
            'ESTIMASI BMR/TDEE',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _field(_weight, 'Berat kg')),
              const SizedBox(width: 8),
              Expanded(child: _field(_height, 'Tinggi cm')),
              const SizedBox(width: 8),
              Expanded(child: _field(_age, 'Usia')),
            ],
          ),
          const SizedBox(height: 10),
          _enumField(
            'Kategori formula',
            _sex,
            FormulaSex.values,
            (value) => setState(() => _sex = value),
          ),
          const SizedBox(height: 10),
          _enumField(
            'Aktivitas',
            _activity,
            ActivityLevel.values,
            (value) => setState(() => _activity = value),
          ),
          const SizedBox(height: 10),
          _enumField(
            'Goal',
            _goal,
            CalorieGoal.values,
            (value) => setState(() => _goal = value),
          ),
          const SizedBox(height: 10),
          BrutalButton(
            label: 'HITUNG & TERAPKAN',
            icon: Icons.calculate,
            secondary: true,
            onPressed: _saveEstimate,
          ),
          if (_message != null) ...[
            const SizedBox(height: 14),
            BrutalCard(
              color: const Color(0xFFFFD60A),
              child: Text(
                _message!,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Text(
            'BMR/TDEE dan nutrisi merupakan estimasi, bukan saran medis individual.',
          ),
        ],
      ),
    );
  }

  Widget _field(TextEditingController controller, String label) => TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(labelText: label),
  );

  Widget _enumField<T extends Enum>(
    String label,
    T value,
    List<T> values,
    ValueChanged<T> onChanged,
  ) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: values
          .map((item) => DropdownMenuItem(value: item, child: Text(item.name)))
          .toList(),
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    );
  }

  Future<void> _saveManual() async {
    final value = int.tryParse(_target.text);
    if (value == null ||
        value <= 0 ||
        value > ProviderConfig.targetMaximumKcal) {
      setState(() => _message = 'Masukkan target 1–9.999 kcal.');
      return;
    }
    await ref.read(targetRepositoryProvider).saveManual(value, DateTime.now());
    setState(() => _message = 'Target $value kcal berlaku mulai hari ini.');
  }

  Future<void> _saveEstimate() async {
    try {
      final weight = double.parse(_weight.text);
      final height = double.parse(_height.text);
      final age = int.parse(_age.text);
      final result = TargetCalculator.mifflinStJeor(
        weightKg: weight,
        heightCm: height,
        age: age,
        sex: _sex,
        activity: _activity,
        goal: _goal,
      );
      await ref
          .read(targetRepositoryProvider)
          .saveEstimate(
            result,
            DateTime.now(),
            weightKg: weight,
            heightCm: height,
            age: age,
            sex: _sex,
            activity: _activity,
            goal: _goal,
          );
      setState(
        () => _message =
            'Estimasi ${result.suggestedTargetKcal} kcal diterapkan. BMR ${result.bmr.round()}, TDEE ${result.tdee.round()}.',
      );
    } on Object {
      setState(
        () => _message = 'Lengkapi nilai formula dengan angka yang valid.',
      );
    }
  }
}

class ReminderSettingsScreen extends ConsumerStatefulWidget {
  const ReminderSettingsScreen({super.key});

  @override
  ConsumerState<ReminderSettingsScreen> createState() =>
      _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState
    extends ConsumerState<ReminderSettingsScreen> {
  bool? _enabled;
  TimeOfDay? _time;
  int? _threshold;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(reminderStreamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('REMINDER DASAR')),
      body: settings.when(
        data: (value) {
          _enabled ??= value.isEnabled;
          final parts = value.reminderTimeLocal
              .split(':')
              .map(int.parse)
              .toList();
          _time ??= TimeOfDay(hour: parts[0], minute: parts[1]);
          _threshold ??= value.thresholdPercent;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const BrutalCard(
                child: Text(
                  'Internal MVP menjadwalkan satu occurrence berikutnya. Horizon dan reconciliation penuh hadir di Fase 1.1.',
                ),
              ),
              SwitchListTile(
                title: const Text('Aktifkan reminder'),
                value: _enabled!,
                onChanged: (next) => setState(() => _enabled = next),
              ),
              BrutalButton(
                label: 'JAM ${_time!.format(context)}',
                icon: Icons.schedule,
                secondary: true,
                onPressed: _pickTime,
              ),
              const SizedBox(height: 14),
              Text('Threshold ${_threshold!}%'),
              Slider(
                value: _threshold!.toDouble(),
                min: 10,
                max: 100,
                divisions: 9,
                label: '$_threshold%',
                onChanged: (next) => setState(() => _threshold = next.round()),
              ),
              const SizedBox(height: 14),
              BrutalButton(label: 'SIMPAN REMINDER', onPressed: _save),
              const SizedBox(height: 12),
              StatusBadge(
                label: 'Izin ${value.permissionStatus}',
                icon: Icons.notifications_active,
                color: const Color(0xFFE5E5E0),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('Reminder belum dapat dibuka.')),
      ),
    );
  }

  Future<void> _pickTime() async {
    final value = await showTimePicker(context: context, initialTime: _time!);
    if (value != null) setState(() => _time = value);
  }

  Future<void> _save() async {
    await ref
        .read(reminderRepositoryProvider)
        .configure(
          enabled: _enabled!,
          hour: _time!.hour,
          minute: _time!.minute,
          thresholdPercent: _threshold!,
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengaturan reminder disimpan.')),
      );
    }
  }
}

class PrivacyDataScreen extends StatelessWidget {
  const PrivacyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PRIVASI & DATA')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          BrutalCard(
            color: Color(0xFFFFD60A),
            child: Text(
              'TANPA BACKEND • TANPA LOGIN',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: 14),
          BrutalCard(
            child: Text(
              'Food Log, transaksi keuangan, profil, target, chat, dan settings disimpan di SQLite pada perangkat.',
            ),
          ),
          SizedBox(height: 14),
          BrutalCard(
            child: Text(
              'API key disimpan terpisah di secure storage platform. Secret tidak masuk database, log, diagnostics, atau fixture.',
            ),
          ),
          SizedBox(height: 14),
          BrutalCard(
            child: Text(
              'Saat Anda menekan Kirim di Chat, hanya teks input dan konteks minimum parsing yang dikirim langsung ke Gemini. Histori transaksi, profil BMR/TDEE, dan nominal budget tidak dikirim.',
            ),
          ),
          SizedBox(height: 14),
          BrutalCard(
            child: Text(
              'Estimasi nutrisi dapat tidak akurat dan bukan pengganti saran profesional. Backup/restore dan hapus semua data hadir pada Fase 1.1.',
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BrutalCard(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () => context.push(route),
        ),
      ),
    );
  }
}
