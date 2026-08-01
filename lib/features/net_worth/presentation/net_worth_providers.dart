import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/features/net_worth/domain/net_worth_models.dart';
import 'package:keyspace/shared/providers/infrastructure_providers.dart';

final netWorthOverviewProvider = StreamProvider<NetWorthOverview?>((ref) {
  return ref.watch(netWorthRepositoryProvider).watchOverview();
});

final netWorthDetailProvider = FutureProvider<NetWorthDetail?>((ref) {
  return ref.watch(netWorthRepositoryProvider).getDetail();
});
