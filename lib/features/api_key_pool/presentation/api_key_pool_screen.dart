import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class ApiKeyPoolScreen extends ConsumerStatefulWidget {
  const ApiKeyPoolScreen({super.key, this.returnToPending = false});

  final bool returnToPending;

  @override
  ConsumerState<ApiKeyPoolScreen> createState() => _ApiKeyPoolScreenState();
}

class _ApiKeyPoolScreenState extends ConsumerState<ApiKeyPoolScreen> {
  String? _testingKeyId;
  RequestCancellation? _testCancellation;

  @override
  void dispose() {
    _testCancellation?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keys = ref.watch(apiKeysStreamProvider);
    final activeId = ref.watch(settingsStreamProvider).value?.activeKeyId;
    final ink = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(title: const Text('API KEY POOL')),
      // ── Brutal FAB ──────────────────────────────────────────────
      floatingActionButton: _testingKeyId != null
          ? null
          : Padding(
              padding: const EdgeInsets.only(right: 4, bottom: 4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: KeySpaceColors.signalYellow,
                  border: Border.all(color: ink, width: 3),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: ink, offset: const Offset(4, 4))],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: _add,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: ink, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'TAMBAH KEY',
                            style: GoogleFonts.spaceGrotesk(
                              color: ink,
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
      body: keys.when(
        data: (values) => values.isEmpty
            ? ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  EmptyState(
                    title: 'BELUM ADA API KEY',
                    message:
                        'Fitur lokal tetap berjalan. Tambahkan key milik Anda untuk memakai chat AI.',
                    icon: Icons.key_off_outlined,
                    action: BrutalButton(
                      label: 'TAMBAH API KEY',
                      icon: Icons.key,
                      onPressed: _testingKeyId == null ? _add : null,
                    ),
                  ),
                ],
              )
            : ReorderableListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: values.length,
                onReorderItem: (oldIndex, newIndex) async {
                  final ids = values.map((item) => item.id).toList();
                  final moved = ids.removeAt(oldIndex);
                  ids.insert(newIndex, moved);
                  await ref.read(apiKeyAdminRepositoryProvider).reorder(ids);
                },
                itemBuilder: (context, index) {
                  final key = values[index];
                  return Padding(
                    key: ValueKey(key.id),
                    padding: const EdgeInsets.only(bottom: 14),
                    child: BrutalCard(
                      delay: Duration(milliseconds: 50 + index * 60),
                      child: Column(
                        children: [
                          // ── Header row ─────────────────────────
                          Row(
                            children: [
                              const BrutalGripHandle(),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      key.alias,
                                      style: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                    ExcludeSemantics(
                                      child: Text(
                                        key.maskedSuffix,
                                        style: GoogleFonts.ibmPlexMono(
                                          fontSize: 13,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withValues(alpha: 0.6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _badge(key.healthStatus),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 2,
                            color: ink.withValues(alpha: 0.12),
                          ),
                          const SizedBox(height: 8),
                          // ── Enable toggle row ─────────────────
                          Row(
                            children: [
                              Expanded(
                                child: SwitchListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    key.isEnabled ? 'AKTIF' : 'NONAKTIF',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  value: key.isEnabled,
                                  onChanged: (value) => ref
                                      .read(apiKeyAdminRepositoryProvider)
                                      .setEnabled(key.id, value),
                                ),
                              ),
                              if (activeId == key.id)
                                const StatusBadge(
                                  label: 'Active Key',
                                  icon: Icons.star,
                                  color: KeySpaceColors.signalYellow,
                                  pulse: true,
                                )
                              else
                                TextButton(
                                  onPressed: key.isEnabled
                                      ? () => ref
                                            .read(apiKeyAdminRepositoryProvider)
                                            .setActive(key.id)
                                      : null,
                                  child: const Text('JADIKAN ACTIVE'),
                                ),
                            ],
                          ),
                          // ── Action row ────────────────────────
                          Row(
                            children: [
                              _ActionBtn(
                                icon: _testingKeyId == key.id
                                    ? null
                                    : Icons.science_outlined,
                                label: _testingKeyId == key.id
                                    ? 'MENGUJI'
                                    : 'TES',
                                loading: _testingKeyId == key.id,
                                onPressed: _testingKeyId == null
                                    ? () => _testById(key.id)
                                    : null,
                              ),
                              _ActionBtn(
                                icon: Icons.edit_outlined,
                                label: 'EDIT',
                                onPressed: _testingKeyId == null
                                    ? () => _edit(key)
                                    : null,
                              ),
                              const Spacer(),
                              IconButton(
                                tooltip: 'Hapus API Key',
                                onPressed: _testingKeyId == null
                                    ? () => _delete(key)
                                    : null,
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: KeySpaceColors.error,
                                ),
                              ),
                            ],
                          ),
                          // ── Stats row ─────────────────────────
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: ink.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                _StatChip(
                                  icon: Icons.check_circle_outline,
                                  label: '${key.successCount} sukses',
                                  color: KeySpaceColors.healthy,
                                ),
                                const SizedBox(width: 12),
                                _StatChip(
                                  icon: Icons.cancel_outlined,
                                  label: '${key.failureCount} gagal',
                                  color: KeySpaceColors.error,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: BrutalProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('Metadata API key belum dapat dibuka.')),
      ),
    );
  }

  StatusBadge _badge(String status) => switch (status) {
    'healthy' => const StatusBadge(
      label: 'SEHAT',
      icon: Icons.check_circle,
      color: KeySpaceColors.healthy,
      pulse: true,
    ),
    'limited' => const StatusBadge(
      label: 'LIMIT',
      icon: Icons.hourglass_top,
      color: KeySpaceColors.limited,
    ),
    'invalid' => const StatusBadge(
      label: 'INVALID',
      icon: Icons.error,
      color: KeySpaceColors.error,
      shake: true,
    ),
    'blocked' => const StatusBadge(
      label: 'DIBLOKIR',
      icon: Icons.block,
      color: KeySpaceColors.error,
      shake: true,
    ),
    'transient_error' => const StatusBadge(
      label: 'GANGGUAN',
      icon: Icons.cloud_off,
      color: KeySpaceColors.warning,
    ),
    _ => const StatusBadge(
      label: 'BELUM DITES',
      icon: Icons.help_outline,
      color: KeySpaceColors.neutral,
    ),
  };

  Future<void> _add() async {
    final repository = ref.read(apiKeyAdminRepositoryProvider);
    final value = await _keyDialog(context, title: 'TAMBAH API KEY');
    if (!mounted || value == null) return;
    try {
      final id = await repository.add(alias: value.$1, secret: value.$2);
      if (!mounted) return;
      if (value.$3) await _testById(id);
      if (widget.returnToPending && mounted) {
        final messenger = ScaffoldMessenger.of(context);
        context.pop();
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Key tersimpan. Tekan Lanjutkan Pencatatan di Chat.'),
          ),
        );
      }
    } on Object {
      if (mounted) _error('API key belum berhasil disimpan.');
    }
  }

  Future<void> _edit(ApiKeyMetadataData key) async {
    final repository = ref.read(apiKeyAdminRepositoryProvider);
    final value = await _keyDialog(
      context,
      title: 'EDIT API KEY',
      alias: key.alias,
      replacement: true,
    );
    if (!mounted || value == null) return;
    try {
      await repository.edit(
        id: key.id,
        alias: value.$1,
        replacementSecret: value.$2.trim().isEmpty ? null : value.$2,
      );
      if (!mounted) return;
      if (value.$3) await _testById(key.id);
    } on Object {
      if (mounted) {
        _error('Perubahan API key belum berhasil disimpan.');
      }
    }
  }

  Future<void> _delete(ApiKeyMetadataData key) async {
    final repository = ref.read(apiKeyAdminRepositoryProvider);
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('HAPUS API KEY?'),
            content: Text(
              '${key.alias} akan dihapus dari secure storage dan metadata lokal.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('BATAL'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('HAPUS'),
              ),
            ],
          ),
        ) ??
        false;
    if (!mounted || !confirmed) return;
    await repository.delete(key.id);
  }

  Future<void> _testById(String id) async {
    if (_testingKeyId != null) return;
    final service = ref.read(apiKeyTestServiceProvider);
    final cancellation = RequestCancellation();
    setState(() {
      _testingKeyId = id;
      _testCancellation = cancellation;
    });
    try {
      final result = await service.test(id, cancellation: cancellation);
      if (!mounted) return;
      final message = result.isSuccess
          ? 'API key siap digunakan.'
          : _testFailureMessage(result.failureCategory!);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } on Object catch (error, stackTrace) {
      debugPrint('Gemini API key test failed: ${error.runtimeType}');
      debugPrintStack(stackTrace: stackTrace);
      if (!mounted) return;
      _error('Pengujian Gemini API gagal.');
    } finally {
      if (mounted && _testingKeyId == id) {
        setState(() {
          _testingKeyId = null;
          _testCancellation = null;
        });
      }
    }
  }

  String _testFailureMessage(GeminiFailureCategory category) =>
      switch (category) {
        GeminiFailureCategory.invalidKey =>
          'API key tidak valid. Periksa kembali key yang dimasukkan.',
        GeminiFailureCategory.permission =>
          'Akses Gemini ditolak. Periksa pembatasan dan izin API key.',
        GeminiFailureCategory.rateLimit =>
          'Kuota atau batas request Gemini tercapai. Coba lagi nanti.',
        GeminiFailureCategory.offline =>
          'Tidak ada koneksi internet. Periksa jaringan lalu coba lagi.',
        GeminiFailureCategory.timeout =>
          'Gemini tidak merespons tepat waktu. Coba lagi.',
        GeminiFailureCategory.requestInvalid =>
          'Format request Gemini tidak didukung. Perbarui aplikasi.',
        GeminiFailureCategory.modelNotFound =>
          'Endpoint atau model Gemini tidak ditemukan. Perbarui aplikasi.',
        GeminiFailureCategory.transientServer =>
          'Layanan Gemini sedang bermasalah. Coba lagi nanti.',
        GeminiFailureCategory.safetyBlock =>
          'Tes diblokir oleh filter keamanan Gemini.',
        GeminiFailureCategory.schemaMismatch =>
          'Respons Gemini tidak sesuai format yang diharapkan.',
        GeminiFailureCategory.secretUnavailable =>
          'Secret key tidak tersedia di penyimpanan aman.',
        GeminiFailureCategory.cancelled => 'Tes API key dibatalkan.',
        GeminiFailureCategory.unknown =>
          'Tes Gemini gagal karena kesalahan yang tidak dikenal.',
      };

  Future<(String, String, bool)?> _keyDialog(
    BuildContext context, {
    required String title,
    String alias = '',
    bool replacement = false,
  }) async {
    final aliasController = TextEditingController(text: alias);
    final secretController = TextEditingController();
    var test = true;
    final result = await showDialog<(String, String, bool)>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: aliasController,
                decoration: const InputDecoration(labelText: 'Alias'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: secretController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: replacement
                      ? 'Key baru (kosong = tidak berubah)'
                      : 'API key',
                ),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tes key sekarang'),
                value: test,
                onChanged: (value) => setState(() => test = value ?? true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('BATAL'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, (
                aliasController.text,
                secretController.text,
                test,
              )),
              child: const Text('SIMPAN'),
            ),
          ],
        ),
      ),
    );
    aliasController.dispose();
    secretController.dispose();
    return result;
  }

  void _error(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// ─────────────────────────────────────────────────────────────
// _ActionBtn — compact action button for key cards
// ─────────────────────────────────────────────────────────────

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: loading
          ? const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon, size: 16),
      label: Text(label),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        minimumSize: const Size(0, 36),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// _StatChip — small stat indicator
// ─────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
