import 'dart:async';

import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/bootstrap.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>((
  ref,
  date,
) {
  final database = ref.watch(databaseProvider);
  return (database.select(database.chatMessages)
        ..where((row) => row.sessionId.equals('session-$date'))
        ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
      .watch();
});

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _composer = TextEditingController();
  final _scroll = ScrollController();
  var _consumedAt = DateTime.now();
  var _mealType = 'lainnya';
  String? _requestId;
  String? _draftId;
  ParsedFoodDraft? _preview;
  String? _status;
  bool _requesting = false;
  Timer? _draftTimer;
  RequestCancellation? _cancellation;

  @override
  void initState() {
    super.initState();
    _composer.addListener(_scheduleDraftSave);
    WidgetsBinding.instance.addPostFrameCallback((_) => _restoreLatestDraft());
  }

  @override
  void dispose() {
    _draftTimer?.cancel();
    _cancellation?.cancel();
    _composer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = localDateKey(_consumedAt);
    final messages = ref.watch(chatMessagesProvider(date));
    final keys =
        ref.watch(apiKeysStreamProvider).value ?? const <ApiKeyMetadataData>[];
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHAT MAKANAN'),
        actions: [
          IconButton(
            tooltip: 'Kelola API Key',
            onPressed: () => context.push(AppRoutes.apiKeys),
            icon: const Icon(Icons.key),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.when(
              data: (values) => ListView(
                controller: _scroll,
                padding: const EdgeInsets.all(16),
                children: [
                  if (keys.isEmpty)
                    EmptyState(
                      title: 'API KEY BELUM ADA',
                      message:
                          'Tambahkan key untuk memakai AI, atau catat makanan secara manual.',
                      action: BrutalButton(
                        label: 'TAMBAH API KEY',
                        icon: Icons.key,
                        onPressed: () => context.push(AppRoutes.apiKeys),
                      ),
                    ),
                  ...values.map(_bubble),
                  if (_preview != null) _previewCard(),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text('Riwayat chat belum dapat dibuka.')),
            ),
          ),
          if (_status != null)
            Semantics(
              liveRegion: true,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE79A),
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  _status!.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          _composerArea(),
        ],
      ),
    );
  }

  Widget _bubble(ChatMessage message) {
    final user = message.role == 'user';
    return Align(
      alignment: user ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: user
              ? const Color(0xFFFFD60A)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.contentText),
            const SizedBox(height: 6),
            Text(
              message.status.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewCard() {
    final draft = _preview!;
    return BrutalCard(
      color: const Color(0xFFFFE79A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'PREVIEW — TINJAU DULU',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              if (draft.needsUserReview)
                const StatusBadge(
                  label: 'Perlu tinjau',
                  icon: Icons.visibility,
                  color: Color(0xFFFFA62B),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...draft.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Text('${item.caloriesKcal.round()} kkal'),
                ],
              ),
            ),
          ),
          const Divider(),
          Text(
            'TOTAL ${draft.totalCaloriesKcal.round()} KKAL',
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          if (draft.providerTotalDifferenceKcal.abs() > 1)
            Text(
              'Total dihitung ulang; selisih provider ${draft.providerTotalDifferenceKcal.toStringAsFixed(1)} kkal.',
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: BrutalButton(
                  label: 'EDIT',
                  icon: Icons.edit,
                  secondary: true,
                  onPressed: _editPreview,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: BrutalButton(
                  label: 'SIMPAN',
                  icon: Icons.save,
                  onPressed: _savePreview,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          BrutalButton(
            label: 'PROSES ULANG',
            icon: Icons.refresh,
            secondary: true,
            onPressed: _requesting ? null : _send,
          ),
        ],
      ),
    );
  }

  Widget _composerArea() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        10,
        12,
        10 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 3,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              TextButton.icon(
                onPressed: _pickDateTime,
                icon: const Icon(Icons.schedule),
                label: Text(
                  '${localDateKey(_consumedAt)} ${_time(_consumedAt)}',
                ),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: _mealType,
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
                onChanged: _requesting
                    ? null
                    : (value) => setState(() => _mealType = value ?? _mealType),
              ),
            ],
          ),
          TextField(
            controller: _composer,
            enabled: !_requesting,
            maxLength: ProviderConfig.chatInputMaxCharacters,
            minLines: 1,
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              labelText: 'Ceritakan makanan Anda',
              hintText: 'Contoh: nasi goreng dan es teh',
              suffixIcon: _requesting
                  ? IconButton(
                      tooltip: 'Batalkan request',
                      onPressed: _cancel,
                      icon: const Icon(Icons.stop),
                    )
                  : IconButton(
                      tooltip: 'Kirim',
                      onPressed: _send,
                      icon: const Icon(Icons.send),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _manualFallback,
              icon: const Icon(Icons.edit_note),
              label: const Text('CATAT MANUAL'),
            ),
          ),
        ],
      ),
    );
  }

  void _scheduleDraftSave() {
    _draftTimer?.cancel();
    if (_composer.text.trim().isEmpty || _requesting) return;
    _requestId ??= ref.read(requestIdProvider)();
    _draftTimer = Timer(const Duration(milliseconds: 400), () async {
      final id = await ref
          .read(foodLogRepositoryProvider)
          .createDraft(
            requestId: _requestId!,
            input: _composer.text,
            consumedAt: _consumedAt,
            mealType: _mealType,
          );
      if (mounted) setState(() => _draftId = id);
    });
  }

  Future<void> _restoreLatestDraft() async {
    final drafts = ref.read(pendingDraftsProvider).value;
    if (drafts == null || drafts.isEmpty || _composer.text.isNotEmpty) return;
    final draft = drafts.first;
    setState(() {
      _requestId = draft.localRequestId;
      _draftId = draft.id;
      _composer.text = draft.originalUserText ?? '';
      _consumedAt = draft.consumedAtUtc.toLocal();
      _mealType = draft.mealType;
      _status = 'Draft lokal dipulihkan';
    });
  }

  Future<void> _send() async {
    final input = _composer.text.trim();
    if (input.isEmpty) {
      setState(() => _status = 'Input tidak boleh kosong');
      return;
    }
    _requestId ??= ref.read(requestIdProvider)();
    _draftId = await ref
        .read(foodLogRepositoryProvider)
        .createDraft(
          requestId: _requestId!,
          input: input,
          consumedAt: _consumedAt,
          mealType: _mealType,
        );
    _cancellation = RequestCancellation();
    setState(() {
      _requesting = true;
      _status = 'Memproses dengan Gemini';
      _preview = null;
    });
    final result = await ref
        .read(geminiFailoverServiceProvider)
        .parseFood(input, requestId: _requestId, cancellation: _cancellation);
    if (!mounted) return;
    if (result is ParseFoodSuccess) {
      await ref
          .read(foodLogRepositoryProvider)
          .applyParsedDraft(
            requestId: result.requestId!,
            draft: result.draft,
            keyId: result.keyId,
          );
      setState(() {
        _preview = result.draft;
        _status = 'Preview siap — tinjau sebelum simpan';
      });
    } else if (result is AllKeysFailed) {
      setState(() => _status = 'Semua API key belum dapat digunakan');
      await _showAllKeysFailed();
    } else if (result is OfflineFailure) {
      setState(() => _status = 'Offline — input tetap tersimpan');
    } else if (result is ContentNeedsRevision) {
      setState(() => _status = 'Input perlu diubah agar dapat diproses');
    } else if (result is CancelledFailure) {
      setState(() => _status = 'Request dibatalkan — input tetap tersimpan');
    } else {
      setState(
        () => _status = 'Hasil belum dapat diproses — input tetap tersimpan',
      );
    }
    setState(() => _requesting = false);
  }

  void _cancel() {
    _cancellation?.cancel();
    setState(() => _status = 'Membatalkan request…');
  }

  Future<void> _savePreview() async {
    if (_draftId == null) return;
    await ref.read(foodLogRepositoryProvider).confirmDraft(_draftId!);
    await ref
        .read(reminderCoordinatorProvider)
        .reconcileDate(localDateKey(_consumedAt));
    if (!mounted) return;
    setState(() {
      _preview = null;
      _status = 'Food Log tersimpan';
      _composer.clear();
      _requestId = null;
      _draftId = null;
    });
  }

  void _editPreview() {
    if (_draftId != null) context.push('/food-log/${_draftId!}/edit');
  }

  void _manualFallback() {
    if (_draftId != null) {
      context.push('/food-log/${_draftId!}/edit');
    } else {
      context.push('/food-log/new/edit?date=${localDateKey(_consumedAt)}');
    }
  }

  Future<void> _showAllKeysFailed() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('SEMUA API KEY GAGAL'),
        content: const Text(
          'Input tetap tersimpan. Tambahkan key baru atau lanjutkan secara manual.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.push(
                '${AppRoutes.apiKeys}?returnTo=pendingRequest&pendingRequestId=$_requestId',
              );
            },
            child: const Text('TAMBAH API KEY'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.push(AppRoutes.apiKeys);
            },
            child: const Text('KELOLA'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _send();
            },
            child: const Text('COBA LAGI'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _manualFallback();
            },
            child: const Text('CATAT MANUAL'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _consumedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_consumedAt),
    );
    if (time != null) {
      setState(
        () => _consumedAt = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ),
      );
      _scheduleDraftSave();
    }
  }

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}
