import 'dart:async';

import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/bootstrap.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/core/errors/gemini_failure.dart';
import 'package:keyspace/core/network/request_cancellation.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/finance/domain/finance_models.dart';
import 'package:keyspace/features/food_chat/domain/chat_input_models.dart';
import 'package:keyspace/features/food_chat/domain/financial_review_models.dart';
import 'package:keyspace/features/food_chat/domain/food_parse_models.dart';
import 'package:keyspace/features/food_chat/domain/unified_chat_models.dart';
import 'package:keyspace/features/scheduler/domain/schedule_models.dart';
import 'package:keyspace/features/voice_input/application/voice_input_controller.dart';
import 'package:keyspace/features/voice_input/domain/voice_input_models.dart';
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

/// Mode tampilan area chat:
/// - [input] — composer tampil normal, auto-scroll aktif saat di bawah
/// - [reading] — composer diciutkan, auto-scroll dinonaktifkan, badge pesan baru
enum ChatViewportMode { input, reading }

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _composer = TextEditingController();
  final _composerFocus = FocusNode();
  final _scroll = ScrollController();
  late final VoiceInputController _voice;
  var _consumedAt = DateTime.now();
  var _mealType = 'lainnya';
  String? _requestId;
  String? _foodDraftId;
  String? _chatDraftId;
  ParsedFoodDraft? _preview;
  List<FinancialReviewItem>? _financialPreview;
  ScheduleDraft? _schedulePreview;
  double? _financialConfidence;
  List<FinancialReviewCategory> _reviewCategories = const [];
  ChatInputMode _selectedMode = ChatInputMode.automatic;
  bool _defaultReimburse = false;
  String? _status;

  /// Jenis status terakhir untuk pewarnaan banner.
  /// null = normal/info, ambiguousInput = oranye, technicalError = merah.
  ParseChatFailureKind? _statusKind;
  bool _requesting = false;
  Timer? _draftTimer;
  RequestCancellation? _cancellation;

  // ── Mode Baca ────────────────────────────────────────────────────────────
  ChatViewportMode _viewportMode = ChatViewportMode.input;
  bool _isNearBottom = true;
  int _unreadCount = 0;
  int _previousMessageCount = 0;

  /// Threshold jarak dari bawah (px) untuk dianggap 'near bottom'.
  static const _nearBottomThreshold = 100.0;

  @override
  void initState() {
    super.initState();
    _voice = VoiceInputController(
      service: ref.read(speechRecognitionServiceProvider),
      onTranscript: _applyVoiceTranscript,
    )..addListener(_handleVoiceState);
    _composer.addListener(_scheduleDraftSave);
    _scroll.addListener(_onScrollChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _restoreLatestDraft());
  }

  @override
  void dispose() {
    _draftTimer?.cancel();
    _cancellation?.cancel();
    _scroll.removeListener(_onScrollChanged);
    _voice
      ..removeListener(_handleVoiceState)
      ..dispose();
    _composer.dispose();
    _composerFocus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  // ── Scroll tracking ──────────────────────────────────────────────────────

  void _onScrollChanged() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    final distFromBottom = pos.maxScrollExtent - pos.pixels;
    final nearBottom = distFromBottom <= _nearBottomThreshold;
    if (nearBottom != _isNearBottom) {
      if (mounted) setState(() => _isNearBottom = nearBottom);
    }
    // Reset unread badge saat user scroll ke bawah sendiri
    if (nearBottom && _unreadCount > 0) {
      if (mounted) setState(() => _unreadCount = 0);
    }
  }

  void _jumpToLatest() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      _scroll.position.maxScrollExtent,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
    if (mounted) setState(() => _unreadCount = 0);
  }

  // ── Auto scroll (hanya input mode & near bottom) ─────────────────────────

  void _autoScrollIfNeeded() {
    if (!mounted || !_scroll.hasClients) return;
    if (_viewportMode == ChatViewportMode.reading || !_isNearBottom) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  // ── Mode Baca toggle ─────────────────────────────────────────────────────

  Future<void> _setReadingMode(bool reading) async {
    if (reading) {
      // Tutup keyboard
      _composerFocus.unfocus();
      FocusScope.of(context).unfocus();

      // Hentikan voice dengan aman jika sedang aktif
      if (_voice.isActive) {
        final transcript = _composer.text.trim();
        await _voice.cancel();
        if (mounted) {
          setState(() {
            _viewportMode = ChatViewportMode.reading;
            if (transcript.isNotEmpty) {
              _status =
                  'Perekaman dihentikan. Hasil suara disimpan sebagai draft.';
            }
          });
        }
      } else {
        if (mounted) setState(() => _viewportMode = ChatViewportMode.reading);
      }
    } else {
      // Kembali ke mode input — jangan reset scroll, jangan hapus draft
      if (mounted) setState(() => _viewportMode = ChatViewportMode.input);
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = localDateKey(_consumedAt);
    final messages = ref.watch(chatMessagesProvider(date));
    final keys =
        ref.watch(apiKeysStreamProvider).value ?? const <ApiKeyMetadataData>[];

    // Tracking pesan baru saat Mode Baca aktif
    final currentCount = messages.value?.length ?? _previousMessageCount;
    if (_viewportMode == ChatViewportMode.reading &&
        currentCount > _previousMessageCount &&
        _previousMessageCount > 0) {
      // Jadwalkan update agar tidak di dalam build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _unreadCount += currentCount - _previousMessageCount;
            _previousMessageCount = currentCount;
          });
        }
      });
    } else if (currentCount != _previousMessageCount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _previousMessageCount = currentCount);
          // Auto-scroll saat mode input dan near bottom
          _autoScrollIfNeeded();
        }
      });
    }

    final showJumpButton = !_isNearBottom || _unreadCount > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CHAT TERPADU'),
        actions: [
          IconButton(
            tooltip: 'Kelola API Key',
            onPressed: () => context.push(AppRoutes.apiKeys),
            icon: const Icon(Icons.key),
          ),
        ],
      ),
      floatingActionButton: showJumpButton
          ? FloatingActionButton.extended(
              key: const ValueKey('jump-to-latest-btn'),
              onPressed: _jumpToLatest,
              backgroundColor: const Color(0xFFFFD60A),
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              icon: const Icon(Icons.keyboard_arrow_down),
              label: _unreadCount > 0
                  ? Text('↓ $_unreadCount pesan baru')
                  : const Text('↓ Ke pesan terbaru'),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Expanded(
            child: messages.when(
              data: (values) => ListView(
                controller: _scroll,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 72),
                children: [
                  if (keys.isEmpty)
                    EmptyState(
                      title: 'API KEY BELUM ADA',
                      message:
                          'Tambahkan key untuk memakai AI, atau catat secara manual.',
                      action: BrutalButton(
                        label: 'TAMBAH API KEY',
                        icon: Icons.key,
                        onPressed: () => context.push(AppRoutes.apiKeys),
                      ),
                    ),
                  ...values.map(_bubble),
                  if (_preview != null) _previewCard(),
                  if (_financialPreview != null) _financialReviewCard(),
                  if (_schedulePreview != null) _scheduleReviewCard(),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text('Riwayat chat belum dapat dibuka.')),
            ),
          ),
          if (_status != null) _statusBanner(),
          _composerArea(),
        ],
      ),
    );
  }

  /// Banner status dengan warna berdiferensiasi:
  /// - Kuning  (#FFE79A) → info / proses normal
  /// - Oranye  (#FFBD59) → input ambigu / perlu klarifikasi
  /// - Merah   (#FFB3B3) → error teknis API / jaringan
  Widget _statusBanner() {
    final Color bannerColor;
    final Color borderColor;
    final IconData icon;
    final String categoryLabel;

    switch (_statusKind) {
      case ParseChatFailureKind.ambiguousInput:
        bannerColor = const Color(0xFFFFBD59);
        borderColor = const Color(0xFFCC8800);
        icon = Icons.help_outline;
        categoryLabel = 'INPUT AMBIGU';
      case ParseChatFailureKind.technicalError:
        bannerColor = const Color(0xFFFFB3B3);
        borderColor = const Color(0xFFCC3333);
        icon = Icons.error_outline;
        categoryLabel = 'ERROR TEKNIS';
      case null:
        bannerColor = const Color(0xFFFFE79A);
        borderColor = Theme.of(context).colorScheme.onSurface;
        icon = Icons.info_outline;
        categoryLabel = '';
    }

    final isError = _statusKind != null;

    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: bannerColor,
          border: Border(top: BorderSide(color: borderColor, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Label kategori (hanya saat error) ─────────────────────────
            if (isError)
              Row(
                children: [
                  Icon(icon, size: 16, color: borderColor),
                  const SizedBox(width: 6),
                  Text(
                    categoryLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: borderColor,
                    ),
                  ),
                ],
              ),
            if (isError) const SizedBox(height: 4),
            // ── Pesan utama ────────────────────────────────────────────────
            Text(
              // Status info normal ditampilkan uppercase (perilaku asal).
              // Error banner ditampilkan sentence case agar pesan panjang mudah dibaca.
              _statusKind == null ? _status!.toUpperCase() : _status!,
              style: TextStyle(
                fontWeight: isError ? FontWeight.w700 : FontWeight.w900,
                fontSize: 13,
              ),
            ),
            // ── Tombol aksi kontekstual (hanya saat error) ─────────────────
            if (isError) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  if (!_requesting)
                    OutlinedButton.icon(
                      key: const ValueKey('status-retry-btn'),
                      onPressed: _send,
                      style: OutlinedButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        side: BorderSide(color: borderColor, width: 2),
                        foregroundColor: borderColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text(
                        'COBA LAGI',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  if (!_requesting)
                    OutlinedButton.icon(
                      key: const ValueKey('status-manual-btn'),
                      onPressed: _manualFallback,
                      style: OutlinedButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        side: BorderSide(color: borderColor, width: 2),
                        foregroundColor: borderColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      icon: const Icon(Icons.edit_note, size: 16),
                      label: const Text(
                        'CATAT MANUAL',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
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

  Widget _financialReviewCard() {
    final items = _financialPreview!;
    return BrutalCard(
      color: const Color(0xFFBDE0FE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'REVIEW TRANSAKSI — EDIT LANGSUNG',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              if ((_financialConfidence ?? 1) < 0.7)
                const StatusBadge(
                  label: 'Confidence rendah',
                  icon: Icons.visibility,
                  color: Color(0xFFFFA62B),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            const Text('Semua item dihapus. Batalkan atau proses ulang input.'),
          ...items.indexed.map((entry) {
            final index = entry.$1;
            final item = entry.$2;
            final eligibleCategories = _reviewCategories
                .where((category) => category.type == item.type)
                .toList(growable: false);
            return Container(
              key: ValueKey('financial-review-${item.reviewId}'),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 3,
                ),
              ),
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
                      IconButton(
                        tooltip: 'Hapus item ${index + 1}',
                        onPressed: _requesting
                            ? null
                            : () => _removeFinancialItem(item.reviewId),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  DropdownButtonFormField<FinancialTransactionType>(
                    key: ValueKey('review-type-${item.reviewId}'),
                    initialValue: item.type,
                    decoration: const InputDecoration(labelText: 'Tipe'),
                    items: FinancialTransactionType.values
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              type == FinancialTransactionType.expense
                                  ? 'Pengeluaran'
                                  : 'Pemasukan',
                            ),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: _requesting
                        ? null
                        : (type) {
                            if (type != null) {
                              _convertFinancialType(item.reviewId, type);
                            }
                          },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: ValueKey('review-name-${item.reviewId}'),
                    initialValue: item.name,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    onChanged: (value) => _updateFinancialItem(
                      item.reviewId,
                      (current) => current.copyWith(name: value),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: ValueKey('review-amount-${item.reviewId}'),
                    initialValue: item.amount > 0 ? item.amount.toString() : '',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'Nominal (IDR)',
                      prefixText: 'Rp ',
                    ),
                    onChanged: (value) => _updateFinancialItem(
                      item.reviewId,
                      (current) =>
                          current.copyWith(amount: int.tryParse(value) ?? 0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    key: ValueKey('review-date-${item.reviewId}'),
                    onPressed: () => _pickFinancialDate(item),
                    icon: const Icon(Icons.calendar_month),
                    label: Text(localDateKey(item.transactionDate)),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    key: ValueKey(
                      'review-category-${item.reviewId}-${item.type.name}',
                    ),
                    initialValue: item.categoryId,
                    decoration: const InputDecoration(labelText: 'Kategori'),
                    items: eligibleCategories
                        .map(
                          (category) => DropdownMenuItem(
                            value: category.id,
                            child: Text(category.name),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (categoryId) {
                      if (categoryId != null) {
                        _changeFinancialCategory(item.reviewId, categoryId);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    key: ValueKey('review-notes-${item.reviewId}'),
                    initialValue: item.notes,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Catatan opsional',
                    ),
                    onChanged: (value) => _updateFinancialItem(
                      item.reviewId,
                      (current) => current.copyWith(notes: value),
                    ),
                  ),
                  if (item.type == FinancialTransactionType.expense)
                    Material(
                      color: Colors.transparent,
                      child: SwitchListTile.adaptive(
                        key: ValueKey('review-reimburse-${item.reviewId}'),
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Reimburse'),
                        value: item.isReimburse,
                        onChanged: (value) => _updateFinancialItem(
                          item.reviewId,
                          (current) => current.copyWith(isReimburse: value),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
          Row(
            children: [
              Expanded(
                child: BrutalButton(
                  label: 'BATAL',
                  icon: Icons.close,
                  secondary: true,
                  onPressed: _requesting ? null : _cancelFinancialReview,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: BrutalButton(
                  label: 'SIMPAN SEMUA',
                  icon: Icons.save,
                  onPressed: _requesting || items.isEmpty
                      ? null
                      : _saveFinancialPreview,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scheduleReviewCard() {
    final draft = _schedulePreview!;
    final when = draft.allDay
        ? draft.localStartDate ?? draft.dueDateLocal ?? 'Tanpa tanggal'
        : (draft.startAtUtc ?? draft.dueAtUtc)?.toLocal().toString() ??
              'Tanpa waktu';
    return BrutalCard(
      color: const Color(0xFFCDEAC0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'REVIEW JADWAL — TINJAU DULU',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Text(
            draft.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          Text('${draft.itemType.name.toUpperCase()} · $when'),
          Text('${draft.categoryName} · ${draft.priority.name.toUpperCase()}'),
          if (draft.assumptions.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('ASUMSI\n${draft.assumptions.join('\n')}'),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: BrutalButton(
                  label: 'BATAL',
                  icon: Icons.close,
                  secondary: true,
                  onPressed: () => setState(() {
                    _schedulePreview = null;
                    _status = 'Review dibatalkan — draft tetap tersimpan';
                  }),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: BrutalButton(
                  label: 'EDIT',
                  icon: Icons.edit,
                  secondary: true,
                  onPressed: () =>
                      context.push(AppRoutes.schedulerNew, extra: draft),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          BrutalButton(
            label: 'SIMPAN',
            icon: Icons.save,
            onPressed: _requesting ? null : _saveSchedulePreview,
          ),
        ],
      ),
    );
  }

  Widget _composerArea() {
    // ── Mode Baca: composer diciutkan ────────────────────────────────────────
    if (_viewportMode == ChatViewportMode.reading) {
      return Container(
        padding: EdgeInsets.fromLTRB(
          16,
          8,
          16,
          8 + MediaQuery.paddingOf(context).bottom,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD60A),
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
              width: 3,
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.chrome_reader_mode, size: 18),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'MODE BACA AKTIF',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
              ),
            ),
            TextButton.icon(
              key: const ValueKey('exit-reading-mode-btn'),
              onPressed: () => _setReadingMode(false),
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('KEMBALI INPUT'),
            ),
          ],
        ),
      );
    }

    // ── Mode Input: composer normal ──────────────────────────────────────────
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
          // ── Toggle Mode Baca ───────────────────────────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: Semantics(
              label: 'Aktifkan Mode Baca',
              button: true,
              child: TextButton.icon(
                key: const ValueKey('enter-reading-mode-btn'),
                onPressed: () => _setReadingMode(true),
                icon: const Icon(Icons.chrome_reader_mode_outlined, size: 18),
                label: const Text(
                  'MODE BACA',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                ),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ChatInputMode.values
                    .map(
                      (mode) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ChoiceChip(
                          key: ValueKey('chat-mode-${mode.name}'),
                          label: Text(_modeLabel(mode)),
                          selected: _selectedMode == mode,
                          onSelected: _requesting || _voice.isActive
                              ? null
                              : (_) => _selectMode(mode),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ),
          if (_selectedMode == ChatInputMode.expense)
            Material(
              color: Colors.transparent,
              child: SwitchListTile.adaptive(
                key: const ValueKey('composer-reimburse-toggle'),
                contentPadding: EdgeInsets.zero,
                title: const Text('Reimburse'),
                subtitle: const Text('Tidak mengurangi budget'),
                value: _defaultReimburse,
                onChanged: _requesting
                    ? null
                    : (value) => setState(() => _defaultReimburse = value),
              ),
            ),
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
            focusNode: _composerFocus,
            enabled: !_requesting,
            maxLength: ProviderConfig.chatInputMaxCharacters,
            minLines: 1,
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              labelText: 'Tulis atau ucapkan catatan Anda',
              hintText: _composerHint,
              suffixIcon: SizedBox(
                width: 104,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Semantics(
                      label: _voiceSemanticLabel,
                      button: true,
                      child: IconButton(
                        tooltip: 'Mulai input suara',
                        onPressed: _requesting || _voice.isActive
                            ? null
                            : _startVoice,
                        icon: Icon(
                          _voice.status == VoiceInputStatus.completed
                              ? Icons.mic_none
                              : Icons.mic,
                        ),
                      ),
                    ),
                    if (_requesting)
                      IconButton(
                        tooltip: 'Batalkan request',
                        onPressed: _cancel,
                        icon: const Icon(Icons.stop),
                      )
                    else
                      IconButton(
                        tooltip: 'Kirim',
                        onPressed: _voice.isActive ? null : _send,
                        icon: const Icon(Icons.send),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (_voice.isActive) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _voice.status == VoiceInputStatus.listening
                        ? _stopVoice
                        : null,
                    icon: const Icon(Icons.stop_circle_outlined),
                    label: const Text('STOP SUARA'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton.icon(
                    onPressed: _cancelVoice,
                    icon: const Icon(Icons.close),
                    label: const Text('BATAL'),
                  ),
                ),
              ],
            ),
          ],
          if (_voice.status == VoiceInputStatus.denied)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _voice.openSettings,
                icon: const Icon(Icons.settings),
                label: const Text('BUKA PENGATURAN APLIKASI'),
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
    _draftTimer = Timer(
      const Duration(milliseconds: 400),
      _persistChatDraftNow,
    );
  }

  Future<void> _persistChatDraftNow() async {
    final text = _composer.text.trim();
    final repository = ref.read(chatDraftRepositoryProvider);
    if (text.isEmpty) {
      final id = _chatDraftId;
      if (id != null) await repository.delete(id);
      if (mounted) {
        setState(() {
          _chatDraftId = null;
          _defaultReimburse = false;
        });
      }
      return;
    }
    final id = await repository.save(
      id: _chatDraftId,
      text: text,
      selectedMode: _selectedMode,
    );
    if (mounted) setState(() => _chatDraftId = id);
  }

  Future<void> _restoreLatestDraft() async {
    final chatDraft = await ref.read(chatDraftRepositoryProvider).latest();
    if (!mounted || _composer.text.isNotEmpty) return;
    if (chatDraft != null) {
      setState(() {
        _chatDraftId = chatDraft.id;
        _selectedMode = ChatInputModeStorage.parse(chatDraft.selectedMode);
        _composer.text = chatDraft.draftText;
        _status = 'Draft chat lokal dipulihkan';
      });
      return;
    }
    final drafts = ref.read(pendingDraftsProvider).value;
    if (drafts == null || drafts.isEmpty || _composer.text.isNotEmpty) return;
    final draft = drafts.first;
    setState(() {
      _requestId = draft.localRequestId;
      _foodDraftId = draft.id;
      _selectedMode = ChatInputMode.nutrition;
      _composer.text = draft.originalUserText ?? '';
      _consumedAt = draft.consumedAtUtc.toLocal();
      _mealType = draft.mealType;
      _status = 'Draft nutrisi lama dipulihkan';
    });
  }

  Future<void> _send() async {
    if (_requesting || _voice.isActive) return;
    final input = _composer.text.trim();
    if (input.isEmpty) {
      setState(() {
        _status = 'Input tidak boleh kosong';
        _statusKind = null;
      });
      return;
    }
    final foodLogs = ref.read(foodLogRepositoryProvider);
    final finance = ref.read(financeRepositoryProvider);
    final failover = ref.read(geminiFailoverServiceProvider);
    _requestId ??= ref.read(requestIdProvider)();
    _cancellation = RequestCancellation();
    setState(() {
      _requesting = true;
      _status = 'Memproses dengan Gemini…';
      _statusKind = null;
      _preview = null;
      _financialPreview = null;
      _financialConfidence = null;
      _schedulePreview = null;
    });
    _AllKeysFailedAction? failureAction;
    try {
      _draftTimer?.cancel();
      await _persistChatDraftNow();
      final categories = await finance.getCategories();
      final financeSettings = await finance.getSettings();
      final scheduleCategories = await ref
          .read(schedulerRepositoryProvider)
          .activeCategories();
      final timezone = await ref.read(localTimezoneProvider.future);
      if (!mounted) return;
      final reviewCategories = categories
          .map(
            (category) => FinancialReviewCategory(
              id: category.id,
              name: category.name,
              type: FinancialTransactionTypeStorage.parse(category.type),
            ),
          )
          .toList(growable: false);
      final parseContext = ChatParseContext(
        mode: _selectedMode,
        localDate: DateTime.now(),
        timezone: timezone,
        currencyCode: financeSettings.currencyCode,
        activeCategories: reviewCategories
            .map(
              (category) => GeminiCategoryContext(
                id: category.id,
                name: category.name,
                type: category.type == FinancialTransactionType.expense
                    ? ChatDomain.expense
                    : ChatDomain.income,
              ),
            )
            .toList(growable: false),
        scheduleCategories: scheduleCategories
            .map((category) => category.name)
            .toList(growable: false),
        currentDateTime: DateTime.now(),
      );
      final result = await failover.parseChat(
        input,
        context: parseContext,
        requestId: _requestId,
        cancellation: _cancellation,
      );
      if (!mounted) return;
      if (result is ParseChatSuccess) {
        final draft = result.draft;
        if (draft.requiresClarification) {
          // Input berhasil diterima Gemini tapi perlu klarifikasi
          final question =
              draft.clarificationQuestion ?? 'Tolong perjelas inputmu';
          setState(() {
            _status =
                'Input kurang jelas: $question\n'
                'Coba tulis ulang dengan lebih lengkap, atau pilih jenis '
                'catatan secara manual.';
            _statusKind = ParseChatFailureKind.ambiguousInput;
          });
        } else if (draft.detectedDomain == ChatDomain.nutrition &&
            draft.nutrition != null) {
          _foodDraftId = await foodLogs.createDraft(
            requestId: _requestId!,
            input: input,
            consumedAt: _consumedAt,
            mealType: _mealType,
          );
          await foodLogs.applyParsedDraft(
            requestId: result.requestId!,
            draft: draft.nutrition!,
            keyId: result.keyId,
          );
          if (!mounted) return;
          setState(() {
            _preview = draft.nutrition;
            _status = 'Preview nutrisi siap — tinjau sebelum simpan';
            _statusKind = null;
          });
        } else if (draft.detectedDomain == ChatDomain.schedule &&
            draft.schedule != null) {
          setState(() {
            _schedulePreview = draft.schedule;
            _status = 'Jadwal siap — tinjau sebelum simpan';
            _statusKind = null;
          });
        } else {
          final type = draft.detectedDomain == ChatDomain.expense
              ? FinancialTransactionType.expense
              : FinancialTransactionType.income;
          final reviewItems = draft.financialItems.indexed
              .map(
                (entry) => FinancialReviewItem.fromParsed(
                  reviewId: '${result.requestId}-${entry.$1}',
                  parsed: entry.$2,
                  type: type,
                  isReimburse:
                      type == FinancialTransactionType.expense &&
                      _defaultReimburse,
                ),
              )
              .toList(growable: false);
          setState(() {
            _reviewCategories = reviewCategories;
            _financialPreview = reviewItems;
            _financialConfidence = draft.confidence;
            _status =
                '${reviewItems.length} transaksi siap — tinjau sebelum simpan';
            _statusKind = null;
          });
        }
      } else if (result is ParseChatAllKeysFailed) {
        setState(() {
          _status =
              'Semua API key belum dapat digunakan — input tetap tersimpan';
          _statusKind = ParseChatFailureKind.technicalError;
        });
        failureAction = await _showAllKeysFailed();
      } else if (result is ParseChatOffline) {
        setState(() {
          _status = 'Tidak ada koneksi internet — input tetap tersimpan';
          _statusKind = ParseChatFailureKind.technicalError;
        });
      } else if (result is ParseChatContentNeedsRevision) {
        setState(() {
          _status =
              'Input diblokir oleh filter keamanan Gemini.\n'
              'Coba ubah kalimat atau gunakan catat manual.';
          _statusKind = ParseChatFailureKind.ambiguousInput;
        });
      } else if (result is ParseChatCancelled) {
        setState(() {
          _status = 'Request dibatalkan — input tetap tersimpan';
          _statusKind = null;
        });
      } else if (result is ParseChatRequestFailure) {
        setState(() {
          _status = _statusMessageForRequestFailure(result);
          _statusKind = result.kind;
        });
      } else {
        setState(() {
          _status = 'Hasil belum dapat diproses — input tetap tersimpan';
          _statusKind = ParseChatFailureKind.technicalError;
        });
      }
    } on Object catch (error, stackTrace) {
      debugPrint('Gemini unified request failed: ${error.runtimeType}');
      debugPrintStack(stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _status = 'Terjadi kesalahan tak terduga — input tetap tersimpan';
          _statusKind = ParseChatFailureKind.technicalError;
        });
      }
    } finally {
      if (mounted) setState(() => _requesting = false);
    }
    if (!mounted || failureAction == null) return;
    _handleAllKeysFailedAction(failureAction);
  }

  /// Pesan error berdiferensiasi berdasarkan kategori kegagalan API.
  String _statusMessageForRequestFailure(ParseChatRequestFailure result) {
    if (result.kind == ParseChatFailureKind.ambiguousInput) {
      return switch (result.category) {
        GeminiFailureCategory.schemaMismatch =>
          'Input tidak dikenali: pastikan nama item jelas, '
              'dan sertakan jumlah atau nominal.\n'
              'Contoh: "Nasi goreng 1 porsi" atau "Kopi 20 ribu".',
        _ =>
          'Input tidak dapat diproses — coba perjelas atau gunakan catat manual.',
      };
    }
    // technicalError
    return switch (result.category) {
      GeminiFailureCategory.invalidKey =>
        'API key tidak valid — periksa atau ganti key di pengaturan.',
      GeminiFailureCategory.permission =>
        'API key tidak punya izin — periksa konfigurasi key.',
      GeminiFailureCategory.rateLimit =>
        'Kuota Gemini habis atau terlalu banyak permintaan — coba lagi sebentar.',
      GeminiFailureCategory.timeout =>
        'Koneksi ke Gemini timeout — periksa jaringan lalu coba lagi.',
      GeminiFailureCategory.transientServer =>
        'Server Gemini sedang gangguan — coba lagi beberapa saat.',
      GeminiFailureCategory.offline =>
        'Tidak ada koneksi internet — input tetap tersimpan.',
      GeminiFailureCategory.modelNotFound =>
        'Model Gemini tidak ditemukan — hubungi pengembang.',
      GeminiFailureCategory.requestInvalid =>
        'Permintaan ke Gemini tidak valid — coba lagi atau hubungi pengembang.',
      GeminiFailureCategory.schemaMismatch =>
        'Respons Gemini tidak dapat dibaca — coba lagi.',
      GeminiFailureCategory.safetyBlock =>
        'Input diblokir filter keamanan — coba ubah kalimat.',
      GeminiFailureCategory.secretUnavailable =>
        'API key tidak dapat dibaca dari penyimpanan aman perangkat.',
      GeminiFailureCategory.unknown || GeminiFailureCategory.cancelled =>
        'Terjadi kesalahan — input tetap tersimpan, coba lagi.',
    };
  }

  void _cancel() {
    _cancellation?.cancel();
    setState(() => _status = 'Membatalkan request…');
  }

  Future<void> _startVoice() async {
    if (_requesting || _voice.isActive) return;
    final settings = await ref.read(settingsRepositoryProvider).getSettings();
    if (!mounted) return;
    if (!settings.voiceDisclosureAcknowledged) {
      final accepted = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('PRIVASI INPUT SUARA'),
          content: const Text(
            'Fitur suara mengubah ucapan menjadi teks. Bergantung pada layanan\n'
            'speech recognition perangkat, audio dapat diproses secara online\n'
            'oleh penyedia sistem operasi. KeySpace tidak menyimpan rekaman audio.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('BATAL'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('LANJUTKAN'),
            ),
          ],
        ),
      );
      if (!mounted || accepted != true) return;
      await ref.read(settingsRepositoryProvider).acknowledgeVoiceDisclosure();
      if (!mounted) return;
    }
    await _voice.start();
  }

  Future<void> _stopVoice() => _voice.stop();

  Future<void> _cancelVoice() async {
    await _voice.cancel();
    if (!mounted) return;
    setState(
      () => _status = 'Input suara dibatalkan — input manual tetap tersedia',
    );
  }

  void _applyVoiceTranscript(String transcript, bool isFinal) {
    if (!mounted) return;
    _composer.value = TextEditingValue(
      text: transcript,
      selection: TextSelection.collapsed(offset: transcript.length),
    );
    if (isFinal) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _composerFocus.requestFocus();
      });
    }
  }

  void _handleVoiceState() {
    if (!mounted) return;
    setState(() => _status = _voiceStatusMessage);
  }

  String? get _voiceStatusMessage => switch (_voice.status) {
    VoiceInputStatus.idle => null,
    VoiceInputStatus.requestingPermission => 'Meminta izin mikrofon…',
    VoiceInputStatus.listening => 'Mendengarkan… ucapkan catatan Anda',
    VoiceInputStatus.processing => 'Memproses hasil suara…',
    VoiceInputStatus.completed => 'Draft suara siap — edit lalu tekan Kirim',
    VoiceInputStatus.denied =>
      'Izin mikrofon ditolak — input manual tetap tersedia',
    VoiceInputStatus.failed => switch (_voice.failure) {
      VoiceRecognitionFailure.noSpeech =>
        'Tidak ada suara terdeteksi — input manual tetap tersedia',
      VoiceRecognitionFailure.timeout =>
        'Pengenalan suara timeout — input manual tetap tersedia',
      VoiceRecognitionFailure.network =>
        'Jaringan speech recognition terputus — input manual tetap tersedia',
      VoiceRecognitionFailure.unavailable =>
        'Speech recognition tidak tersedia — input manual tetap tersedia',
      VoiceRecognitionFailure.permissionDenied =>
        'Izin mikrofon ditolak — input manual tetap tersedia',
      VoiceRecognitionFailure.unknown ||
      null => 'Pengenalan suara gagal — input manual tetap tersedia',
    },
  };

  String get _voiceSemanticLabel => switch (_voice.status) {
    VoiceInputStatus.requestingPermission => 'Input suara, meminta izin',
    VoiceInputStatus.listening => 'Input suara, sedang mendengarkan',
    VoiceInputStatus.processing => 'Input suara, sedang memproses',
    VoiceInputStatus.completed => 'Input suara selesai, dapat dimulai lagi',
    VoiceInputStatus.denied => 'Input suara, izin ditolak',
    VoiceInputStatus.failed => 'Input suara gagal, dapat dicoba lagi',
    VoiceInputStatus.idle => 'Mulai input suara',
  };

  Future<void> _savePreview() async {
    if (_foodDraftId == null) return;
    await ref.read(foodLogRepositoryProvider).confirmDraft(_foodDraftId!);
    await ref
        .read(reminderCoordinatorProvider)
        .reconcileDate(localDateKey(_consumedAt));
    if (!mounted) return;
    await _clearCompletedInput('Food Log tersimpan');
  }

  void _editPreview() {
    if (_foodDraftId != null) {
      context.push('/food-log/${_foodDraftId!}/edit');
    }
  }

  Future<void> _saveFinancialPreview() async {
    final items = _financialPreview;
    if (_requesting || items == null || items.isEmpty) return;
    setState(() {
      _requesting = true;
      _status = 'Menyimpan transaksi secara atomic…';
    });
    try {
      await ref
          .read(financeRepositoryProvider)
          .saveBatch(items.map((item) => item.toInput()).toList());
      if (!mounted) return;
      await _clearCompletedInput('${items.length} transaksi tersimpan');
    } on Object catch (error) {
      if (!mounted) return;
      setState(
        () => _status =
            'Transaksi belum tersimpan (${error.runtimeType}) — periksa semua field',
      );
    } finally {
      if (mounted) setState(() => _requesting = false);
    }
  }

  Future<void> _saveSchedulePreview() async {
    final draft = _schedulePreview;
    if (_requesting || draft == null) return;
    setState(() {
      _requesting = true;
      _status = 'Menyimpan jadwal dan menyiapkan reminder…';
    });
    try {
      final id = await ref
          .read(schedulerRepositoryProvider)
          .saveDraft(
            draft,
            source: 'gemini',
            originalUserText: _composer.text.trim(),
          );
      await ref.read(schedulerReminderCoordinatorProvider).reconcileItem(id);
      if (!mounted) return;
      await _clearCompletedInput('Jadwal tersimpan');
    } on Object catch (error) {
      if (!mounted) return;
      setState(() {
        _status = 'Jadwal belum tersimpan (${error.runtimeType})';
        _statusKind = ParseChatFailureKind.technicalError;
      });
    } finally {
      if (mounted) setState(() => _requesting = false);
    }
  }

  void _cancelFinancialReview() {
    setState(() {
      _financialPreview = null;
      _financialConfidence = null;
      _schedulePreview = null;
      _status = 'Review dibatalkan — draft tetap tersimpan';
    });
  }

  void _updateFinancialItem(
    String reviewId,
    FinancialReviewItem Function(FinancialReviewItem current) update,
  ) {
    final items = _financialPreview;
    if (items == null) return;
    setState(() {
      _financialPreview = items
          .map((item) => item.reviewId == reviewId ? update(item) : item)
          .toList(growable: false);
    });
  }

  void _convertFinancialType(String reviewId, FinancialTransactionType type) {
    _updateFinancialItem(
      reviewId,
      (item) => item.convertType(type, _reviewCategories),
    );
  }

  void _changeFinancialCategory(String reviewId, String categoryId) {
    final category = _reviewCategories.firstWhere(
      (value) => value.id == categoryId,
    );
    _updateFinancialItem(
      reviewId,
      (item) =>
          item.copyWith(categoryId: category.id, categoryName: category.name),
    );
  }

  void _removeFinancialItem(String reviewId) {
    final items = _financialPreview;
    if (items == null) return;
    setState(() {
      _financialPreview = items
          .where((item) => item.reviewId != reviewId)
          .toList(growable: false);
      _status = 'Item dihapus dari review';
    });
  }

  Future<void> _pickFinancialDate(FinancialReviewItem item) async {
    final date = await showDatePicker(
      context: context,
      initialDate: item.transactionDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    _updateFinancialItem(
      item.reviewId,
      (current) => current.copyWith(transactionDate: date),
    );
  }

  Future<void> _clearCompletedInput(String message) async {
    final chatDraftId = _chatDraftId;
    if (chatDraftId != null) {
      await ref.read(chatDraftRepositoryProvider).delete(chatDraftId);
    }
    if (!mounted) return;
    _draftTimer?.cancel();
    setState(() {
      _preview = null;
      _financialPreview = null;
      _financialConfidence = null;
      _schedulePreview = null;
      _status = message;
      _requestId = null;
      _foodDraftId = null;
      _chatDraftId = null;
      _selectedMode = ChatInputMode.automatic;
      _defaultReimburse = false;
      _composer.clear();
    });
  }

  Future<void> _manualFallback() async {
    var mode = _selectedMode;
    if (mode == ChatInputMode.automatic) {
      final selected = await showDialog<ChatInputMode>(
        context: context,
        builder: (dialogContext) => SimpleDialog(
          title: const Text('PILIH JENIS CATATAN'),
          children: [
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.pop(dialogContext, ChatInputMode.nutrition),
              child: const Text('KALORI'),
            ),
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.pop(dialogContext, ChatInputMode.expense),
              child: const Text('PENGELUARAN'),
            ),
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.pop(dialogContext, ChatInputMode.income),
              child: const Text('PEMASUKAN'),
            ),
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.pop(dialogContext, ChatInputMode.schedule),
              child: const Text('JADWAL'),
            ),
          ],
        ),
      );
      if (!mounted || selected == null) return;
      mode = selected;
    }
    if (mode == ChatInputMode.expense || mode == ChatInputMode.income) {
      final type = mode == ChatInputMode.expense
          ? FinancialTransactionType.expense
          : FinancialTransactionType.income;
      final categories = await ref
          .read(financeRepositoryProvider)
          .getCategories();
      if (!mounted) return;
      final reviewCategories = categories
          .map(
            (category) => FinancialReviewCategory(
              id: category.id,
              name: category.name,
              type: FinancialTransactionTypeStorage.parse(category.type),
            ),
          )
          .toList(growable: false);
      final eligible = reviewCategories
          .where((category) => category.type == type)
          .toList(growable: false);
      final fallback = eligible.firstWhere(
        (category) => category.name == 'Lainnya',
        orElse: () => eligible.first,
      );
      setState(() {
        _selectedMode = mode;
        _reviewCategories = reviewCategories;
        _financialConfidence = null;
        _financialPreview = [
          FinancialReviewItem(
            reviewId: 'manual-${DateTime.now().microsecondsSinceEpoch}',
            type: type,
            name: '',
            amount: 0,
            transactionDate: DateTime.now(),
            categoryId: fallback.id,
            categoryName: fallback.name,
            isReimburse:
                type == FinancialTransactionType.expense && _defaultReimburse,
          ),
        ];
        _status = 'Isi transaksi manual lalu simpan';
      });
      _scheduleDraftSave();
      return;
    }
    if (mode == ChatInputMode.schedule) {
      if (!mounted) return;
      unawaited(context.push(AppRoutes.schedulerNew));
      return;
    }
    if (_foodDraftId != null) {
      unawaited(context.push('/food-log/${_foodDraftId!}/edit'));
    } else {
      unawaited(
        context.push('/food-log/new/edit?date=${localDateKey(_consumedAt)}'),
      );
    }
  }

  Future<_AllKeysFailedAction?> _showAllKeysFailed() {
    return showDialog<_AllKeysFailedAction>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('SEMUA API KEY GAGAL'),
        content: const Text(
          'Input tetap tersimpan. Tambahkan key baru atau lanjutkan secara manual.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, _AllKeysFailedAction.addKey),
            child: const Text('TAMBAH API KEY'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, _AllKeysFailedAction.manageKeys),
            child: const Text('KELOLA'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, _AllKeysFailedAction.retry),
            child: const Text('COBA LAGI'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(dialogContext, _AllKeysFailedAction.manual),
            child: const Text('CATAT MANUAL'),
          ),
        ],
      ),
    );
  }

  void _handleAllKeysFailedAction(_AllKeysFailedAction action) {
    switch (action) {
      case _AllKeysFailedAction.addKey:
        context.push(
          '${AppRoutes.apiKeys}?returnTo=pendingRequest&pendingRequestId=$_requestId',
        );
      case _AllKeysFailedAction.manageKeys:
        context.push(AppRoutes.apiKeys);
      case _AllKeysFailedAction.retry:
        _send();
      case _AllKeysFailedAction.manual:
        _manualFallback();
    }
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

  void _selectMode(ChatInputMode mode) {
    setState(() => _selectedMode = mode);
    _scheduleDraftSave();
  }

  String _modeLabel(ChatInputMode mode) => switch (mode) {
    ChatInputMode.automatic => 'Otomatis',
    ChatInputMode.nutrition => 'Kalori',
    ChatInputMode.expense => 'Pengeluaran',
    ChatInputMode.income => 'Pemasukan',
    ChatInputMode.schedule => 'Jadwal',
  };

  String get _composerHint => switch (_selectedMode) {
    ChatInputMode.automatic => 'Contoh: makan nasi atau beli bensin 100 ribu',
    ChatInputMode.nutrition => 'Contoh: nasi goreng dan es teh',
    ChatInputMode.expense => 'Contoh: beli bensin 100 ribu kemarin',
    ChatInputMode.income => 'Contoh: menerima bonus 2 juta hari ini',
    ChatInputMode.schedule => 'Contoh: besok jam 11 meeting marketing',
  };
}

enum _AllKeysFailedAction { addKey, manageKeys, retry, manual }
