import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/app/router.dart';
import 'package:keyspace/core/time/local_date.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

final dailyLogsProvider = StreamProvider.family<List<FoodLog>, String>(
  (ref, date) => ref.watch(foodLogRepositoryProvider).watchLogsForDate(date),
);

final dailyTotalProvider = StreamProvider.family<DailyNutritionTotal, String>(
  (ref, date) => ref.watch(foodLogRepositoryProvider).watchTotal(date),
);

final effectiveTargetProvider = StreamProvider.family<DailyTarget?, String>(
  (ref, date) => ref.watch(targetRepositoryProvider).watchEffectiveTarget(date),
);

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final key = localDateKey(_date);
    final logs = ref.watch(dailyLogsProvider(key));
    final total = ref.watch(dailyTotalProvider(key));
    final target = ref.watch(effectiveTargetProvider(key));
    final drafts = ref.watch(pendingDraftsProvider).value ?? const <FoodLog>[];
    final apiKeys =
        ref.watch(apiKeysStreamProvider).value ?? const <ApiKeyMetadataData>[];
    final unhealthy =
        apiKeys.isNotEmpty &&
        apiKeys.every(
          (item) =>
              !item.isEnabled ||
              {
                'invalid',
                'blocked',
                'secret_unavailable',
              }.contains(item.healthStatus),
        );
    return Scaffold(
      appBar: AppBar(
        title: const Text('HARI INI'),
        actions: [
          IconButton(
            tooltip: 'Pilih tanggal',
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(dailyLogsProvider(key));
          ref.invalidate(dailyTotalProvider(key));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              _dateLabel(_date),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            if (drafts.isNotEmpty) ...[
              const SizedBox(height: 12),
              BrutalCard(
                color: const Color(0xFFFFE79A),
                child: Row(
                  children: [
                    const Icon(Icons.edit_note),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text('${drafts.length} pencatatan belum selesai.'),
                    ),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.chat),
                      child: const Text('LANJUTKAN'),
                    ),
                  ],
                ),
              ),
            ],
            if (apiKeys.isEmpty || unhealthy) ...[
              const SizedBox(height: 12),
              BrutalCard(
                child: Row(
                  children: [
                    const Icon(Icons.key_off),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'AI belum tersedia. Fitur lokal tetap aktif.',
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push(AppRoutes.apiKeys),
                      child: const Text('PERIKSA'),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            BrutalCard(
              color: const Color(0xFFFFD60A),
              child: total.when(
                data: (value) => CalorieProgressBar(
                  consumed: value.caloriesKcal,
                  target: target.value?.calorieTarget,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, _) => const Text('Ringkasan belum dapat dibuka.'),
              ),
            ),
            const SizedBox(height: 16),
            total.when(
              data: (value) => Row(
                children: [
                  _Macro(label: 'PROTEIN', value: value.proteinG),
                  _Macro(label: 'KARBO', value: value.carbsG),
                  _Macro(label: 'LEMAK', value: value.fatG),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            if (target.value == null) ...[
              const SizedBox(height: 16),
              BrutalButton(
                label: 'ATUR TARGET',
                icon: Icons.flag_outlined,
                secondary: true,
                onPressed: () => context.push(AppRoutes.profile),
              ),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: BrutalButton(
                    label: 'CHAT AI',
                    icon: Icons.chat,
                    onPressed: () => context.go(AppRoutes.chat),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BrutalButton(
                    label: 'MANUAL',
                    icon: Icons.add,
                    secondary: true,
                    onPressed: () =>
                        context.push('/food-log/new/edit?date=$key'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'CATATAN MAKAN',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            logs.when(
              data: (values) => values.isEmpty
                  ? EmptyState(
                      title: 'BELUM ADA MAKANAN',
                      message:
                          'Catat lewat chat atau masukkan nilai nutrisi secara manual.',
                      action: BrutalButton(
                        label: 'CATAT MAKANAN',
                        onPressed: () => context.go(AppRoutes.chat),
                      ),
                    )
                  : Column(children: values.map(_logCard).toList()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const EmptyState(
                title: 'DATA BELUM DAPAT DIBUKA',
                message: 'Tarik layar untuk mencoba lagi.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logCard(FoodLog log) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BrutalCard(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => context.push('/food-log/${log.id}/edit'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (log.originalUserText?.trim().isNotEmpty ?? false)
                          ? log.originalUserText!
                          : log.mealType.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${log.mealType.toUpperCase()} • ${_time(log.consumedAtUtc.toLocal())}',
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '${log.totalCaloriesKcal.round()}\nKKAL',
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            IconButton(
              tooltip: 'Hapus Food Log',
              onPressed: () => _delete(log),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete(FoodLog log) async {
    final repository = ref.read(foodLogRepositoryProvider);
    final deletedAt = DateTime.now();
    await repository.softDelete(log.id, deletedAt);
    await ref.read(reminderCoordinatorProvider).reconcileDate(log.localDate);
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: ProviderConfig.undoWindow,
        content: const Text('Food Log dihapus'),
        action: SnackBarAction(
          label: 'URUNGKAN',
          onPressed: () async {
            await repository.undoDelete(log.id);
            await ref
                .read(reminderCoordinatorProvider)
                .reconcileDate(log.localDate);
          },
        ),
      ),
    );
    unawaited(
      Future<void>.delayed(ProviderConfig.undoWindow, () async {
        await repository.purgeExpiredDeletes(DateTime.now());
      }),
    );
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (value != null) setState(() => _date = value);
  }

  String _dateLabel(DateTime value) =>
      '${value.day.toString().padLeft(2, '0')}.${value.month.toString().padLeft(2, '0')}.${value.year}';
  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}

class _Macro extends StatelessWidget {
  const _Macro({required this.label, required this.value});
  final String label;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: BrutalCard(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
              Text(
                '${(value ?? 0).round()} g',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
