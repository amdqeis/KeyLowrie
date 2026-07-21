import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/theme/keyspace_theme.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

class ApiKeyPoolScreen extends ConsumerWidget {
  const ApiKeyPoolScreen({super.key, this.returnToPending = false});

  final bool returnToPending;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keys = ref.watch(apiKeysStreamProvider);
    final activeId = ref.watch(settingsStreamProvider).value?.activeKeyId;
    return Scaffold(
      appBar: AppBar(title: const Text('API KEY POOL')),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: KeySpaceColors.ink, width: 3),
        ),
        backgroundColor: KeySpaceColors.signalYellow,
        foregroundColor: KeySpaceColors.ink,
        onPressed: () => _add(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('TAMBAH KEY'),
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
                    action: BrutalButton(
                      label: 'TAMBAH API KEY',
                      icon: Icons.key,
                      onPressed: () => _add(context, ref),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.drag_handle),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      key.alias,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    ExcludeSemantics(
                                      child: Text(
                                        key.maskedSuffix,
                                        style: const TextStyle(
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _badge(key.healthStatus),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: SwitchListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    key.isEnabled ? 'Aktif' : 'Nonaktif',
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
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () => _test(context, ref, key),
                                icon: const Icon(Icons.science_outlined),
                                label: const Text('TES'),
                              ),
                              TextButton.icon(
                                onPressed: () => _edit(context, ref, key),
                                icon: const Icon(Icons.edit),
                                label: const Text('EDIT'),
                              ),
                              const Spacer(),
                              IconButton(
                                tooltip: 'Hapus API Key',
                                onPressed: () => _delete(context, ref, key),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                          Text(
                            'Sukses ${key.successCount} • Gagal ${key.failureCount}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('Metadata API key belum dapat dibuka.')),
      ),
    );
  }

  StatusBadge _badge(String status) => switch (status) {
    'healthy' => const StatusBadge(
      label: 'Sehat',
      icon: Icons.check_circle,
      color: KeySpaceColors.healthy,
    ),
    'limited' => const StatusBadge(
      label: 'Terbatas',
      icon: Icons.hourglass_top,
      color: KeySpaceColors.limited,
    ),
    'invalid' => const StatusBadge(
      label: 'Tidak valid',
      icon: Icons.error,
      color: KeySpaceColors.error,
    ),
    'blocked' => const StatusBadge(
      label: 'Diblokir',
      icon: Icons.block,
      color: KeySpaceColors.error,
    ),
    'transient_error' => const StatusBadge(
      label: 'Gangguan',
      icon: Icons.cloud_off,
      color: KeySpaceColors.warning,
    ),
    _ => const StatusBadge(
      label: 'Belum dites',
      icon: Icons.help_outline,
      color: KeySpaceColors.neutral,
    ),
  };

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final value = await _keyDialog(context, title: 'TAMBAH API KEY');
    if (value == null) return;
    try {
      final id = await ref
          .read(apiKeyAdminRepositoryProvider)
          .add(alias: value.$1, secret: value.$2);
      if (!context.mounted) return;
      if (value.$3) await _testById(context, ref, id);
      if (returnToPending && context.mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Key tersimpan. Tekan Lanjutkan Pencatatan di Chat.'),
          ),
        );
      }
    } on Object {
      if (context.mounted) _error(context, 'API key belum berhasil disimpan.');
    }
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    ApiKeyMetadataData key,
  ) async {
    final value = await _keyDialog(
      context,
      title: 'EDIT API KEY',
      alias: key.alias,
      replacement: true,
    );
    if (value == null) return;
    try {
      await ref
          .read(apiKeyAdminRepositoryProvider)
          .edit(
            id: key.id,
            alias: value.$1,
            replacementSecret: value.$2.trim().isEmpty ? null : value.$2,
          );
      if (!context.mounted) return;
      if (value.$3) await _testById(context, ref, key.id);
    } on Object {
      if (context.mounted) {
        _error(context, 'Perubahan API key belum berhasil disimpan.');
      }
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    ApiKeyMetadataData key,
  ) async {
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
    if (confirmed) await ref.read(apiKeyAdminRepositoryProvider).delete(key.id);
  }

  Future<void> _test(
    BuildContext context,
    WidgetRef ref,
    ApiKeyMetadataData key,
  ) => _testById(context, ref, key.id);

  Future<void> _testById(BuildContext context, WidgetRef ref, String id) async {
    final secret = await ref.read(apiKeyAdminRepositoryProvider).readSecret(id);
    if (secret == null || secret.isEmpty) {
      await ref
          .read(apiKeyAdminRepositoryProvider)
          .updateHealth(id, ApiKeyHealth.secretUnavailable);
      if (context.mounted) _error(context, 'Secret key tidak tersedia.');
      return;
    }
    final result = await ref
        .read(geminiClientProvider)
        .parseFood(
          secret: secret,
          input: '1 telur rebus',
          repairAttempt: false,
        );
    final health = result is GeminiCallSuccess
        ? ApiKeyHealth.healthy
        : _health((result as GeminiCallFailure).failure.category);
    await ref.read(apiKeyAdminRepositoryProvider).updateHealth(id, health);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            health == ApiKeyHealth.healthy
                ? 'API key siap digunakan.'
                : 'Tes selesai: ${health.name}.',
          ),
        ),
      );
    }
  }

  ApiKeyHealth _health(GeminiFailureCategory category) => switch (category) {
    GeminiFailureCategory.invalidKey => ApiKeyHealth.invalid,
    GeminiFailureCategory.permission => ApiKeyHealth.blocked,
    GeminiFailureCategory.rateLimit => ApiKeyHealth.limited,
    GeminiFailureCategory.transientServer ||
    GeminiFailureCategory.timeout => ApiKeyHealth.transientError,
    GeminiFailureCategory.secretUnavailable => ApiKeyHealth.secretUnavailable,
    _ => ApiKeyHealth.untested,
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

  void _error(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
