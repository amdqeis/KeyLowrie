import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyspace/core/time/clock.dart';
import 'package:uuid/uuid.dart';

final clockProvider = Provider<Clock>((ref) => const SystemClock());
final requestIdProvider = Provider<String Function()>((ref) {
  const uuid = Uuid();
  return uuid.v4;
});
