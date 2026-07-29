import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:keyspace/app/bootstrap.dart';
import 'package:keyspace/core/network/connectivity_network_status.dart';
import 'package:keyspace/database/app_database.dart';
import 'package:keyspace/features/api_key_pool/application/api_key_test_service.dart';
import 'package:keyspace/features/api_key_pool/data/api_key_admin_repository.dart';
import 'package:keyspace/features/api_key_pool/data/drift_key_pool_repository.dart';
import 'package:keyspace/features/finance/data/finance_repository.dart';
import 'package:keyspace/features/food_chat/data/chat_draft_repository.dart';
import 'package:keyspace/features/food_chat/data/drift_pending_request_repository.dart';
import 'package:keyspace/features/food_chat/data/gemini_dio_client.dart';
import 'package:keyspace/features/food_chat/domain/gemini_contracts.dart';
import 'package:keyspace/features/food_chat/domain/gemini_failover_service.dart';
import 'package:keyspace/features/food_log/data/food_log_repository.dart';
import 'package:keyspace/features/reminders/application/reminder_coordinator.dart';
import 'package:keyspace/features/reminders/data/local_notification_scheduler.dart';
import 'package:keyspace/features/reminders/data/reminder_repository.dart';
import 'package:keyspace/features/reminders/domain/reminder_scheduler.dart';
import 'package:keyspace/features/scheduler/application/scheduler_reminder_coordinator.dart';
import 'package:keyspace/features/scheduler/data/schedule_notification_service.dart';
import 'package:keyspace/features/scheduler/data/scheduler_repository.dart';
import 'package:keyspace/features/settings/data/settings_repository.dart';
import 'package:keyspace/features/targets/data/target_repository.dart';
import 'package:keyspace/features/voice_input/data/plugin_speech_recognition_service.dart';
import 'package:keyspace/features/voice_input/domain/speech_recognition_service.dart';
import 'package:keyspace/shared/providers/security_providers.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final geminiClientProvider = Provider<GeminiClient>((ref) => GeminiDioClient());

final keyPoolRepositoryProvider = Provider<KeyPoolRepository>(
  (ref) => DriftKeyPoolRepository(ref.watch(databaseProvider)),
);

final pendingRequestRepositoryProvider = Provider<PendingRequestRepository>(
  (ref) => DriftPendingRequestRepository(ref.watch(databaseProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

final targetRepositoryProvider = Provider<TargetRepository>(
  (ref) => TargetRepository(ref.watch(databaseProvider)),
);

final foodLogRepositoryProvider = Provider<FoodLogRepository>(
  (ref) => FoodLogRepository(ref.watch(databaseProvider)),
);

final financeRepositoryProvider = Provider<FinanceRepository>(
  (ref) => FinanceRepository(ref.watch(databaseProvider)),
);

final chatDraftRepositoryProvider = Provider<ChatDraftRepository>(
  (ref) => ChatDraftRepository(ref.watch(databaseProvider)),
);

final schedulerRepositoryProvider = Provider<SchedulerRepository>(
  (ref) => SchedulerRepository(ref.watch(databaseProvider)),
);

final scheduleItemsProvider = StreamProvider(
  (ref) => ref.watch(schedulerRepositoryProvider).watchItems(),
);

final scheduleCategoriesProvider = StreamProvider(
  (ref) => ref.watch(schedulerRepositoryProvider).watchCategories(),
);

final scheduleNotificationServiceProvider =
    Provider<ScheduleNotificationService>(
      (ref) => LocalScheduleNotificationService(),
    );

final scheduleNotificationActionsProvider = StreamProvider(
  (ref) => ref.watch(scheduleNotificationServiceProvider).actions,
);

final schedulerReminderCoordinatorProvider =
    Provider<SchedulerReminderCoordinator>(
      (ref) => SchedulerReminderCoordinator(
        database: ref.watch(databaseProvider),
        repository: ref.watch(schedulerRepositoryProvider),
        notifications: ref.watch(scheduleNotificationServiceProvider),
      ),
    );

final localTimezoneProvider = FutureProvider<String>((ref) async {
  try {
    return (await FlutterTimezone.getLocalTimezone()).identifier;
  } on Object {
    return DateTime.now().timeZoneName;
  }
});

final speechRecognitionServiceProvider = Provider<SpeechRecognitionService>((
  ref,
) {
  final service = PluginSpeechRecognitionService();
  ref.onDispose(service.dispose);
  return service;
});

final apiKeyAdminRepositoryProvider = Provider<ApiKeyAdminRepository>(
  (ref) => ApiKeyAdminRepository(
    ref.watch(databaseProvider),
    ref.watch(secretStoreProvider),
  ),
);

final apiKeyTestServiceProvider = Provider<ApiKeyTestService>(
  (ref) => ApiKeyTestService(
    repository: ref.watch(apiKeyAdminRepositoryProvider),
    client: ref.watch(geminiClientProvider),
  ),
);

final networkStatusProvider = Provider<NetworkStatus>(
  (ref) => ConnectivityNetworkStatus(),
);

final geminiFailoverServiceProvider = Provider<GeminiFailoverService>((ref) {
  return GeminiFailoverService(
    client: ref.watch(geminiClientProvider),
    keyPool: ref.watch(keyPoolRepositoryProvider),
    pendingRequests: ref.watch(pendingRequestRepositoryProvider),
    secretStore: ref.watch(secretStoreProvider),
    networkStatus: ref.watch(networkStatusProvider),
    clock: ref.watch(clockProvider),
    createRequestId: ref.watch(requestIdProvider),
  );
});

final bootstrapProvider = FutureProvider<void>((ref) async {
  final settings = ref.watch(settingsRepositoryProvider);
  await settings.initialize();
  await ref
      .watch(foodLogRepositoryProvider)
      .purgeExpiredDeletes(DateTime.now());
  await ref.watch(reminderSchedulerProvider).initialize();
  await ref.watch(reminderCoordinatorProvider).reconcileToday();
  await ref.watch(schedulerReminderCoordinatorProvider).reconcileAll();
});

final settingsStreamProvider = StreamProvider(
  (ref) => ref.watch(settingsRepositoryProvider).watchSettings(),
);

final apiKeysStreamProvider = StreamProvider(
  (ref) => ref.watch(apiKeyAdminRepositoryProvider).watchKeys(),
);

final pendingDraftsProvider = StreamProvider(
  (ref) => ref.watch(foodLogRepositoryProvider).watchPendingDrafts(),
);

final reminderSchedulerProvider = Provider<ReminderScheduler>(
  (ref) => LocalNotificationScheduler(),
);

final reminderRepositoryProvider = Provider<ReminderRepository>(
  (ref) => ReminderRepository(
    ref.watch(databaseProvider),
    ref.watch(reminderSchedulerProvider),
  ),
);

final reminderCoordinatorProvider = Provider<ReminderCoordinator>(
  (ref) => ReminderCoordinator(
    ref.watch(databaseProvider),
    ref.watch(targetRepositoryProvider),
    ref.watch(reminderRepositoryProvider),
  ),
);

final reminderStreamProvider = StreamProvider(
  (ref) => ref.watch(reminderRepositoryProvider).watch(),
);
