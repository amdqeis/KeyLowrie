import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyspace/features/dashboard/presentation/dashboard_screen.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';
import 'package:keyspace/shared/widgets/brutal_widgets.dart';

final historyDatesProvider = StreamProvider(
  (ref) => ref.watch(foodLogRepositoryProvider).watchHistoryDates(),
);

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dates = ref.watch(historyDatesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('RIWAYAT HARIAN')),
      body: dates.when(
        data: (values) => values.isEmpty
            ? ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  EmptyState(
                    title: 'BELUM ADA RIWAYAT',
                    message: 'Food Log yang dikonfirmasi akan tampil di sini.',
                  ),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: values.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BrutalCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        values[index],
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      subtitle: const Text('Buka catatan harian'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () => context.push('/history/${values[index]}'),
                    ),
                  ),
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('Riwayat belum dapat dibuka.')),
      ),
    );
  }
}

class HistoryDateScreen extends ConsumerWidget {
  const HistoryDateScreen({required this.date, super.key});

  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(dailyLogsProvider(date));
    final total = ref.watch(dailyTotalProvider(date));
    return Scaffold(
      appBar: AppBar(title: Text('RIWAYAT $date')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BrutalCard(
            color: const Color(0xFFFFD60A),
            child: total.when(
              data: (value) => Text(
                '${value.caloriesKcal.round()} KKAL\nProtein ${(value.proteinG ?? 0).round()} g • Karbo ${(value.carbsG ?? 0).round()} g • Lemak ${(value.fatG ?? 0).round()} g',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => const Text('Total belum tersedia'),
            ),
          ),
          const SizedBox(height: 16),
          logs.when(
            data: (values) => values.isEmpty
                ? const EmptyState(
                    title: 'TIDAK ADA CATATAN',
                    message: 'Tidak ada Food Log pada tanggal ini.',
                  )
                : Column(
                    children: values
                        .map(
                          (log) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: BrutalCard(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  log.originalUserText ?? log.mealType,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                subtitle: Text(
                                  log.mealType.replaceAll('_', ' '),
                                ),
                                trailing: Text(
                                  '${log.totalCaloriesKcal.round()} kkal',
                                ),
                                onTap: () =>
                                    context.push('/food-log/${log.id}/edit'),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const Text('Daftar belum dapat dibuka.'),
          ),
        ],
      ),
    );
  }
}
