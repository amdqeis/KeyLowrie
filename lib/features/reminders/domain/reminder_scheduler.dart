abstract interface class ReminderScheduler {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<void> scheduleNext({required int hour, required int minute});
  Future<void> cancel();
}

class NoopReminderScheduler implements ReminderScheduler {
  const NoopReminderScheduler();

  @override
  Future<void> cancel() async {}

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async => false;

  @override
  Future<void> scheduleNext({required int hour, required int minute}) async {}
}
