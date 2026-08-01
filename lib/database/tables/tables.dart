import 'package:drift/drift.dart';

class UserProfiles extends Table {
  @override
  String get tableName => 'user_profile';

  TextColumn get id =>
      text().customConstraint("NOT NULL CHECK (id = 'local_user')")();
  TextColumn get displayName => text().named('display_name').nullable()();
  IntColumn get birthYearOrAge =>
      integer().named('birth_year_or_age').nullable()();
  TextColumn get sexForFormula => text().named('sex_for_formula').nullable()();
  RealColumn get heightCm => real().named('height_cm').nullable()();
  RealColumn get weightKg => real().named('weight_kg').nullable()();
  TextColumn get activityLevel => text().named('activity_level').nullable()();
  TextColumn get goalType => text().named('goal_type').nullable()();
  IntColumn get goalAdjustmentKcal =>
      integer().named('goal_adjustment_kcal').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AppSettings extends Table {
  @override
  String get tableName => 'app_settings';

  IntColumn get id => integer().customConstraint('NOT NULL CHECK (id = 1)')();
  BoolColumn get onboardingCompleted =>
      boolean().named('onboarding_completed')();
  TextColumn get weightUnit => text().named('weight_unit')();
  TextColumn get heightUnit => text().named('height_unit')();
  TextColumn get themeMode => text().named('theme_mode')();
  TextColumn get locale => text()();
  TextColumn get activeKeyId => text()
      .named('active_key_id')
      .nullable()
      .references(ApiKeyMetadata, #id, onDelete: KeyAction.setNull)();
  TextColumn get geminiModel => text().named('gemini_model')();
  BoolColumn get previewBeforeSave => boolean().named('preview_before_save')();
  BoolColumn get voiceDisclosureAcknowledged => boolean()
      .named('voice_disclosure_acknowledged')
      .withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'idx_daily_targets_effective', columns: {#effectiveFromDate})
class DailyTargets extends Table {
  @override
  String get tableName => 'daily_targets';

  TextColumn get id => text()();
  TextColumn get effectiveFromDate => text().named('effective_from_date')();
  IntColumn get calorieTarget => integer().named('calorie_target')();
  RealColumn get proteinTargetG =>
      real().named('protein_target_g').nullable()();
  RealColumn get carbsTargetG => real().named('carbs_target_g').nullable()();
  RealColumn get fatTargetG => real().named('fat_target_g').nullable()();
  TextColumn get source => text()();
  TextColumn get formulaSnapshotJson =>
      text().named('formula_snapshot_json').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_food_logs_local_date_deleted_status',
  columns: {#localDate, #deletedAt, #status},
)
@TableIndex(name: 'idx_food_logs_consumed_at', columns: {#consumedAtUtc})
class FoodLogs extends Table {
  @override
  String get tableName => 'food_logs';

  TextColumn get id => text()();
  TextColumn get localRequestId =>
      text().named('local_request_id').nullable().unique()();
  TextColumn get localDate => text().named('local_date')();
  DateTimeColumn get consumedAtUtc => dateTime().named('consumed_at_utc')();
  IntColumn get timezoneOffsetMinutes =>
      integer().named('timezone_offset_minutes')();
  TextColumn get mealType => text().named('meal_type')();
  TextColumn get source => text()();
  TextColumn get status => text()();
  TextColumn get originalUserText =>
      text().named('original_user_text').nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get totalCaloriesKcal => real().named('total_calories_kcal')();
  RealColumn get totalProteinG => real().named('total_protein_g').nullable()();
  RealColumn get totalCarbsG => real().named('total_carbs_g').nullable()();
  RealColumn get totalFatG => real().named('total_fat_g').nullable()();
  TextColumn get aiModel => text().named('ai_model').nullable()();
  TextColumn get aiKeyMetadataId => text()
      .named('ai_key_metadata_id')
      .nullable()
      .references(ApiKeyMetadata, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  DateTimeColumn get deletedAt => dateTime().named('deleted_at').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'idx_food_items_log_sort', columns: {#foodLogId, #sortOrder})
@TableIndex(name: 'idx_food_items_normalized_name', columns: {#normalizedName})
class FoodItems extends Table {
  @override
  String get tableName => 'food_items';

  TextColumn get id => text()();
  TextColumn get foodLogId => text()
      .named('food_log_id')
      .references(FoodLogs, #id, onDelete: KeyAction.cascade)();
  TextColumn get displayName => text().named('display_name')();
  TextColumn get normalizedName => text().named('normalized_name').nullable()();
  RealColumn get quantity => real().nullable()();
  TextColumn get unit => text().nullable()();
  TextColumn get portionText => text().named('portion_text').nullable()();
  RealColumn get caloriesKcal => real().named('calories_kcal')();
  RealColumn get proteinG => real().named('protein_g').nullable()();
  RealColumn get carbsG => real().named('carbs_g').nullable()();
  RealColumn get fatG => real().named('fat_g').nullable()();
  RealColumn get fiberG => real().named('fiber_g').nullable()();
  RealColumn get sodiumMg => real().named('sodium_mg').nullable()();
  RealColumn get confidence => real().nullable()();
  TextColumn get assumptionNote => text().named('assumption_note').nullable()();
  IntColumn get sortOrder => integer().named('sort_order')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'idx_chat_sessions_local_date', columns: {#localDate})
class ChatSessions extends Table {
  @override
  String get tableName => 'chat_sessions';

  TextColumn get id => text()();
  TextColumn get localDate => text().named('local_date')();
  TextColumn get title => text().nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_chat_messages_session_created',
  columns: {#sessionId, #createdAt},
)
@TableIndex(name: 'idx_chat_messages_local_request', columns: {#localRequestId})
class ChatMessages extends Table {
  @override
  String get tableName => 'chat_messages';

  TextColumn get id => text()();
  TextColumn get sessionId => text()
      .named('session_id')
      .references(ChatSessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get role => text()();
  TextColumn get contentText => text().named('content_text')();
  TextColumn get status => text()();
  TextColumn get foodLogId => text()
      .named('food_log_id')
      .nullable()
      .references(FoodLogs, #id, onDelete: KeyAction.setNull)();
  TextColumn get localRequestId =>
      text().named('local_request_id').nullable()();
  TextColumn get errorCategory => text().named('error_category').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_api_keys_selection',
  columns: {#isEnabled, #priorityOrder, #healthStatus, #cooldownUntil},
)
class ApiKeyMetadata extends Table {
  @override
  String get tableName => 'api_key_metadata';

  TextColumn get id => text()();
  TextColumn get alias => text()();
  TextColumn get secureRef => text().named('secure_ref').unique()();
  TextColumn get maskedSuffix => text().named('masked_suffix')();
  IntColumn get priorityOrder => integer().named('priority_order').unique()();
  BoolColumn get isEnabled => boolean().named('is_enabled')();
  TextColumn get healthStatus => text().named('health_status')();
  DateTimeColumn get cooldownUntil =>
      dateTime().named('cooldown_until').nullable()();
  DateTimeColumn get lastSuccessAt =>
      dateTime().named('last_success_at').nullable()();
  DateTimeColumn get lastFailureAt =>
      dateTime().named('last_failure_at').nullable()();
  TextColumn get lastErrorCategory =>
      text().named('last_error_category').nullable()();
  IntColumn get successCount =>
      integer().named('success_count').withDefault(const Constant(0))();
  IntColumn get failureCount =>
      integer().named('failure_count').withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_api_usage_key_created',
  columns: {#apiKeyMetadataId, #createdAt},
)
@TableIndex(name: 'idx_api_usage_request', columns: {#localRequestId})
class ApiKeyUsageEvents extends Table {
  @override
  String get tableName => 'api_key_usage_events';

  TextColumn get id => text()();
  TextColumn get apiKeyMetadataId => text()
      .named('api_key_metadata_id')
      .references(ApiKeyMetadata, #id, onDelete: KeyAction.cascade)();
  TextColumn get localRequestId => text().named('local_request_id')();
  TextColumn get operation => text()();
  TextColumn get outcome => text()();
  TextColumn get errorCategory => text().named('error_category').nullable()();
  IntColumn get httpStatus => integer().named('http_status').nullable()();
  IntColumn get latencyMs => integer().named('latency_ms').nullable()();
  IntColumn get promptTokens => integer().named('prompt_tokens').nullable()();
  IntColumn get outputTokens => integer().named('output_tokens').nullable()();
  TextColumn get modelId => text().named('model_id').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'idx_favorites_name', columns: {#name})
class FavoriteTemplates extends Table {
  @override
  String get tableName => 'favorite_templates';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get templateJson => text().named('template_json')();
  IntColumn get useCount =>
      integer().named('use_count').withDefault(const Constant(0))();
  DateTimeColumn get lastUsedAt =>
      dateTime().named('last_used_at').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ReminderSettings extends Table {
  @override
  String get tableName => 'reminder_settings';

  IntColumn get id => integer().customConstraint('NOT NULL CHECK (id = 1)')();
  BoolColumn get isEnabled => boolean().named('is_enabled')();
  TextColumn get reminderTimeLocal => text().named('reminder_time_local')();
  IntColumn get thresholdPercent => integer().named('threshold_percent')();
  IntColumn get activeWeekdaysMask => integer().named('active_weekdays_mask')();
  TextColumn get quietHoursStart =>
      text().named('quiet_hours_start').nullable()();
  TextColumn get quietHoursEnd => text().named('quiet_hours_end').nullable()();
  TextColumn get permissionStatus => text().named('permission_status')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_notification_local_date_status',
  columns: {#localDate, #status},
)
class NotificationEvents extends Table {
  @override
  String get tableName => 'notification_events';

  TextColumn get id => text()();
  TextColumn get localDate => text().named('local_date')();
  IntColumn get platformNotificationId =>
      integer().named('platform_notification_id').unique()();
  DateTimeColumn get scheduledFor => dateTime().named('scheduled_for')();
  TextColumn get status => text()();
  DateTimeColumn get openedAt => dateTime().named('opened_at').nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_financial_categories_type_active',
  columns: {#type, #isActive},
)
class FinancialCategories extends Table {
  @override
  String get tableName => 'financial_categories';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()();
  TextColumn get iconKey => text().named('icon_key').nullable()();
  BoolColumn get isSystem =>
      boolean().named('is_system').withDefault(const Constant(false))();
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {type, name},
  ];

  @override
  List<String> get customConstraints => [
    "CHECK (type IN ('expense', 'income'))",
  ];
}

@TableIndex(
  name: 'idx_financial_periods_dates',
  columns: {#startDate, #endDate},
)
class FinancialPeriods extends Table {
  @override
  String get tableName => 'financial_periods';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  DateTimeColumn get startDate => dateTime().named('start_date')();
  DateTimeColumn get endDate => dateTime().named('end_date')();
  IntColumn get cycleStartDay => integer().named('cycle_start_day')();
  IntColumn get budgetAmount =>
      integer().named('budget_amount').withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {startDate, endDate},
  ];

  @override
  List<String> get customConstraints => [
    'CHECK (cycle_start_day BETWEEN 1 AND 28)',
    'CHECK (budget_amount >= 0)',
    'CHECK (end_date >= start_date)',
  ];
}

@TableIndex(
  name: 'idx_financial_transactions_period_type_date',
  columns: {#financialPeriodId, #type, #transactionDate},
)
@TableIndex(name: 'idx_financial_transactions_category', columns: {#categoryId})
@TableIndex(
  name: 'idx_financial_transactions_period_reimburse',
  columns: {#financialPeriodId, #isReimburse},
)
@TableIndex(
  name: 'idx_financial_transactions_date_type_category',
  columns: {#transactionDate, #type, #categoryId},
)
class FinancialTransactions extends Table {
  @override
  String get tableName => 'financial_transactions';

  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  IntColumn get amount => integer()();
  TextColumn get currencyCode =>
      text().named('currency_code').withDefault(const Constant('IDR'))();
  DateTimeColumn get transactionDate => dateTime().named('transaction_date')();
  TextColumn get categoryId => text()
      .named('category_id')
      .references(FinancialCategories, #id, onDelete: KeyAction.restrict)();
  TextColumn get notes => text().nullable()();
  BoolColumn get isReimburse =>
      boolean().named('is_reimburse').withDefault(const Constant(false))();
  TextColumn get financialPeriodId => text()
      .named('financial_period_id')
      .references(FinancialPeriods, #id, onDelete: KeyAction.restrict)();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    "CHECK (type IN ('expense', 'income'))",
    'CHECK (amount > 0)',
    "CHECK (currency_code = 'IDR')",
    "CHECK (type = 'expense' OR is_reimburse = 0)",
  ];
}

class FinanceSettings extends Table {
  @override
  String get tableName => 'finance_settings';

  IntColumn get id => integer().customConstraint('NOT NULL CHECK (id = 1)')();
  IntColumn get cycleStartDay =>
      integer().named('cycle_start_day').withDefault(const Constant(25))();
  IntColumn get defaultBudgetAmount =>
      integer().named('default_budget_amount').withDefault(const Constant(0))();
  TextColumn get currencyCode =>
      text().named('currency_code').withDefault(const Constant('IDR'))();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (cycle_start_day BETWEEN 1 AND 28)',
    'CHECK (default_budget_amount >= 0)',
    "CHECK (currency_code = 'IDR')",
  ];
}

@TableIndex(name: 'idx_chat_drafts_updated', columns: {#updatedAt})
class ChatDrafts extends Table {
  @override
  String get tableName => 'chat_drafts';

  TextColumn get id => text()();
  TextColumn get draftText =>
      text().named('text').withLength(min: 1, max: 4000)();
  TextColumn get selectedMode => text().named('selected_mode')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    "CHECK (selected_mode IN ('automatic', 'nutrition', 'expense', 'income', 'schedule'))",
  ];
}

class NetWorthInitializations extends Table {
  @override
  String get tableName => 'net_worth_initialization';

  TextColumn get id =>
      text().customConstraint("NOT NULL CHECK (id = 'local_net_worth')")();
  IntColumn get initialAmount => integer().named('initial_amount')();
  DateTimeColumn get initializationDate =>
      dateTime().named('initialization_date')();
  TextColumn get notes => text().nullable()();
  TextColumn get currencyCode =>
      text().named('currency_code').withDefault(const Constant('IDR'))();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => ["CHECK (currency_code = 'IDR')"];
}

@TableIndex(name: 'idx_net_worth_adjustments_date', columns: {#adjustmentDate})
class NetWorthAdjustments extends Table {
  @override
  String get tableName => 'net_worth_adjustments';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  IntColumn get amount => integer()();
  DateTimeColumn get adjustmentDate => dateTime().named('adjustment_date')();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (amount <> 0)'];
}

@TableIndex(name: 'idx_schedule_categories_active', columns: {#isActive, #name})
class ScheduleCategories extends Table {
  @override
  String get tableName => 'schedule_categories';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get iconKey => text().named('icon_key').nullable()();
  BoolColumn get isSystem => boolean().named('is_system')();
  BoolColumn get isActive => boolean().named('is_active')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(
  name: 'idx_schedule_items_time_status',
  columns: {#status, #startAtUtc, #endAtUtc},
)
@TableIndex(
  name: 'idx_schedule_items_due_status',
  columns: {#status, #dueDateLocal, #dueAtUtc},
)
@TableIndex(
  name: 'idx_schedule_items_category',
  columns: {#categoryId, #status},
)
class ScheduleItems extends Table {
  @override
  String get tableName => 'schedule_items';

  TextColumn get id => text()();
  TextColumn get itemType => text().named('item_type')();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startAtUtc =>
      dateTime().named('start_at_utc').nullable()();
  DateTimeColumn get endAtUtc => dateTime().named('end_at_utc').nullable()();
  DateTimeColumn get dueAtUtc => dateTime().named('due_at_utc').nullable()();
  TextColumn get localStartDate =>
      text().named('local_start_date').nullable()();
  TextColumn get localStartTime =>
      text().named('local_start_time').nullable()();
  TextColumn get localEndTime => text().named('local_end_time').nullable()();
  TextColumn get dueDateLocal => text().named('due_date_local').nullable()();
  BoolColumn get allDay => boolean().named('all_day')();
  TextColumn get categoryId => text()
      .named('category_id')
      .references(ScheduleCategories, #id, onDelete: KeyAction.restrict)();
  TextColumn get priority => text()();
  TextColumn get status => text()();
  TextColumn get timezone => text()();
  TextColumn get recurrenceType => text().named('recurrence_type')();
  IntColumn get recurrenceInterval =>
      integer().named('recurrence_interval').withDefault(const Constant(1))();
  TextColumn get recurrenceWeekdaysJson =>
      text().named('recurrence_weekdays_json').nullable()();
  TextColumn get recurrenceEndDateLocal =>
      text().named('recurrence_end_date_local').nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get originalUserText =>
      text().named('original_user_text').nullable()();
  DateTimeColumn get completedAt =>
      dateTime().named('completed_at').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    "CHECK (item_type IN ('event', 'task'))",
    "CHECK (priority IN ('low', 'medium', 'high'))",
    "CHECK (status IN ('pending', 'completed', 'cancelled'))",
    "CHECK (recurrence_type IN ('none', 'daily', 'weekly', 'monthly'))",
    'CHECK (recurrence_interval >= 1)',
    "CHECK ((item_type = 'event' AND (all_day = 1 OR start_at_utc IS NOT NULL)) OR item_type = 'task')",
    'CHECK (end_at_utc IS NULL OR start_at_utc IS NULL OR end_at_utc > start_at_utc)',
  ];
}

@TableIndex(
  name: 'idx_schedule_reminders_item_enabled',
  columns: {#scheduleItemId, #isEnabled},
)
class ScheduleReminders extends Table {
  @override
  String get tableName => 'schedule_reminders';

  TextColumn get id => text()();
  TextColumn get scheduleItemId => text()
      .named('schedule_item_id')
      .references(ScheduleItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get reminderType => text()
      .named('reminder_type')
      .withDefault(const Constant('minutes_before'))();
  IntColumn get offsetMinutes => integer().named('offset_minutes')();
  BoolColumn get isEnabled => boolean().named('is_enabled')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    "CHECK (reminder_type IN ('day_before', 'minutes_before'))",
  ];
}

@TableIndex(
  name: 'idx_schedule_occurrences_item_time',
  columns: {#scheduleItemId, #scheduledAtUtc},
)
@TableIndex(
  name: 'idx_schedule_occurrences_sync',
  columns: {#syncStatus, #scheduledAtUtc},
)
class ScheduleNotificationOccurrences extends Table {
  @override
  String get tableName => 'schedule_notification_occurrences';

  TextColumn get id => text()();
  TextColumn get reminderId => text()
      .named('reminder_id')
      .references(ScheduleReminders, #id, onDelete: KeyAction.cascade)();
  TextColumn get scheduleItemId => text()
      .named('schedule_item_id')
      .references(ScheduleItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get occurrenceKey => text().named('occurrence_key')();
  IntColumn get platformNotificationId =>
      integer().named('platform_notification_id').unique()();
  DateTimeColumn get scheduledAtUtc => dateTime().named('scheduled_at_utc')();
  TextColumn get syncStatus =>
      text().named('sync_status').withDefault(const Constant('pending'))();
  TextColumn get lastError => text().named('last_error').nullable()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {reminderId, occurrenceKey},
  ];
}

class SchedulerSettings extends Table {
  @override
  String get tableName => 'scheduler_settings';

  IntColumn get id => integer().customConstraint('NOT NULL CHECK (id = 1)')();
  IntColumn get defaultEventDurationMinutes => integer()
      .named('default_event_duration_minutes')
      .withDefault(const Constant(60))();
  IntColumn get defaultReminderMinutes => integer()
      .named('default_reminder_minutes')
      .withDefault(const Constant(15))();
  TextColumn get defaultTaskReminderTime => text()
      .named('default_task_reminder_time')
      .withDefault(const Constant('09:00'))();
  TextColumn get weekStartsOn =>
      text().named('week_starts_on').withDefault(const Constant('monday'))();
  TextColumn get timezone =>
      text().withDefault(const Constant('Asia/Jakarta'))();
  IntColumn get rollingHorizonDays =>
      integer().named('rolling_horizon_days').withDefault(const Constant(30))();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
