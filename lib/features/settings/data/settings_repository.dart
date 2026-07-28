import 'package:drift/drift.dart';
import 'package:keyspace/app/provider_config.dart';
import 'package:keyspace/database/app_database.dart';

class SettingsRepository {
  const SettingsRepository(this.database);

  final AppDatabase database;

  Stream<AppSetting> watchSettings() {
    return (database.select(
      database.appSettings,
    )..where((row) => row.id.equals(1))).watchSingle();
  }

  Future<AppSetting> getSettings() {
    return (database.select(
      database.appSettings,
    )..where((row) => row.id.equals(1))).getSingle();
  }

  Future<void> initialize() async {
    final now = DateTime.now().toUtc();
    await database.transaction(() async {
      await database
          .into(database.appSettings)
          .insert(
            AppSettingsCompanion.insert(
              id: const Value(1),
              onboardingCompleted: false,
              weightUnit: 'kg',
              heightUnit: 'cm',
              themeMode: 'system',
              locale: 'id',
              geminiModel: ProviderConfig.model,
              previewBeforeSave: true,
              createdAt: now,
              updatedAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await database
          .into(database.userProfiles)
          .insert(
            UserProfilesCompanion.insert(
              id: 'local_user',
              createdAt: now,
              updatedAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await database
          .into(database.reminderSettings)
          .insert(
            ReminderSettingsCompanion.insert(
              id: const Value(1),
              isEnabled: false,
              reminderTimeLocal: '20:00',
              thresholdPercent: ProviderConfig.reminderDefaultThresholdPercent,
              activeWeekdaysMask: 127,
              permissionStatus: 'not_requested',
              updatedAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
    });
  }

  Future<void> updatePreferences({
    required String weightUnit,
    required String heightUnit,
    required String themeMode,
  }) {
    return (database.update(
      database.appSettings,
    )..where((row) => row.id.equals(1))).write(
      AppSettingsCompanion(
        weightUnit: Value(weightUnit),
        heightUnit: Value(heightUnit),
        themeMode: Value(themeMode),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> completeOnboarding({String? displayName}) {
    final now = DateTime.now().toUtc();
    return database.transaction(() async {
      await (database.update(
        database.userProfiles,
      )..where((row) => row.id.equals('local_user'))).write(
        UserProfilesCompanion(
          displayName: Value(_cleanOptional(displayName)),
          updatedAt: Value(now),
        ),
      );
      await (database.update(
        database.appSettings,
      )..where((row) => row.id.equals(1))).write(
        AppSettingsCompanion(
          onboardingCompleted: const Value(true),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<void> setThemeMode(String value) {
    return (database.update(
      database.appSettings,
    )..where((row) => row.id.equals(1))).write(
      AppSettingsCompanion(
        themeMode: Value(value),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> acknowledgeVoiceDisclosure() {
    return (database.update(
      database.appSettings,
    )..where((row) => row.id.equals(1))).write(
      AppSettingsCompanion(
        voiceDisclosureAcknowledged: const Value(true),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  String? _cleanOptional(String? value) {
    final cleaned = value?.trim();
    return cleaned == null || cleaned.isEmpty ? null : cleaned;
  }
}
