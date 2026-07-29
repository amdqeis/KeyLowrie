import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
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
    final ink = Theme.of(context).colorScheme.onSurface;
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(12),
                child: _StepBar(currentStep: _step, totalSteps: 5, ink: ink),
              ),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),
            transitionBuilder: (child, animation) {
              final slide =
                  Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: Column(
              key: ValueKey(_step),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _content(),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  BrutalCard(
                    animate: false,
                    color: KeySpaceColors.error.withValues(alpha: 0.12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: KeySpaceColors.error,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _error!,
                            style: GoogleFonts.spaceGrotesk(
                              color: KeySpaceColors.error,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
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
        const SizedBox(height: 52),
        // Brand mark
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              color: KeySpaceColors.signalYellow,
            ),
            const SizedBox(width: 8),
            Text(
              'KEYSPACE',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Staggered headline
        _StaggeredHeadline(lines: const ['CATAT MAKANAN', 'CUKUP LEWAT CHAT']),
        const SizedBox(height: 32),
        // Value prop card
        BrutalCard(
          color: KeySpaceColors.signalYellow,
          delay: const Duration(milliseconds: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Value(
                icon: Icons.phone_android,
                text: 'DATA TERSIMPAN DI PERANGKAT',
                delay: const Duration(milliseconds: 450),
              ),
              const SizedBox(height: 14),
              _Value(
                icon: Icons.person_off_outlined,
                text: 'TANPA LOGIN ATAU AKUN',
                delay: const Duration(milliseconds: 520),
              ),
              const SizedBox(height: 14),
              _Value(
                icon: Icons.lock_outline,
                text: 'API KEY DI SECURE STORAGE',
                delay: const Duration(milliseconds: 590),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        BrutalButton(
          label: 'MULAI SETUP',
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
          'Tekan Buka Hari Ini untuk mulai. Semua fitur lokal tetap bekerja tanpa API key.',
      children: [
        BrutalCard(
          color: KeySpaceColors.signalYellow,
          child: Column(
            children: [
              const Icon(Icons.check_circle_outline, size: 64),
              const SizedBox(height: 8),
              Text(
                'SETUP SELESAI',
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
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
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onSurface,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 24),
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
      if (!mounted) return;
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
        if (!mounted) return;
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
    final repository = ref.read(apiKeyAdminRepositoryProvider);
    final tester = ref.read(apiKeyTestServiceProvider);
    await _run(() async {
      final secret = _secret.text.trim();
      if (secret.isEmpty) throw const FormatException('API key wajib diisi');
      final id = await repository.add(alias: _alias.text, secret: secret);
      if (!mounted) return;
      if (_testKey) {
        await tester.test(id);
      }
      if (!mounted) return;
      _secret.clear();
      setState(() => _step = 4);
    });
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
    if (_busy) return;
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
    if (mounted && value != null) setState(() => _reminderTime = value);
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

class _Value extends StatefulWidget {
  const _Value({
    required this.icon,
    required this.text,
    this.delay = Duration.zero,
  });

  final IconData icon;
  final String text;
  final Duration delay;

  @override
  State<_Value> createState() => _ValueState();
}

class _ValueState extends State<_Value> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(-0.08, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: KeySpaceColors.ink.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(widget.icon, size: 18, color: KeySpaceColors.ink),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.text,
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: KeySpaceColors.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// _StaggeredHeadline
// ─────────────────────────────────────────────────────────────

class _StaggeredHeadline extends StatefulWidget {
  const _StaggeredHeadline({required this.lines});
  final List<String> lines;

  @override
  State<_StaggeredHeadline> createState() => _StaggeredHeadlineState();
}

class _StaggeredHeadlineState extends State<_StaggeredHeadline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<Animation<double>> _opacities;
  late final List<Animation<Offset>> _slides;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200 + widget.lines.length * 160),
    );
    final count = widget.lines.length;
    _opacities = List.generate(count, (i) {
      final start = i / (count + 1);
      final end = (i + 1) / (count + 1);
      return CurvedAnimation(
        parent: _ctrl,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });
    _slides = List.generate(count, (i) {
      final start = i / (count + 1);
      final end = (i + 1) / (count + 1);
      return Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.lines.asMap().entries.map((e) {
            return FadeTransition(
              opacity: _opacities[e.key],
              child: SlideTransition(
                position: _slides[e.key],
                child: Text(
                  e.value,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// _StepBar — brutalist step progress indicator
// ─────────────────────────────────────────────────────────────

class _StepBar extends StatelessWidget {
  const _StepBar({
    required this.currentStep,
    required this.totalSteps,
    required this.ink,
  });
  final int currentStep;
  final int totalSteps;
  final Color ink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: List.generate(totalSteps, (i) {
          final isActive = i < currentStep;
          final isCurrent = i == currentStep - 1;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < totalSteps - 1 ? 4 : 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive || isCurrent
                      ? KeySpaceColors.signalYellow
                      : ink.withValues(alpha: 0.12),
                  border: Border.all(color: ink, width: 1.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
