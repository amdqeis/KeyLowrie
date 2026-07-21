import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/targets/domain/target_calculator.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _name = TextEditingController();
  final _target = TextEditingController(text: '2000');
  final _weight = TextEditingController(text: '65');
  final _height = TextEditingController(text: '165');
  final _age = TextEditingController(text: '30');
  final _alias = TextEditingController(text: 'Key utama');
  final _secret = TextEditingController();
  var _step = 0;
  var _weightUnit = 'kg';
  var _heightUnit = 'cm';
  var _themeMode = 'system';
  var _targetMode = 'manual';
  var _sex = FormulaSex.female;
  var _activity = ActivityLevel.moderate;
  var _goal = CalorieGoal.maintenance;
  var _testKey = true;
  var _enableReminder = false;
  var _reminderTime = const TimeOfDay(hour: 20, minute: 0);
  var _busy = false;
  String? _error;
  TargetEstimate? _estimate;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _target,
      _weight,
      _height,
      _age,
      _alias,
      _secret,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _step == 0
          ? null
          : AppBar(
              title: Text('SETUP ${_step + 1}/6'),
              leading: IconButton(
                tooltip: 'Kembali',
                onPressed: _busy ? null : () => setState(() => _step--),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Column(
              key: ValueKey(_step),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _content(),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  StatusBadge(
                    label: _error!,
                    icon: Icons.error_outline,
                    color: Theme.of(context).colorScheme.errorContainer,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() => switch (_step) {
    0 => _welcome(),
    1 => _preferences(),
    2 => _targetSetup(),
    3 => _keySetup(),
    4 => _reminderSetup(),
    _ => _finish(),
  };

  Widget _welcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 48),
        Text(
          'CATAT MAKANAN\nCUKUP LEWAT CHAT',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            height: 0.95,
          ),
        ),
        const SizedBox(height: 28),
        const BrutalCard(
          color: Color(0xFFFFD60A),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Value(
                icon: Icons.phone_android,
                text: 'DATA TERSIMPAN DI PERANGKAT',
              ),
              SizedBox(height: 12),
              _Value(
                icon: Icons.person_off_outlined,
                text: 'TANPA LOGIN ATAU AKUN',
              ),
              SizedBox(height: 12),
              _Value(
                icon: Icons.lock_outline,
                text: 'API KEY DI SECURE STORAGE',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        BrutalButton(
          label: 'MULAI',
          icon: Icons.arrow_forward,
          onPressed: () => setState(() => _step = 1),
        ),
        const SizedBox(height: 12),
        BrutalButton(
          label: 'PELAJARI PRIVASI',
          icon: Icons.privacy_tip_outlined,
          secondary: true,
          onPressed: _showPrivacy,
        ),
      ],
    );
  }

  Widget _preferences() {
    return _section(
      title: 'PREFERENSI DASAR',
      subtitle: 'Semua preferensi disimpan lokal dan bisa diubah nanti.',
      children: [
        TextField(
          controller: _name,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Nama panggilan (opsional)',
          ),
        ),
        const SizedBox(height: 14),
        _dropdown(
          label: 'Satuan berat',
          value: _weightUnit,
          values: const {'kg': 'Kilogram', 'lb': 'Pound'},
          onChanged: (value) => setState(() => _weightUnit = value),
        ),
        const SizedBox(height: 14),
        _dropdown(
          label: 'Satuan tinggi',
          value: _heightUnit,
          values: const {'cm': 'Sentimeter', 'ft_in': 'Feet / inch'},
          onChanged: (value) => setState(() => _heightUnit = value),
        ),
        const SizedBox(height: 14),
        _dropdown(
          label: 'Tema',
          value: _themeMode,
          values: const {
            'system': 'Sistem',
            'light': 'Terang',
            'dark': 'Gelap',
          },
          onChanged: (value) => setState(() => _themeMode = value),
        ),
        const SizedBox(height: 20),
        BrutalButton(label: 'LANJUT', onPressed: _savePreferences),
      ],
    );
  }

  Widget _targetSetup() {
    return _section(
      title: 'TARGET KALORI',
      subtitle: 'Gunakan target sendiri, hitung estimasi, atau atur nanti.',
      children: [
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'manual', label: Text('Manual')),
            ButtonSegment(value: 'tdee', label: Text('Estimasi')),
            ButtonSegment(value: 'later', label: Text('Nanti')),
          ],
          selected: {_targetMode},
          onSelectionChanged: (value) => setState(() {
            _targetMode = value.single;
            _error = null;
          }),
        ),
        const SizedBox(height: 18),
        if (_targetMode == 'manual') ...[
          TextField(
            controller: _target,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Target kcal per hari',
            ),
          ),
        ] else if (_targetMode == 'tdee') ...[
          Row(
            children: [
              Expanded(child: _numberField(_weight, 'Berat kg')),
              const SizedBox(width: 10),
              Expanded(child: _numberField(_height, 'Tinggi cm')),
              const SizedBox(width: 10),
              Expanded(child: _numberField(_age, 'Usia')),
            ],
          ),
          const SizedBox(height: 12),
          _enumDropdown(
            'Kategori formula',
            _sex,
            FormulaSex.values,
            (value) => setState(() => _sex = value),
          ),
          const SizedBox(height: 12),
          _enumDropdown(
            'Aktivitas',
            _activity,
            ActivityLevel.values,
            (value) => setState(() => _activity = value),
          ),
          const SizedBox(height: 12),
          _enumDropdown(
            'Goal',
            _goal,
            CalorieGoal.values,
            (value) => setState(() => _goal = value),
          ),
          if (_estimate != null) ...[
            const SizedBox(height: 14),
            BrutalCard(
              color: const Color(0xFFFFD60A),
              child: Text(
                'ESTIMASI ${_estimate!.suggestedTargetKcal} KKAL\n'
                'BMR ${_estimate!.bmr.round()} × ${_estimate!.activityFactor} '
                '${_estimate!.adjustmentKcal >= 0 ? '+' : ''}${_estimate!.adjustmentKcal}',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ],
          const SizedBox(height: 8),
          const Text(
            'Estimasi ini bukan diagnosis atau pengganti konsultasi profesional.',
          ),
        ] else
          const BrutalCard(
            child: Text('Dashboard tetap dapat digunakan tanpa target.'),
          ),
        const SizedBox(height: 20),
        BrutalButton(label: 'SIMPAN & LANJUT', onPressed: _saveTarget),
      ],
    );
  }

  Widget _keySetup() {
    return _section(
      title: 'API KEY GEMINI',
      subtitle:
          'Opsional. Key milik Anda disimpan aman pada perangkat dan tidak masuk database.',
      children: [
        TextField(
          controller: _alias,
          decoration: const InputDecoration(labelText: 'Alias key'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _secret,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'API key'),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Tes key sekarang'),
          value: _testKey,
          onChanged: (value) => setState(() => _testKey = value),
        ),
        BrutalButton(
          label: _busy ? 'MENYIMPAN…' : 'SIMPAN KEY',
          icon: Icons.key,
          onPressed: _busy ? null : _saveKey,
        ),
        const SizedBox(height: 12),
        BrutalButton(
          label: 'LEWATI UNTUK SEKARANG',
          secondary: true,
          onPressed: _busy ? null : () => setState(() => _step = 4),
        ),
      ],
    );
  }

  Widget _reminderSetup() {
    return _section(
      title: 'REMINDER OPSIONAL',
      subtitle:
          'Internal MVP menjadwalkan satu pengingat lokal berikutnya. Pengaturan penuh hadir di Fase 1.1.',
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Aktifkan reminder lokal'),
          subtitle: const Text('Threshold awal 70% dari target'),
          value: _enableReminder,
          onChanged: (value) => setState(() => _enableReminder = value),
        ),
        if (_enableReminder)
          BrutalButton(
            label: 'JAM ${_reminderTime.format(context)}',
            icon: Icons.schedule,
            secondary: true,
            onPressed: _pickReminderTime,
          ),
        const SizedBox(height: 20),
        BrutalButton(
          label: _busy ? 'MEMPROSES…' : 'LANJUT',
          onPressed: _busy ? null : _saveReminder,
        ),
      ],
    );
  }

  Widget _finish() {
    return _section(
      title: 'KEYSPACE SIAP',
      subtitle:
          'Tekan Catat Makanan untuk mulai. Semua fitur lokal tetap bekerja tanpa API key.',
      children: [
        const BrutalCard(
          color: Color(0xFFFFD60A),
          child: Icon(Icons.check, size: 72),
        ),
        const SizedBox(height: 24),
        BrutalButton(
          label: _busy ? 'MENYIAPKAN…' : 'BUKA HARI INI',
          icon: Icons.today,
          onPressed: _busy ? null : _complete,
        ),
      ],
    );
  }

  Widget _section({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        Text(subtitle),
        const SizedBox(height: 22),
        ...children,
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required Map<String, String> values,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: values.entries
          .map(
            (entry) =>
                DropdownMenuItem(value: entry.key, child: Text(entry.value)),
          )
          .toList(),
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    );
  }

  Widget _numberField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _enumDropdown<T extends Enum>(
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

  Future<void> _savePreferences() async {
    await _run(() async {
      await ref
          .read(settingsRepositoryProvider)
          .updatePreferences(
            weightUnit: _weightUnit,
            heightUnit: _heightUnit,
            themeMode: _themeMode,
          );
      setState(() => _step = 2);
    });
  }

  Future<void> _saveTarget() async {
    await _run(() async {
      if (_targetMode == 'manual') {
        final value = int.tryParse(_target.text.trim());
        if (value == null ||
            value <= 0 ||
            value > ProviderConfig.targetMaximumKcal) {
          throw const FormatException('Masukkan target 1–9.999 kcal');
        }
        if ((value < ProviderConfig.targetWarningLowKcal ||
                value > ProviderConfig.targetWarningHighKcal) &&
            !await _confirmExtreme(value)) {
          return;
        }
        await ref
            .read(targetRepositoryProvider)
            .saveManual(value, DateTime.now());
      } else if (_targetMode == 'tdee') {
        final estimate = TargetCalculator.mifflinStJeor(
          weightKg: double.parse(_weight.text),
          heightCm: double.parse(_height.text),
          age: int.parse(_age.text),
          sex: _sex,
          activity: _activity,
          goal: _goal,
        );
        setState(() => _estimate = estimate);
        await ref
            .read(targetRepositoryProvider)
            .saveEstimate(
              estimate,
              DateTime.now(),
              weightKg: double.parse(_weight.text),
              heightCm: double.parse(_height.text),
              age: int.parse(_age.text),
              sex: _sex,
              activity: _activity,
              goal: _goal,
            );
      }
      if (mounted) setState(() => _step = 3);
    });
  }

  Future<void> _saveKey() async {
    await _run(() async {
      final secret = _secret.text.trim();
      if (secret.isEmpty) throw const FormatException('API key wajib diisi');
      final id = await ref
          .read(apiKeyAdminRepositoryProvider)
          .add(alias: _alias.text, secret: secret);
      if (_testKey) {
        final result = await ref
            .read(geminiClientProvider)
            .parseFood(
              secret: secret,
              input: '1 telur rebus',
              repairAttempt: false,
            );
        final health = result is GeminiCallSuccess
            ? ApiKeyHealth.healthy
            : _healthFromFailure(
                (result as GeminiCallFailure).failure.category,
              );
        await ref.read(apiKeyAdminRepositoryProvider).updateHealth(id, health);
      }
      _secret.clear();
      if (mounted) setState(() => _step = 4);
    });
  }

  ApiKeyHealth _healthFromFailure(dynamic category) {
    final name = category.toString();
    if (name.contains('invalidKey')) return ApiKeyHealth.invalid;
    if (name.contains('permission')) return ApiKeyHealth.blocked;
    if (name.contains('rateLimit')) return ApiKeyHealth.limited;
    if (name.contains('transient') || name.contains('timeout')) {
      return ApiKeyHealth.transientError;
    }
    return ApiKeyHealth.untested;
  }

  Future<void> _saveReminder() async {
    await _run(() async {
      await ref
          .read(reminderRepositoryProvider)
          .configure(
            enabled: _enableReminder,
            hour: _reminderTime.hour,
            minute: _reminderTime.minute,
            thresholdPercent: ProviderConfig.reminderDefaultThresholdPercent,
          );
      if (mounted) setState(() => _step = 5);
    });
  }

  Future<void> _complete() async {
    await _run(() async {
      await ref
          .read(settingsRepositoryProvider)
          .completeOnboarding(displayName: _name.text);
      if (mounted) context.go(AppRoutes.home);
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on FormatException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } on Object {
      if (mounted) {
        setState(() => _error = 'Tindakan belum berhasil. Coba lagi.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _confirmExtreme(int value) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('TINJAU TARGET'),
            content: Text(
              '$value kcal berada di luar rentang umum prototipe. Ini bukan penilaian medis.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('UBAH'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('SIMPAN'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _pickReminderTime() async {
    final value = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (value != null) setState(() => _reminderTime = value);
  }

  void _showPrivacy() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('PRIVASI KEYSPACE'),
        content: const Text(
          'Data makanan dan profil disimpan di perangkat. Hanya teks makanan yang Anda kirim melalui Chat diteruskan langsung ke Gemini. KeySpace tidak memiliki backend atau akun pengguna.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('MENGERTI'),
          ),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  const _Value({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}
