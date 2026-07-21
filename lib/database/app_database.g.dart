// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (id = \'local_user\')',
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthYearOrAgeMeta = const VerificationMeta(
    'birthYearOrAge',
  );
  @override
  late final GeneratedColumn<int> birthYearOrAge = GeneratedColumn<int>(
    'birth_year_or_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexForFormulaMeta = const VerificationMeta(
    'sexForFormula',
  );
  @override
  late final GeneratedColumn<String> sexForFormula = GeneratedColumn<String>(
    'sex_for_formula',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityLevelMeta = const VerificationMeta(
    'activityLevel',
  );
  @override
  late final GeneratedColumn<String> activityLevel = GeneratedColumn<String>(
    'activity_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalTypeMeta = const VerificationMeta(
    'goalType',
  );
  @override
  late final GeneratedColumn<String> goalType = GeneratedColumn<String>(
    'goal_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalAdjustmentKcalMeta =
      const VerificationMeta('goalAdjustmentKcal');
  @override
  late final GeneratedColumn<int> goalAdjustmentKcal = GeneratedColumn<int>(
    'goal_adjustment_kcal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    birthYearOrAge,
    sexForFormula,
    heightCm,
    weightKg,
    activityLevel,
    goalType,
    goalAdjustmentKcal,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('birth_year_or_age')) {
      context.handle(
        _birthYearOrAgeMeta,
        birthYearOrAge.isAcceptableOrUnknown(
          data['birth_year_or_age']!,
          _birthYearOrAgeMeta,
        ),
      );
    }
    if (data.containsKey('sex_for_formula')) {
      context.handle(
        _sexForFormulaMeta,
        sexForFormula.isAcceptableOrUnknown(
          data['sex_for_formula']!,
          _sexForFormulaMeta,
        ),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('activity_level')) {
      context.handle(
        _activityLevelMeta,
        activityLevel.isAcceptableOrUnknown(
          data['activity_level']!,
          _activityLevelMeta,
        ),
      );
    }
    if (data.containsKey('goal_type')) {
      context.handle(
        _goalTypeMeta,
        goalType.isAcceptableOrUnknown(data['goal_type']!, _goalTypeMeta),
      );
    }
    if (data.containsKey('goal_adjustment_kcal')) {
      context.handle(
        _goalAdjustmentKcalMeta,
        goalAdjustmentKcal.isAcceptableOrUnknown(
          data['goal_adjustment_kcal']!,
          _goalAdjustmentKcalMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      birthYearOrAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}birth_year_or_age'],
      ),
      sexForFormula: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex_for_formula'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      activityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_level'],
      ),
      goalType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_type'],
      ),
      goalAdjustmentKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_adjustment_kcal'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String? displayName;
  final int? birthYearOrAge;
  final String? sexForFormula;
  final double? heightCm;
  final double? weightKg;
  final String? activityLevel;
  final String? goalType;
  final int? goalAdjustmentKcal;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfile({
    required this.id,
    this.displayName,
    this.birthYearOrAge,
    this.sexForFormula,
    this.heightCm,
    this.weightKg,
    this.activityLevel,
    this.goalType,
    this.goalAdjustmentKcal,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || birthYearOrAge != null) {
      map['birth_year_or_age'] = Variable<int>(birthYearOrAge);
    }
    if (!nullToAbsent || sexForFormula != null) {
      map['sex_for_formula'] = Variable<String>(sexForFormula);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || activityLevel != null) {
      map['activity_level'] = Variable<String>(activityLevel);
    }
    if (!nullToAbsent || goalType != null) {
      map['goal_type'] = Variable<String>(goalType);
    }
    if (!nullToAbsent || goalAdjustmentKcal != null) {
      map['goal_adjustment_kcal'] = Variable<int>(goalAdjustmentKcal);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      birthYearOrAge: birthYearOrAge == null && nullToAbsent
          ? const Value.absent()
          : Value(birthYearOrAge),
      sexForFormula: sexForFormula == null && nullToAbsent
          ? const Value.absent()
          : Value(sexForFormula),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      activityLevel: activityLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(activityLevel),
      goalType: goalType == null && nullToAbsent
          ? const Value.absent()
          : Value(goalType),
      goalAdjustmentKcal: goalAdjustmentKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(goalAdjustmentKcal),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      birthYearOrAge: serializer.fromJson<int?>(json['birthYearOrAge']),
      sexForFormula: serializer.fromJson<String?>(json['sexForFormula']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      activityLevel: serializer.fromJson<String?>(json['activityLevel']),
      goalType: serializer.fromJson<String?>(json['goalType']),
      goalAdjustmentKcal: serializer.fromJson<int?>(json['goalAdjustmentKcal']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'birthYearOrAge': serializer.toJson<int?>(birthYearOrAge),
      'sexForFormula': serializer.toJson<String?>(sexForFormula),
      'heightCm': serializer.toJson<double?>(heightCm),
      'weightKg': serializer.toJson<double?>(weightKg),
      'activityLevel': serializer.toJson<String?>(activityLevel),
      'goalType': serializer.toJson<String?>(goalType),
      'goalAdjustmentKcal': serializer.toJson<int?>(goalAdjustmentKcal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith({
    String? id,
    Value<String?> displayName = const Value.absent(),
    Value<int?> birthYearOrAge = const Value.absent(),
    Value<String?> sexForFormula = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<String?> activityLevel = const Value.absent(),
    Value<String?> goalType = const Value.absent(),
    Value<int?> goalAdjustmentKcal = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserProfile(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    birthYearOrAge: birthYearOrAge.present
        ? birthYearOrAge.value
        : this.birthYearOrAge,
    sexForFormula: sexForFormula.present
        ? sexForFormula.value
        : this.sexForFormula,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    activityLevel: activityLevel.present
        ? activityLevel.value
        : this.activityLevel,
    goalType: goalType.present ? goalType.value : this.goalType,
    goalAdjustmentKcal: goalAdjustmentKcal.present
        ? goalAdjustmentKcal.value
        : this.goalAdjustmentKcal,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      birthYearOrAge: data.birthYearOrAge.present
          ? data.birthYearOrAge.value
          : this.birthYearOrAge,
      sexForFormula: data.sexForFormula.present
          ? data.sexForFormula.value
          : this.sexForFormula,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      goalAdjustmentKcal: data.goalAdjustmentKcal.present
          ? data.goalAdjustmentKcal.value
          : this.goalAdjustmentKcal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('birthYearOrAge: $birthYearOrAge, ')
          ..write('sexForFormula: $sexForFormula, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goalType: $goalType, ')
          ..write('goalAdjustmentKcal: $goalAdjustmentKcal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    birthYearOrAge,
    sexForFormula,
    heightCm,
    weightKg,
    activityLevel,
    goalType,
    goalAdjustmentKcal,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.birthYearOrAge == this.birthYearOrAge &&
          other.sexForFormula == this.sexForFormula &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.activityLevel == this.activityLevel &&
          other.goalType == this.goalType &&
          other.goalAdjustmentKcal == this.goalAdjustmentKcal &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String?> displayName;
  final Value<int?> birthYearOrAge;
  final Value<String?> sexForFormula;
  final Value<double?> heightCm;
  final Value<double?> weightKg;
  final Value<String?> activityLevel;
  final Value<String?> goalType;
  final Value<int?> goalAdjustmentKcal;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.birthYearOrAge = const Value.absent(),
    this.sexForFormula = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.goalType = const Value.absent(),
    this.goalAdjustmentKcal = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    this.displayName = const Value.absent(),
    this.birthYearOrAge = const Value.absent(),
    this.sexForFormula = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.goalType = const Value.absent(),
    this.goalAdjustmentKcal = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<int>? birthYearOrAge,
    Expression<String>? sexForFormula,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? activityLevel,
    Expression<String>? goalType,
    Expression<int>? goalAdjustmentKcal,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (birthYearOrAge != null) 'birth_year_or_age': birthYearOrAge,
      if (sexForFormula != null) 'sex_for_formula': sexForFormula,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (goalType != null) 'goal_type': goalType,
      if (goalAdjustmentKcal != null)
        'goal_adjustment_kcal': goalAdjustmentKcal,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? displayName,
    Value<int?>? birthYearOrAge,
    Value<String?>? sexForFormula,
    Value<double?>? heightCm,
    Value<double?>? weightKg,
    Value<String?>? activityLevel,
    Value<String?>? goalType,
    Value<int?>? goalAdjustmentKcal,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      birthYearOrAge: birthYearOrAge ?? this.birthYearOrAge,
      sexForFormula: sexForFormula ?? this.sexForFormula,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      activityLevel: activityLevel ?? this.activityLevel,
      goalType: goalType ?? this.goalType,
      goalAdjustmentKcal: goalAdjustmentKcal ?? this.goalAdjustmentKcal,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (birthYearOrAge.present) {
      map['birth_year_or_age'] = Variable<int>(birthYearOrAge.value);
    }
    if (sexForFormula.present) {
      map['sex_for_formula'] = Variable<String>(sexForFormula.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<String>(activityLevel.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(goalType.value);
    }
    if (goalAdjustmentKcal.present) {
      map['goal_adjustment_kcal'] = Variable<int>(goalAdjustmentKcal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('birthYearOrAge: $birthYearOrAge, ')
          ..write('sexForFormula: $sexForFormula, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('goalType: $goalType, ')
          ..write('goalAdjustmentKcal: $goalAdjustmentKcal, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ApiKeyMetadataTable extends ApiKeyMetadata
    with TableInfo<$ApiKeyMetadataTable, ApiKeyMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiKeyMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
    'alias',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secureRefMeta = const VerificationMeta(
    'secureRef',
  );
  @override
  late final GeneratedColumn<String> secureRef = GeneratedColumn<String>(
    'secure_ref',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _maskedSuffixMeta = const VerificationMeta(
    'maskedSuffix',
  );
  @override
  late final GeneratedColumn<String> maskedSuffix = GeneratedColumn<String>(
    'masked_suffix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityOrderMeta = const VerificationMeta(
    'priorityOrder',
  );
  @override
  late final GeneratedColumn<int> priorityOrder = GeneratedColumn<int>(
    'priority_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _healthStatusMeta = const VerificationMeta(
    'healthStatus',
  );
  @override
  late final GeneratedColumn<String> healthStatus = GeneratedColumn<String>(
    'health_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cooldownUntilMeta = const VerificationMeta(
    'cooldownUntil',
  );
  @override
  late final GeneratedColumn<DateTime> cooldownUntil =
      GeneratedColumn<DateTime>(
        'cooldown_until',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastSuccessAtMeta = const VerificationMeta(
    'lastSuccessAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>(
        'last_success_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastFailureAtMeta = const VerificationMeta(
    'lastFailureAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastFailureAt =
      GeneratedColumn<DateTime>(
        'last_failure_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastErrorCategoryMeta = const VerificationMeta(
    'lastErrorCategory',
  );
  @override
  late final GeneratedColumn<String> lastErrorCategory =
      GeneratedColumn<String>(
        'last_error_category',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _successCountMeta = const VerificationMeta(
    'successCount',
  );
  @override
  late final GeneratedColumn<int> successCount = GeneratedColumn<int>(
    'success_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _failureCountMeta = const VerificationMeta(
    'failureCount',
  );
  @override
  late final GeneratedColumn<int> failureCount = GeneratedColumn<int>(
    'failure_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    alias,
    secureRef,
    maskedSuffix,
    priorityOrder,
    isEnabled,
    healthStatus,
    cooldownUntil,
    lastSuccessAt,
    lastFailureAt,
    lastErrorCategory,
    successCount,
    failureCount,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'api_key_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApiKeyMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
        _aliasMeta,
        alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta),
      );
    } else if (isInserting) {
      context.missing(_aliasMeta);
    }
    if (data.containsKey('secure_ref')) {
      context.handle(
        _secureRefMeta,
        secureRef.isAcceptableOrUnknown(data['secure_ref']!, _secureRefMeta),
      );
    } else if (isInserting) {
      context.missing(_secureRefMeta);
    }
    if (data.containsKey('masked_suffix')) {
      context.handle(
        _maskedSuffixMeta,
        maskedSuffix.isAcceptableOrUnknown(
          data['masked_suffix']!,
          _maskedSuffixMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maskedSuffixMeta);
    }
    if (data.containsKey('priority_order')) {
      context.handle(
        _priorityOrderMeta,
        priorityOrder.isAcceptableOrUnknown(
          data['priority_order']!,
          _priorityOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_priorityOrderMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    } else if (isInserting) {
      context.missing(_isEnabledMeta);
    }
    if (data.containsKey('health_status')) {
      context.handle(
        _healthStatusMeta,
        healthStatus.isAcceptableOrUnknown(
          data['health_status']!,
          _healthStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_healthStatusMeta);
    }
    if (data.containsKey('cooldown_until')) {
      context.handle(
        _cooldownUntilMeta,
        cooldownUntil.isAcceptableOrUnknown(
          data['cooldown_until']!,
          _cooldownUntilMeta,
        ),
      );
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
        _lastSuccessAtMeta,
        lastSuccessAt.isAcceptableOrUnknown(
          data['last_success_at']!,
          _lastSuccessAtMeta,
        ),
      );
    }
    if (data.containsKey('last_failure_at')) {
      context.handle(
        _lastFailureAtMeta,
        lastFailureAt.isAcceptableOrUnknown(
          data['last_failure_at']!,
          _lastFailureAtMeta,
        ),
      );
    }
    if (data.containsKey('last_error_category')) {
      context.handle(
        _lastErrorCategoryMeta,
        lastErrorCategory.isAcceptableOrUnknown(
          data['last_error_category']!,
          _lastErrorCategoryMeta,
        ),
      );
    }
    if (data.containsKey('success_count')) {
      context.handle(
        _successCountMeta,
        successCount.isAcceptableOrUnknown(
          data['success_count']!,
          _successCountMeta,
        ),
      );
    }
    if (data.containsKey('failure_count')) {
      context.handle(
        _failureCountMeta,
        failureCount.isAcceptableOrUnknown(
          data['failure_count']!,
          _failureCountMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApiKeyMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApiKeyMetadataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      alias: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias'],
      )!,
      secureRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secure_ref'],
      )!,
      maskedSuffix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}masked_suffix'],
      )!,
      priorityOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_order'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      healthStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}health_status'],
      )!,
      cooldownUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cooldown_until'],
      ),
      lastSuccessAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_success_at'],
      ),
      lastFailureAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_failure_at'],
      ),
      lastErrorCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error_category'],
      ),
      successCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}success_count'],
      )!,
      failureCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failure_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ApiKeyMetadataTable createAlias(String alias) {
    return $ApiKeyMetadataTable(attachedDatabase, alias);
  }
}

class ApiKeyMetadataData extends DataClass
    implements Insertable<ApiKeyMetadataData> {
  final String id;
  final String alias;
  final String secureRef;
  final String maskedSuffix;
  final int priorityOrder;
  final bool isEnabled;
  final String healthStatus;
  final DateTime? cooldownUntil;
  final DateTime? lastSuccessAt;
  final DateTime? lastFailureAt;
  final String? lastErrorCategory;
  final int successCount;
  final int failureCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ApiKeyMetadataData({
    required this.id,
    required this.alias,
    required this.secureRef,
    required this.maskedSuffix,
    required this.priorityOrder,
    required this.isEnabled,
    required this.healthStatus,
    this.cooldownUntil,
    this.lastSuccessAt,
    this.lastFailureAt,
    this.lastErrorCategory,
    required this.successCount,
    required this.failureCount,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['alias'] = Variable<String>(alias);
    map['secure_ref'] = Variable<String>(secureRef);
    map['masked_suffix'] = Variable<String>(maskedSuffix);
    map['priority_order'] = Variable<int>(priorityOrder);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['health_status'] = Variable<String>(healthStatus);
    if (!nullToAbsent || cooldownUntil != null) {
      map['cooldown_until'] = Variable<DateTime>(cooldownUntil);
    }
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    if (!nullToAbsent || lastFailureAt != null) {
      map['last_failure_at'] = Variable<DateTime>(lastFailureAt);
    }
    if (!nullToAbsent || lastErrorCategory != null) {
      map['last_error_category'] = Variable<String>(lastErrorCategory);
    }
    map['success_count'] = Variable<int>(successCount);
    map['failure_count'] = Variable<int>(failureCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ApiKeyMetadataCompanion toCompanion(bool nullToAbsent) {
    return ApiKeyMetadataCompanion(
      id: Value(id),
      alias: Value(alias),
      secureRef: Value(secureRef),
      maskedSuffix: Value(maskedSuffix),
      priorityOrder: Value(priorityOrder),
      isEnabled: Value(isEnabled),
      healthStatus: Value(healthStatus),
      cooldownUntil: cooldownUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(cooldownUntil),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      lastFailureAt: lastFailureAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFailureAt),
      lastErrorCategory: lastErrorCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCategory),
      successCount: Value(successCount),
      failureCount: Value(failureCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ApiKeyMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApiKeyMetadataData(
      id: serializer.fromJson<String>(json['id']),
      alias: serializer.fromJson<String>(json['alias']),
      secureRef: serializer.fromJson<String>(json['secureRef']),
      maskedSuffix: serializer.fromJson<String>(json['maskedSuffix']),
      priorityOrder: serializer.fromJson<int>(json['priorityOrder']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      healthStatus: serializer.fromJson<String>(json['healthStatus']),
      cooldownUntil: serializer.fromJson<DateTime?>(json['cooldownUntil']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      lastFailureAt: serializer.fromJson<DateTime?>(json['lastFailureAt']),
      lastErrorCategory: serializer.fromJson<String?>(
        json['lastErrorCategory'],
      ),
      successCount: serializer.fromJson<int>(json['successCount']),
      failureCount: serializer.fromJson<int>(json['failureCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'alias': serializer.toJson<String>(alias),
      'secureRef': serializer.toJson<String>(secureRef),
      'maskedSuffix': serializer.toJson<String>(maskedSuffix),
      'priorityOrder': serializer.toJson<int>(priorityOrder),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'healthStatus': serializer.toJson<String>(healthStatus),
      'cooldownUntil': serializer.toJson<DateTime?>(cooldownUntil),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'lastFailureAt': serializer.toJson<DateTime?>(lastFailureAt),
      'lastErrorCategory': serializer.toJson<String?>(lastErrorCategory),
      'successCount': serializer.toJson<int>(successCount),
      'failureCount': serializer.toJson<int>(failureCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ApiKeyMetadataData copyWith({
    String? id,
    String? alias,
    String? secureRef,
    String? maskedSuffix,
    int? priorityOrder,
    bool? isEnabled,
    String? healthStatus,
    Value<DateTime?> cooldownUntil = const Value.absent(),
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    Value<DateTime?> lastFailureAt = const Value.absent(),
    Value<String?> lastErrorCategory = const Value.absent(),
    int? successCount,
    int? failureCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ApiKeyMetadataData(
    id: id ?? this.id,
    alias: alias ?? this.alias,
    secureRef: secureRef ?? this.secureRef,
    maskedSuffix: maskedSuffix ?? this.maskedSuffix,
    priorityOrder: priorityOrder ?? this.priorityOrder,
    isEnabled: isEnabled ?? this.isEnabled,
    healthStatus: healthStatus ?? this.healthStatus,
    cooldownUntil: cooldownUntil.present
        ? cooldownUntil.value
        : this.cooldownUntil,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    lastFailureAt: lastFailureAt.present
        ? lastFailureAt.value
        : this.lastFailureAt,
    lastErrorCategory: lastErrorCategory.present
        ? lastErrorCategory.value
        : this.lastErrorCategory,
    successCount: successCount ?? this.successCount,
    failureCount: failureCount ?? this.failureCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ApiKeyMetadataData copyWithCompanion(ApiKeyMetadataCompanion data) {
    return ApiKeyMetadataData(
      id: data.id.present ? data.id.value : this.id,
      alias: data.alias.present ? data.alias.value : this.alias,
      secureRef: data.secureRef.present ? data.secureRef.value : this.secureRef,
      maskedSuffix: data.maskedSuffix.present
          ? data.maskedSuffix.value
          : this.maskedSuffix,
      priorityOrder: data.priorityOrder.present
          ? data.priorityOrder.value
          : this.priorityOrder,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      healthStatus: data.healthStatus.present
          ? data.healthStatus.value
          : this.healthStatus,
      cooldownUntil: data.cooldownUntil.present
          ? data.cooldownUntil.value
          : this.cooldownUntil,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      lastFailureAt: data.lastFailureAt.present
          ? data.lastFailureAt.value
          : this.lastFailureAt,
      lastErrorCategory: data.lastErrorCategory.present
          ? data.lastErrorCategory.value
          : this.lastErrorCategory,
      successCount: data.successCount.present
          ? data.successCount.value
          : this.successCount,
      failureCount: data.failureCount.present
          ? data.failureCount.value
          : this.failureCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApiKeyMetadataData(')
          ..write('id: $id, ')
          ..write('alias: $alias, ')
          ..write('secureRef: $secureRef, ')
          ..write('maskedSuffix: $maskedSuffix, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('healthStatus: $healthStatus, ')
          ..write('cooldownUntil: $cooldownUntil, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastFailureAt: $lastFailureAt, ')
          ..write('lastErrorCategory: $lastErrorCategory, ')
          ..write('successCount: $successCount, ')
          ..write('failureCount: $failureCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    alias,
    secureRef,
    maskedSuffix,
    priorityOrder,
    isEnabled,
    healthStatus,
    cooldownUntil,
    lastSuccessAt,
    lastFailureAt,
    lastErrorCategory,
    successCount,
    failureCount,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiKeyMetadataData &&
          other.id == this.id &&
          other.alias == this.alias &&
          other.secureRef == this.secureRef &&
          other.maskedSuffix == this.maskedSuffix &&
          other.priorityOrder == this.priorityOrder &&
          other.isEnabled == this.isEnabled &&
          other.healthStatus == this.healthStatus &&
          other.cooldownUntil == this.cooldownUntil &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.lastFailureAt == this.lastFailureAt &&
          other.lastErrorCategory == this.lastErrorCategory &&
          other.successCount == this.successCount &&
          other.failureCount == this.failureCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ApiKeyMetadataCompanion extends UpdateCompanion<ApiKeyMetadataData> {
  final Value<String> id;
  final Value<String> alias;
  final Value<String> secureRef;
  final Value<String> maskedSuffix;
  final Value<int> priorityOrder;
  final Value<bool> isEnabled;
  final Value<String> healthStatus;
  final Value<DateTime?> cooldownUntil;
  final Value<DateTime?> lastSuccessAt;
  final Value<DateTime?> lastFailureAt;
  final Value<String?> lastErrorCategory;
  final Value<int> successCount;
  final Value<int> failureCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ApiKeyMetadataCompanion({
    this.id = const Value.absent(),
    this.alias = const Value.absent(),
    this.secureRef = const Value.absent(),
    this.maskedSuffix = const Value.absent(),
    this.priorityOrder = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.healthStatus = const Value.absent(),
    this.cooldownUntil = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastFailureAt = const Value.absent(),
    this.lastErrorCategory = const Value.absent(),
    this.successCount = const Value.absent(),
    this.failureCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApiKeyMetadataCompanion.insert({
    required String id,
    required String alias,
    required String secureRef,
    required String maskedSuffix,
    required int priorityOrder,
    required bool isEnabled,
    required String healthStatus,
    this.cooldownUntil = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastFailureAt = const Value.absent(),
    this.lastErrorCategory = const Value.absent(),
    this.successCount = const Value.absent(),
    this.failureCount = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       alias = Value(alias),
       secureRef = Value(secureRef),
       maskedSuffix = Value(maskedSuffix),
       priorityOrder = Value(priorityOrder),
       isEnabled = Value(isEnabled),
       healthStatus = Value(healthStatus),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ApiKeyMetadataData> custom({
    Expression<String>? id,
    Expression<String>? alias,
    Expression<String>? secureRef,
    Expression<String>? maskedSuffix,
    Expression<int>? priorityOrder,
    Expression<bool>? isEnabled,
    Expression<String>? healthStatus,
    Expression<DateTime>? cooldownUntil,
    Expression<DateTime>? lastSuccessAt,
    Expression<DateTime>? lastFailureAt,
    Expression<String>? lastErrorCategory,
    Expression<int>? successCount,
    Expression<int>? failureCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alias != null) 'alias': alias,
      if (secureRef != null) 'secure_ref': secureRef,
      if (maskedSuffix != null) 'masked_suffix': maskedSuffix,
      if (priorityOrder != null) 'priority_order': priorityOrder,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (healthStatus != null) 'health_status': healthStatus,
      if (cooldownUntil != null) 'cooldown_until': cooldownUntil,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (lastFailureAt != null) 'last_failure_at': lastFailureAt,
      if (lastErrorCategory != null) 'last_error_category': lastErrorCategory,
      if (successCount != null) 'success_count': successCount,
      if (failureCount != null) 'failure_count': failureCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApiKeyMetadataCompanion copyWith({
    Value<String>? id,
    Value<String>? alias,
    Value<String>? secureRef,
    Value<String>? maskedSuffix,
    Value<int>? priorityOrder,
    Value<bool>? isEnabled,
    Value<String>? healthStatus,
    Value<DateTime?>? cooldownUntil,
    Value<DateTime?>? lastSuccessAt,
    Value<DateTime?>? lastFailureAt,
    Value<String?>? lastErrorCategory,
    Value<int>? successCount,
    Value<int>? failureCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ApiKeyMetadataCompanion(
      id: id ?? this.id,
      alias: alias ?? this.alias,
      secureRef: secureRef ?? this.secureRef,
      maskedSuffix: maskedSuffix ?? this.maskedSuffix,
      priorityOrder: priorityOrder ?? this.priorityOrder,
      isEnabled: isEnabled ?? this.isEnabled,
      healthStatus: healthStatus ?? this.healthStatus,
      cooldownUntil: cooldownUntil ?? this.cooldownUntil,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      lastFailureAt: lastFailureAt ?? this.lastFailureAt,
      lastErrorCategory: lastErrorCategory ?? this.lastErrorCategory,
      successCount: successCount ?? this.successCount,
      failureCount: failureCount ?? this.failureCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (secureRef.present) {
      map['secure_ref'] = Variable<String>(secureRef.value);
    }
    if (maskedSuffix.present) {
      map['masked_suffix'] = Variable<String>(maskedSuffix.value);
    }
    if (priorityOrder.present) {
      map['priority_order'] = Variable<int>(priorityOrder.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (healthStatus.present) {
      map['health_status'] = Variable<String>(healthStatus.value);
    }
    if (cooldownUntil.present) {
      map['cooldown_until'] = Variable<DateTime>(cooldownUntil.value);
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (lastFailureAt.present) {
      map['last_failure_at'] = Variable<DateTime>(lastFailureAt.value);
    }
    if (lastErrorCategory.present) {
      map['last_error_category'] = Variable<String>(lastErrorCategory.value);
    }
    if (successCount.present) {
      map['success_count'] = Variable<int>(successCount.value);
    }
    if (failureCount.present) {
      map['failure_count'] = Variable<int>(failureCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiKeyMetadataCompanion(')
          ..write('id: $id, ')
          ..write('alias: $alias, ')
          ..write('secureRef: $secureRef, ')
          ..write('maskedSuffix: $maskedSuffix, ')
          ..write('priorityOrder: $priorityOrder, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('healthStatus: $healthStatus, ')
          ..write('cooldownUntil: $cooldownUntil, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastFailureAt: $lastFailureAt, ')
          ..write('lastErrorCategory: $lastErrorCategory, ')
          ..write('successCount: $successCount, ')
          ..write('failureCount: $failureCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL CHECK (id = 1)',
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _weightUnitMeta = const VerificationMeta(
    'weightUnit',
  );
  @override
  late final GeneratedColumn<String> weightUnit = GeneratedColumn<String>(
    'weight_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightUnitMeta = const VerificationMeta(
    'heightUnit',
  );
  @override
  late final GeneratedColumn<String> heightUnit = GeneratedColumn<String>(
    'height_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeKeyIdMeta = const VerificationMeta(
    'activeKeyId',
  );
  @override
  late final GeneratedColumn<String> activeKeyId = GeneratedColumn<String>(
    'active_key_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES api_key_metadata (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _geminiModelMeta = const VerificationMeta(
    'geminiModel',
  );
  @override
  late final GeneratedColumn<String> geminiModel = GeneratedColumn<String>(
    'gemini_model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previewBeforeSaveMeta = const VerificationMeta(
    'previewBeforeSave',
  );
  @override
  late final GeneratedColumn<bool> previewBeforeSave = GeneratedColumn<bool>(
    'preview_before_save',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("preview_before_save" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboardingCompleted,
    weightUnit,
    heightUnit,
    themeMode,
    locale,
    activeKeyId,
    geminiModel,
    previewBeforeSave,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_onboardingCompletedMeta);
    }
    if (data.containsKey('weight_unit')) {
      context.handle(
        _weightUnitMeta,
        weightUnit.isAcceptableOrUnknown(data['weight_unit']!, _weightUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_weightUnitMeta);
    }
    if (data.containsKey('height_unit')) {
      context.handle(
        _heightUnitMeta,
        heightUnit.isAcceptableOrUnknown(data['height_unit']!, _heightUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_heightUnitMeta);
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    } else if (isInserting) {
      context.missing(_themeModeMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    } else if (isInserting) {
      context.missing(_localeMeta);
    }
    if (data.containsKey('active_key_id')) {
      context.handle(
        _activeKeyIdMeta,
        activeKeyId.isAcceptableOrUnknown(
          data['active_key_id']!,
          _activeKeyIdMeta,
        ),
      );
    }
    if (data.containsKey('gemini_model')) {
      context.handle(
        _geminiModelMeta,
        geminiModel.isAcceptableOrUnknown(
          data['gemini_model']!,
          _geminiModelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_geminiModelMeta);
    }
    if (data.containsKey('preview_before_save')) {
      context.handle(
        _previewBeforeSaveMeta,
        previewBeforeSave.isAcceptableOrUnknown(
          data['preview_before_save']!,
          _previewBeforeSaveMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previewBeforeSaveMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      weightUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight_unit'],
      )!,
      heightUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}height_unit'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      activeKeyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_key_id'],
      ),
      geminiModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gemini_model'],
      )!,
      previewBeforeSave: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}preview_before_save'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final bool onboardingCompleted;
  final String weightUnit;
  final String heightUnit;
  final String themeMode;
  final String locale;
  final String? activeKeyId;
  final String geminiModel;
  final bool previewBeforeSave;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppSetting({
    required this.id,
    required this.onboardingCompleted,
    required this.weightUnit,
    required this.heightUnit,
    required this.themeMode,
    required this.locale,
    this.activeKeyId,
    required this.geminiModel,
    required this.previewBeforeSave,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['weight_unit'] = Variable<String>(weightUnit);
    map['height_unit'] = Variable<String>(heightUnit);
    map['theme_mode'] = Variable<String>(themeMode);
    map['locale'] = Variable<String>(locale);
    if (!nullToAbsent || activeKeyId != null) {
      map['active_key_id'] = Variable<String>(activeKeyId);
    }
    map['gemini_model'] = Variable<String>(geminiModel);
    map['preview_before_save'] = Variable<bool>(previewBeforeSave);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      onboardingCompleted: Value(onboardingCompleted),
      weightUnit: Value(weightUnit),
      heightUnit: Value(heightUnit),
      themeMode: Value(themeMode),
      locale: Value(locale),
      activeKeyId: activeKeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeKeyId),
      geminiModel: Value(geminiModel),
      previewBeforeSave: Value(previewBeforeSave),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      weightUnit: serializer.fromJson<String>(json['weightUnit']),
      heightUnit: serializer.fromJson<String>(json['heightUnit']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      locale: serializer.fromJson<String>(json['locale']),
      activeKeyId: serializer.fromJson<String?>(json['activeKeyId']),
      geminiModel: serializer.fromJson<String>(json['geminiModel']),
      previewBeforeSave: serializer.fromJson<bool>(json['previewBeforeSave']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'weightUnit': serializer.toJson<String>(weightUnit),
      'heightUnit': serializer.toJson<String>(heightUnit),
      'themeMode': serializer.toJson<String>(themeMode),
      'locale': serializer.toJson<String>(locale),
      'activeKeyId': serializer.toJson<String?>(activeKeyId),
      'geminiModel': serializer.toJson<String>(geminiModel),
      'previewBeforeSave': serializer.toJson<bool>(previewBeforeSave),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({
    int? id,
    bool? onboardingCompleted,
    String? weightUnit,
    String? heightUnit,
    String? themeMode,
    String? locale,
    Value<String?> activeKeyId = const Value.absent(),
    String? geminiModel,
    bool? previewBeforeSave,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppSetting(
    id: id ?? this.id,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    weightUnit: weightUnit ?? this.weightUnit,
    heightUnit: heightUnit ?? this.heightUnit,
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
    activeKeyId: activeKeyId.present ? activeKeyId.value : this.activeKeyId,
    geminiModel: geminiModel ?? this.geminiModel,
    previewBeforeSave: previewBeforeSave ?? this.previewBeforeSave,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      weightUnit: data.weightUnit.present
          ? data.weightUnit.value
          : this.weightUnit,
      heightUnit: data.heightUnit.present
          ? data.heightUnit.value
          : this.heightUnit,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      locale: data.locale.present ? data.locale.value : this.locale,
      activeKeyId: data.activeKeyId.present
          ? data.activeKeyId.value
          : this.activeKeyId,
      geminiModel: data.geminiModel.present
          ? data.geminiModel.value
          : this.geminiModel,
      previewBeforeSave: data.previewBeforeSave.present
          ? data.previewBeforeSave.value
          : this.previewBeforeSave,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('heightUnit: $heightUnit, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('activeKeyId: $activeKeyId, ')
          ..write('geminiModel: $geminiModel, ')
          ..write('previewBeforeSave: $previewBeforeSave, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    onboardingCompleted,
    weightUnit,
    heightUnit,
    themeMode,
    locale,
    activeKeyId,
    geminiModel,
    previewBeforeSave,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.weightUnit == this.weightUnit &&
          other.heightUnit == this.heightUnit &&
          other.themeMode == this.themeMode &&
          other.locale == this.locale &&
          other.activeKeyId == this.activeKeyId &&
          other.geminiModel == this.geminiModel &&
          other.previewBeforeSave == this.previewBeforeSave &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> onboardingCompleted;
  final Value<String> weightUnit;
  final Value<String> heightUnit;
  final Value<String> themeMode;
  final Value<String> locale;
  final Value<String?> activeKeyId;
  final Value<String> geminiModel;
  final Value<bool> previewBeforeSave;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.weightUnit = const Value.absent(),
    this.heightUnit = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.locale = const Value.absent(),
    this.activeKeyId = const Value.absent(),
    this.geminiModel = const Value.absent(),
    this.previewBeforeSave = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required bool onboardingCompleted,
    required String weightUnit,
    required String heightUnit,
    required String themeMode,
    required String locale,
    this.activeKeyId = const Value.absent(),
    required String geminiModel,
    required bool previewBeforeSave,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : onboardingCompleted = Value(onboardingCompleted),
       weightUnit = Value(weightUnit),
       heightUnit = Value(heightUnit),
       themeMode = Value(themeMode),
       locale = Value(locale),
       geminiModel = Value(geminiModel),
       previewBeforeSave = Value(previewBeforeSave),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? onboardingCompleted,
    Expression<String>? weightUnit,
    Expression<String>? heightUnit,
    Expression<String>? themeMode,
    Expression<String>? locale,
    Expression<String>? activeKeyId,
    Expression<String>? geminiModel,
    Expression<bool>? previewBeforeSave,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (weightUnit != null) 'weight_unit': weightUnit,
      if (heightUnit != null) 'height_unit': heightUnit,
      if (themeMode != null) 'theme_mode': themeMode,
      if (locale != null) 'locale': locale,
      if (activeKeyId != null) 'active_key_id': activeKeyId,
      if (geminiModel != null) 'gemini_model': geminiModel,
      if (previewBeforeSave != null) 'preview_before_save': previewBeforeSave,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? onboardingCompleted,
    Value<String>? weightUnit,
    Value<String>? heightUnit,
    Value<String>? themeMode,
    Value<String>? locale,
    Value<String?>? activeKeyId,
    Value<String>? geminiModel,
    Value<bool>? previewBeforeSave,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      weightUnit: weightUnit ?? this.weightUnit,
      heightUnit: heightUnit ?? this.heightUnit,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      activeKeyId: activeKeyId ?? this.activeKeyId,
      geminiModel: geminiModel ?? this.geminiModel,
      previewBeforeSave: previewBeforeSave ?? this.previewBeforeSave,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (weightUnit.present) {
      map['weight_unit'] = Variable<String>(weightUnit.value);
    }
    if (heightUnit.present) {
      map['height_unit'] = Variable<String>(heightUnit.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (activeKeyId.present) {
      map['active_key_id'] = Variable<String>(activeKeyId.value);
    }
    if (geminiModel.present) {
      map['gemini_model'] = Variable<String>(geminiModel.value);
    }
    if (previewBeforeSave.present) {
      map['preview_before_save'] = Variable<bool>(previewBeforeSave.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('heightUnit: $heightUnit, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('activeKeyId: $activeKeyId, ')
          ..write('geminiModel: $geminiModel, ')
          ..write('previewBeforeSave: $previewBeforeSave, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyTargetsTable extends DailyTargets
    with TableInfo<$DailyTargetsTable, DailyTarget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyTargetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveFromDateMeta = const VerificationMeta(
    'effectiveFromDate',
  );
  @override
  late final GeneratedColumn<String> effectiveFromDate =
      GeneratedColumn<String>(
        'effective_from_date',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _calorieTargetMeta = const VerificationMeta(
    'calorieTarget',
  );
  @override
  late final GeneratedColumn<int> calorieTarget = GeneratedColumn<int>(
    'calorie_target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinTargetGMeta = const VerificationMeta(
    'proteinTargetG',
  );
  @override
  late final GeneratedColumn<double> proteinTargetG = GeneratedColumn<double>(
    'protein_target_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbsTargetGMeta = const VerificationMeta(
    'carbsTargetG',
  );
  @override
  late final GeneratedColumn<double> carbsTargetG = GeneratedColumn<double>(
    'carbs_target_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatTargetGMeta = const VerificationMeta(
    'fatTargetG',
  );
  @override
  late final GeneratedColumn<double> fatTargetG = GeneratedColumn<double>(
    'fat_target_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formulaSnapshotJsonMeta =
      const VerificationMeta('formulaSnapshotJson');
  @override
  late final GeneratedColumn<String> formulaSnapshotJson =
      GeneratedColumn<String>(
        'formula_snapshot_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    effectiveFromDate,
    calorieTarget,
    proteinTargetG,
    carbsTargetG,
    fatTargetG,
    source,
    formulaSnapshotJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_targets';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyTarget> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('effective_from_date')) {
      context.handle(
        _effectiveFromDateMeta,
        effectiveFromDate.isAcceptableOrUnknown(
          data['effective_from_date']!,
          _effectiveFromDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveFromDateMeta);
    }
    if (data.containsKey('calorie_target')) {
      context.handle(
        _calorieTargetMeta,
        calorieTarget.isAcceptableOrUnknown(
          data['calorie_target']!,
          _calorieTargetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calorieTargetMeta);
    }
    if (data.containsKey('protein_target_g')) {
      context.handle(
        _proteinTargetGMeta,
        proteinTargetG.isAcceptableOrUnknown(
          data['protein_target_g']!,
          _proteinTargetGMeta,
        ),
      );
    }
    if (data.containsKey('carbs_target_g')) {
      context.handle(
        _carbsTargetGMeta,
        carbsTargetG.isAcceptableOrUnknown(
          data['carbs_target_g']!,
          _carbsTargetGMeta,
        ),
      );
    }
    if (data.containsKey('fat_target_g')) {
      context.handle(
        _fatTargetGMeta,
        fatTargetG.isAcceptableOrUnknown(
          data['fat_target_g']!,
          _fatTargetGMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('formula_snapshot_json')) {
      context.handle(
        _formulaSnapshotJsonMeta,
        formulaSnapshotJson.isAcceptableOrUnknown(
          data['formula_snapshot_json']!,
          _formulaSnapshotJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyTarget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyTarget(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      effectiveFromDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effective_from_date'],
      )!,
      calorieTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calorie_target'],
      )!,
      proteinTargetG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_target_g'],
      ),
      carbsTargetG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_target_g'],
      ),
      fatTargetG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_target_g'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      formulaSnapshotJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formula_snapshot_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DailyTargetsTable createAlias(String alias) {
    return $DailyTargetsTable(attachedDatabase, alias);
  }
}

class DailyTarget extends DataClass implements Insertable<DailyTarget> {
  final String id;
  final String effectiveFromDate;
  final int calorieTarget;
  final double? proteinTargetG;
  final double? carbsTargetG;
  final double? fatTargetG;
  final String source;
  final String? formulaSnapshotJson;
  final DateTime createdAt;
  const DailyTarget({
    required this.id,
    required this.effectiveFromDate,
    required this.calorieTarget,
    this.proteinTargetG,
    this.carbsTargetG,
    this.fatTargetG,
    required this.source,
    this.formulaSnapshotJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['effective_from_date'] = Variable<String>(effectiveFromDate);
    map['calorie_target'] = Variable<int>(calorieTarget);
    if (!nullToAbsent || proteinTargetG != null) {
      map['protein_target_g'] = Variable<double>(proteinTargetG);
    }
    if (!nullToAbsent || carbsTargetG != null) {
      map['carbs_target_g'] = Variable<double>(carbsTargetG);
    }
    if (!nullToAbsent || fatTargetG != null) {
      map['fat_target_g'] = Variable<double>(fatTargetG);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || formulaSnapshotJson != null) {
      map['formula_snapshot_json'] = Variable<String>(formulaSnapshotJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailyTargetsCompanion toCompanion(bool nullToAbsent) {
    return DailyTargetsCompanion(
      id: Value(id),
      effectiveFromDate: Value(effectiveFromDate),
      calorieTarget: Value(calorieTarget),
      proteinTargetG: proteinTargetG == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinTargetG),
      carbsTargetG: carbsTargetG == null && nullToAbsent
          ? const Value.absent()
          : Value(carbsTargetG),
      fatTargetG: fatTargetG == null && nullToAbsent
          ? const Value.absent()
          : Value(fatTargetG),
      source: Value(source),
      formulaSnapshotJson: formulaSnapshotJson == null && nullToAbsent
          ? const Value.absent()
          : Value(formulaSnapshotJson),
      createdAt: Value(createdAt),
    );
  }

  factory DailyTarget.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyTarget(
      id: serializer.fromJson<String>(json['id']),
      effectiveFromDate: serializer.fromJson<String>(json['effectiveFromDate']),
      calorieTarget: serializer.fromJson<int>(json['calorieTarget']),
      proteinTargetG: serializer.fromJson<double?>(json['proteinTargetG']),
      carbsTargetG: serializer.fromJson<double?>(json['carbsTargetG']),
      fatTargetG: serializer.fromJson<double?>(json['fatTargetG']),
      source: serializer.fromJson<String>(json['source']),
      formulaSnapshotJson: serializer.fromJson<String?>(
        json['formulaSnapshotJson'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'effectiveFromDate': serializer.toJson<String>(effectiveFromDate),
      'calorieTarget': serializer.toJson<int>(calorieTarget),
      'proteinTargetG': serializer.toJson<double?>(proteinTargetG),
      'carbsTargetG': serializer.toJson<double?>(carbsTargetG),
      'fatTargetG': serializer.toJson<double?>(fatTargetG),
      'source': serializer.toJson<String>(source),
      'formulaSnapshotJson': serializer.toJson<String?>(formulaSnapshotJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailyTarget copyWith({
    String? id,
    String? effectiveFromDate,
    int? calorieTarget,
    Value<double?> proteinTargetG = const Value.absent(),
    Value<double?> carbsTargetG = const Value.absent(),
    Value<double?> fatTargetG = const Value.absent(),
    String? source,
    Value<String?> formulaSnapshotJson = const Value.absent(),
    DateTime? createdAt,
  }) => DailyTarget(
    id: id ?? this.id,
    effectiveFromDate: effectiveFromDate ?? this.effectiveFromDate,
    calorieTarget: calorieTarget ?? this.calorieTarget,
    proteinTargetG: proteinTargetG.present
        ? proteinTargetG.value
        : this.proteinTargetG,
    carbsTargetG: carbsTargetG.present ? carbsTargetG.value : this.carbsTargetG,
    fatTargetG: fatTargetG.present ? fatTargetG.value : this.fatTargetG,
    source: source ?? this.source,
    formulaSnapshotJson: formulaSnapshotJson.present
        ? formulaSnapshotJson.value
        : this.formulaSnapshotJson,
    createdAt: createdAt ?? this.createdAt,
  );
  DailyTarget copyWithCompanion(DailyTargetsCompanion data) {
    return DailyTarget(
      id: data.id.present ? data.id.value : this.id,
      effectiveFromDate: data.effectiveFromDate.present
          ? data.effectiveFromDate.value
          : this.effectiveFromDate,
      calorieTarget: data.calorieTarget.present
          ? data.calorieTarget.value
          : this.calorieTarget,
      proteinTargetG: data.proteinTargetG.present
          ? data.proteinTargetG.value
          : this.proteinTargetG,
      carbsTargetG: data.carbsTargetG.present
          ? data.carbsTargetG.value
          : this.carbsTargetG,
      fatTargetG: data.fatTargetG.present
          ? data.fatTargetG.value
          : this.fatTargetG,
      source: data.source.present ? data.source.value : this.source,
      formulaSnapshotJson: data.formulaSnapshotJson.present
          ? data.formulaSnapshotJson.value
          : this.formulaSnapshotJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyTarget(')
          ..write('id: $id, ')
          ..write('effectiveFromDate: $effectiveFromDate, ')
          ..write('calorieTarget: $calorieTarget, ')
          ..write('proteinTargetG: $proteinTargetG, ')
          ..write('carbsTargetG: $carbsTargetG, ')
          ..write('fatTargetG: $fatTargetG, ')
          ..write('source: $source, ')
          ..write('formulaSnapshotJson: $formulaSnapshotJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    effectiveFromDate,
    calorieTarget,
    proteinTargetG,
    carbsTargetG,
    fatTargetG,
    source,
    formulaSnapshotJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyTarget &&
          other.id == this.id &&
          other.effectiveFromDate == this.effectiveFromDate &&
          other.calorieTarget == this.calorieTarget &&
          other.proteinTargetG == this.proteinTargetG &&
          other.carbsTargetG == this.carbsTargetG &&
          other.fatTargetG == this.fatTargetG &&
          other.source == this.source &&
          other.formulaSnapshotJson == this.formulaSnapshotJson &&
          other.createdAt == this.createdAt);
}

class DailyTargetsCompanion extends UpdateCompanion<DailyTarget> {
  final Value<String> id;
  final Value<String> effectiveFromDate;
  final Value<int> calorieTarget;
  final Value<double?> proteinTargetG;
  final Value<double?> carbsTargetG;
  final Value<double?> fatTargetG;
  final Value<String> source;
  final Value<String?> formulaSnapshotJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DailyTargetsCompanion({
    this.id = const Value.absent(),
    this.effectiveFromDate = const Value.absent(),
    this.calorieTarget = const Value.absent(),
    this.proteinTargetG = const Value.absent(),
    this.carbsTargetG = const Value.absent(),
    this.fatTargetG = const Value.absent(),
    this.source = const Value.absent(),
    this.formulaSnapshotJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyTargetsCompanion.insert({
    required String id,
    required String effectiveFromDate,
    required int calorieTarget,
    this.proteinTargetG = const Value.absent(),
    this.carbsTargetG = const Value.absent(),
    this.fatTargetG = const Value.absent(),
    required String source,
    this.formulaSnapshotJson = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       effectiveFromDate = Value(effectiveFromDate),
       calorieTarget = Value(calorieTarget),
       source = Value(source),
       createdAt = Value(createdAt);
  static Insertable<DailyTarget> custom({
    Expression<String>? id,
    Expression<String>? effectiveFromDate,
    Expression<int>? calorieTarget,
    Expression<double>? proteinTargetG,
    Expression<double>? carbsTargetG,
    Expression<double>? fatTargetG,
    Expression<String>? source,
    Expression<String>? formulaSnapshotJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (effectiveFromDate != null) 'effective_from_date': effectiveFromDate,
      if (calorieTarget != null) 'calorie_target': calorieTarget,
      if (proteinTargetG != null) 'protein_target_g': proteinTargetG,
      if (carbsTargetG != null) 'carbs_target_g': carbsTargetG,
      if (fatTargetG != null) 'fat_target_g': fatTargetG,
      if (source != null) 'source': source,
      if (formulaSnapshotJson != null)
        'formula_snapshot_json': formulaSnapshotJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyTargetsCompanion copyWith({
    Value<String>? id,
    Value<String>? effectiveFromDate,
    Value<int>? calorieTarget,
    Value<double?>? proteinTargetG,
    Value<double?>? carbsTargetG,
    Value<double?>? fatTargetG,
    Value<String>? source,
    Value<String?>? formulaSnapshotJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DailyTargetsCompanion(
      id: id ?? this.id,
      effectiveFromDate: effectiveFromDate ?? this.effectiveFromDate,
      calorieTarget: calorieTarget ?? this.calorieTarget,
      proteinTargetG: proteinTargetG ?? this.proteinTargetG,
      carbsTargetG: carbsTargetG ?? this.carbsTargetG,
      fatTargetG: fatTargetG ?? this.fatTargetG,
      source: source ?? this.source,
      formulaSnapshotJson: formulaSnapshotJson ?? this.formulaSnapshotJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (effectiveFromDate.present) {
      map['effective_from_date'] = Variable<String>(effectiveFromDate.value);
    }
    if (calorieTarget.present) {
      map['calorie_target'] = Variable<int>(calorieTarget.value);
    }
    if (proteinTargetG.present) {
      map['protein_target_g'] = Variable<double>(proteinTargetG.value);
    }
    if (carbsTargetG.present) {
      map['carbs_target_g'] = Variable<double>(carbsTargetG.value);
    }
    if (fatTargetG.present) {
      map['fat_target_g'] = Variable<double>(fatTargetG.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (formulaSnapshotJson.present) {
      map['formula_snapshot_json'] = Variable<String>(
        formulaSnapshotJson.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyTargetsCompanion(')
          ..write('id: $id, ')
          ..write('effectiveFromDate: $effectiveFromDate, ')
          ..write('calorieTarget: $calorieTarget, ')
          ..write('proteinTargetG: $proteinTargetG, ')
          ..write('carbsTargetG: $carbsTargetG, ')
          ..write('fatTargetG: $fatTargetG, ')
          ..write('source: $source, ')
          ..write('formulaSnapshotJson: $formulaSnapshotJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodLogsTable extends FoodLogs with TableInfo<$FoodLogsTable, FoodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localRequestIdMeta = const VerificationMeta(
    'localRequestId',
  );
  @override
  late final GeneratedColumn<String> localRequestId = GeneratedColumn<String>(
    'local_request_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _consumedAtUtcMeta = const VerificationMeta(
    'consumedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> consumedAtUtc =
      GeneratedColumn<DateTime>(
        'consumed_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _timezoneOffsetMinutesMeta =
      const VerificationMeta('timezoneOffsetMinutes');
  @override
  late final GeneratedColumn<int> timezoneOffsetMinutes = GeneratedColumn<int>(
    'timezone_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalUserTextMeta = const VerificationMeta(
    'originalUserText',
  );
  @override
  late final GeneratedColumn<String> originalUserText = GeneratedColumn<String>(
    'original_user_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCaloriesKcalMeta = const VerificationMeta(
    'totalCaloriesKcal',
  );
  @override
  late final GeneratedColumn<double> totalCaloriesKcal =
      GeneratedColumn<double>(
        'total_calories_kcal',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _totalProteinGMeta = const VerificationMeta(
    'totalProteinG',
  );
  @override
  late final GeneratedColumn<double> totalProteinG = GeneratedColumn<double>(
    'total_protein_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCarbsGMeta = const VerificationMeta(
    'totalCarbsG',
  );
  @override
  late final GeneratedColumn<double> totalCarbsG = GeneratedColumn<double>(
    'total_carbs_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalFatGMeta = const VerificationMeta(
    'totalFatG',
  );
  @override
  late final GeneratedColumn<double> totalFatG = GeneratedColumn<double>(
    'total_fat_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiModelMeta = const VerificationMeta(
    'aiModel',
  );
  @override
  late final GeneratedColumn<String> aiModel = GeneratedColumn<String>(
    'ai_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiKeyMetadataIdMeta = const VerificationMeta(
    'aiKeyMetadataId',
  );
  @override
  late final GeneratedColumn<String> aiKeyMetadataId = GeneratedColumn<String>(
    'ai_key_metadata_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES api_key_metadata (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localRequestId,
    localDate,
    consumedAtUtc,
    timezoneOffsetMinutes,
    mealType,
    source,
    status,
    originalUserText,
    notes,
    totalCaloriesKcal,
    totalProteinG,
    totalCarbsG,
    totalFatG,
    aiModel,
    aiKeyMetadataId,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_request_id')) {
      context.handle(
        _localRequestIdMeta,
        localRequestId.isAcceptableOrUnknown(
          data['local_request_id']!,
          _localRequestIdMeta,
        ),
      );
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('consumed_at_utc')) {
      context.handle(
        _consumedAtUtcMeta,
        consumedAtUtc.isAcceptableOrUnknown(
          data['consumed_at_utc']!,
          _consumedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_consumedAtUtcMeta);
    }
    if (data.containsKey('timezone_offset_minutes')) {
      context.handle(
        _timezoneOffsetMinutesMeta,
        timezoneOffsetMinutes.isAcceptableOrUnknown(
          data['timezone_offset_minutes']!,
          _timezoneOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timezoneOffsetMinutesMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('original_user_text')) {
      context.handle(
        _originalUserTextMeta,
        originalUserText.isAcceptableOrUnknown(
          data['original_user_text']!,
          _originalUserTextMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('total_calories_kcal')) {
      context.handle(
        _totalCaloriesKcalMeta,
        totalCaloriesKcal.isAcceptableOrUnknown(
          data['total_calories_kcal']!,
          _totalCaloriesKcalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCaloriesKcalMeta);
    }
    if (data.containsKey('total_protein_g')) {
      context.handle(
        _totalProteinGMeta,
        totalProteinG.isAcceptableOrUnknown(
          data['total_protein_g']!,
          _totalProteinGMeta,
        ),
      );
    }
    if (data.containsKey('total_carbs_g')) {
      context.handle(
        _totalCarbsGMeta,
        totalCarbsG.isAcceptableOrUnknown(
          data['total_carbs_g']!,
          _totalCarbsGMeta,
        ),
      );
    }
    if (data.containsKey('total_fat_g')) {
      context.handle(
        _totalFatGMeta,
        totalFatG.isAcceptableOrUnknown(data['total_fat_g']!, _totalFatGMeta),
      );
    }
    if (data.containsKey('ai_model')) {
      context.handle(
        _aiModelMeta,
        aiModel.isAcceptableOrUnknown(data['ai_model']!, _aiModelMeta),
      );
    }
    if (data.containsKey('ai_key_metadata_id')) {
      context.handle(
        _aiKeyMetadataIdMeta,
        aiKeyMetadataId.isAcceptableOrUnknown(
          data['ai_key_metadata_id']!,
          _aiKeyMetadataIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localRequestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_request_id'],
      ),
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      consumedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}consumed_at_utc'],
      )!,
      timezoneOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timezone_offset_minutes'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      originalUserText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_user_text'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      totalCaloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_calories_kcal'],
      )!,
      totalProteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_protein_g'],
      ),
      totalCarbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_carbs_g'],
      ),
      totalFatG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_fat_g'],
      ),
      aiModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_model'],
      ),
      aiKeyMetadataId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_key_metadata_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $FoodLogsTable createAlias(String alias) {
    return $FoodLogsTable(attachedDatabase, alias);
  }
}

class FoodLog extends DataClass implements Insertable<FoodLog> {
  final String id;
  final String? localRequestId;
  final String localDate;
  final DateTime consumedAtUtc;
  final int timezoneOffsetMinutes;
  final String mealType;
  final String source;
  final String status;
  final String? originalUserText;
  final String? notes;
  final double totalCaloriesKcal;
  final double? totalProteinG;
  final double? totalCarbsG;
  final double? totalFatG;
  final String? aiModel;
  final String? aiKeyMetadataId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const FoodLog({
    required this.id,
    this.localRequestId,
    required this.localDate,
    required this.consumedAtUtc,
    required this.timezoneOffsetMinutes,
    required this.mealType,
    required this.source,
    required this.status,
    this.originalUserText,
    this.notes,
    required this.totalCaloriesKcal,
    this.totalProteinG,
    this.totalCarbsG,
    this.totalFatG,
    this.aiModel,
    this.aiKeyMetadataId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || localRequestId != null) {
      map['local_request_id'] = Variable<String>(localRequestId);
    }
    map['local_date'] = Variable<String>(localDate);
    map['consumed_at_utc'] = Variable<DateTime>(consumedAtUtc);
    map['timezone_offset_minutes'] = Variable<int>(timezoneOffsetMinutes);
    map['meal_type'] = Variable<String>(mealType);
    map['source'] = Variable<String>(source);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || originalUserText != null) {
      map['original_user_text'] = Variable<String>(originalUserText);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['total_calories_kcal'] = Variable<double>(totalCaloriesKcal);
    if (!nullToAbsent || totalProteinG != null) {
      map['total_protein_g'] = Variable<double>(totalProteinG);
    }
    if (!nullToAbsent || totalCarbsG != null) {
      map['total_carbs_g'] = Variable<double>(totalCarbsG);
    }
    if (!nullToAbsent || totalFatG != null) {
      map['total_fat_g'] = Variable<double>(totalFatG);
    }
    if (!nullToAbsent || aiModel != null) {
      map['ai_model'] = Variable<String>(aiModel);
    }
    if (!nullToAbsent || aiKeyMetadataId != null) {
      map['ai_key_metadata_id'] = Variable<String>(aiKeyMetadataId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  FoodLogsCompanion toCompanion(bool nullToAbsent) {
    return FoodLogsCompanion(
      id: Value(id),
      localRequestId: localRequestId == null && nullToAbsent
          ? const Value.absent()
          : Value(localRequestId),
      localDate: Value(localDate),
      consumedAtUtc: Value(consumedAtUtc),
      timezoneOffsetMinutes: Value(timezoneOffsetMinutes),
      mealType: Value(mealType),
      source: Value(source),
      status: Value(status),
      originalUserText: originalUserText == null && nullToAbsent
          ? const Value.absent()
          : Value(originalUserText),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      totalCaloriesKcal: Value(totalCaloriesKcal),
      totalProteinG: totalProteinG == null && nullToAbsent
          ? const Value.absent()
          : Value(totalProteinG),
      totalCarbsG: totalCarbsG == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCarbsG),
      totalFatG: totalFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(totalFatG),
      aiModel: aiModel == null && nullToAbsent
          ? const Value.absent()
          : Value(aiModel),
      aiKeyMetadataId: aiKeyMetadataId == null && nullToAbsent
          ? const Value.absent()
          : Value(aiKeyMetadataId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory FoodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLog(
      id: serializer.fromJson<String>(json['id']),
      localRequestId: serializer.fromJson<String?>(json['localRequestId']),
      localDate: serializer.fromJson<String>(json['localDate']),
      consumedAtUtc: serializer.fromJson<DateTime>(json['consumedAtUtc']),
      timezoneOffsetMinutes: serializer.fromJson<int>(
        json['timezoneOffsetMinutes'],
      ),
      mealType: serializer.fromJson<String>(json['mealType']),
      source: serializer.fromJson<String>(json['source']),
      status: serializer.fromJson<String>(json['status']),
      originalUserText: serializer.fromJson<String?>(json['originalUserText']),
      notes: serializer.fromJson<String?>(json['notes']),
      totalCaloriesKcal: serializer.fromJson<double>(json['totalCaloriesKcal']),
      totalProteinG: serializer.fromJson<double?>(json['totalProteinG']),
      totalCarbsG: serializer.fromJson<double?>(json['totalCarbsG']),
      totalFatG: serializer.fromJson<double?>(json['totalFatG']),
      aiModel: serializer.fromJson<String?>(json['aiModel']),
      aiKeyMetadataId: serializer.fromJson<String?>(json['aiKeyMetadataId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localRequestId': serializer.toJson<String?>(localRequestId),
      'localDate': serializer.toJson<String>(localDate),
      'consumedAtUtc': serializer.toJson<DateTime>(consumedAtUtc),
      'timezoneOffsetMinutes': serializer.toJson<int>(timezoneOffsetMinutes),
      'mealType': serializer.toJson<String>(mealType),
      'source': serializer.toJson<String>(source),
      'status': serializer.toJson<String>(status),
      'originalUserText': serializer.toJson<String?>(originalUserText),
      'notes': serializer.toJson<String?>(notes),
      'totalCaloriesKcal': serializer.toJson<double>(totalCaloriesKcal),
      'totalProteinG': serializer.toJson<double?>(totalProteinG),
      'totalCarbsG': serializer.toJson<double?>(totalCarbsG),
      'totalFatG': serializer.toJson<double?>(totalFatG),
      'aiModel': serializer.toJson<String?>(aiModel),
      'aiKeyMetadataId': serializer.toJson<String?>(aiKeyMetadataId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  FoodLog copyWith({
    String? id,
    Value<String?> localRequestId = const Value.absent(),
    String? localDate,
    DateTime? consumedAtUtc,
    int? timezoneOffsetMinutes,
    String? mealType,
    String? source,
    String? status,
    Value<String?> originalUserText = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    double? totalCaloriesKcal,
    Value<double?> totalProteinG = const Value.absent(),
    Value<double?> totalCarbsG = const Value.absent(),
    Value<double?> totalFatG = const Value.absent(),
    Value<String?> aiModel = const Value.absent(),
    Value<String?> aiKeyMetadataId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => FoodLog(
    id: id ?? this.id,
    localRequestId: localRequestId.present
        ? localRequestId.value
        : this.localRequestId,
    localDate: localDate ?? this.localDate,
    consumedAtUtc: consumedAtUtc ?? this.consumedAtUtc,
    timezoneOffsetMinutes: timezoneOffsetMinutes ?? this.timezoneOffsetMinutes,
    mealType: mealType ?? this.mealType,
    source: source ?? this.source,
    status: status ?? this.status,
    originalUserText: originalUserText.present
        ? originalUserText.value
        : this.originalUserText,
    notes: notes.present ? notes.value : this.notes,
    totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
    totalProteinG: totalProteinG.present
        ? totalProteinG.value
        : this.totalProteinG,
    totalCarbsG: totalCarbsG.present ? totalCarbsG.value : this.totalCarbsG,
    totalFatG: totalFatG.present ? totalFatG.value : this.totalFatG,
    aiModel: aiModel.present ? aiModel.value : this.aiModel,
    aiKeyMetadataId: aiKeyMetadataId.present
        ? aiKeyMetadataId.value
        : this.aiKeyMetadataId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  FoodLog copyWithCompanion(FoodLogsCompanion data) {
    return FoodLog(
      id: data.id.present ? data.id.value : this.id,
      localRequestId: data.localRequestId.present
          ? data.localRequestId.value
          : this.localRequestId,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      consumedAtUtc: data.consumedAtUtc.present
          ? data.consumedAtUtc.value
          : this.consumedAtUtc,
      timezoneOffsetMinutes: data.timezoneOffsetMinutes.present
          ? data.timezoneOffsetMinutes.value
          : this.timezoneOffsetMinutes,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      source: data.source.present ? data.source.value : this.source,
      status: data.status.present ? data.status.value : this.status,
      originalUserText: data.originalUserText.present
          ? data.originalUserText.value
          : this.originalUserText,
      notes: data.notes.present ? data.notes.value : this.notes,
      totalCaloriesKcal: data.totalCaloriesKcal.present
          ? data.totalCaloriesKcal.value
          : this.totalCaloriesKcal,
      totalProteinG: data.totalProteinG.present
          ? data.totalProteinG.value
          : this.totalProteinG,
      totalCarbsG: data.totalCarbsG.present
          ? data.totalCarbsG.value
          : this.totalCarbsG,
      totalFatG: data.totalFatG.present ? data.totalFatG.value : this.totalFatG,
      aiModel: data.aiModel.present ? data.aiModel.value : this.aiModel,
      aiKeyMetadataId: data.aiKeyMetadataId.present
          ? data.aiKeyMetadataId.value
          : this.aiKeyMetadataId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLog(')
          ..write('id: $id, ')
          ..write('localRequestId: $localRequestId, ')
          ..write('localDate: $localDate, ')
          ..write('consumedAtUtc: $consumedAtUtc, ')
          ..write('timezoneOffsetMinutes: $timezoneOffsetMinutes, ')
          ..write('mealType: $mealType, ')
          ..write('source: $source, ')
          ..write('status: $status, ')
          ..write('originalUserText: $originalUserText, ')
          ..write('notes: $notes, ')
          ..write('totalCaloriesKcal: $totalCaloriesKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalCarbsG: $totalCarbsG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('aiModel: $aiModel, ')
          ..write('aiKeyMetadataId: $aiKeyMetadataId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localRequestId,
    localDate,
    consumedAtUtc,
    timezoneOffsetMinutes,
    mealType,
    source,
    status,
    originalUserText,
    notes,
    totalCaloriesKcal,
    totalProteinG,
    totalCarbsG,
    totalFatG,
    aiModel,
    aiKeyMetadataId,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLog &&
          other.id == this.id &&
          other.localRequestId == this.localRequestId &&
          other.localDate == this.localDate &&
          other.consumedAtUtc == this.consumedAtUtc &&
          other.timezoneOffsetMinutes == this.timezoneOffsetMinutes &&
          other.mealType == this.mealType &&
          other.source == this.source &&
          other.status == this.status &&
          other.originalUserText == this.originalUserText &&
          other.notes == this.notes &&
          other.totalCaloriesKcal == this.totalCaloriesKcal &&
          other.totalProteinG == this.totalProteinG &&
          other.totalCarbsG == this.totalCarbsG &&
          other.totalFatG == this.totalFatG &&
          other.aiModel == this.aiModel &&
          other.aiKeyMetadataId == this.aiKeyMetadataId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class FoodLogsCompanion extends UpdateCompanion<FoodLog> {
  final Value<String> id;
  final Value<String?> localRequestId;
  final Value<String> localDate;
  final Value<DateTime> consumedAtUtc;
  final Value<int> timezoneOffsetMinutes;
  final Value<String> mealType;
  final Value<String> source;
  final Value<String> status;
  final Value<String?> originalUserText;
  final Value<String?> notes;
  final Value<double> totalCaloriesKcal;
  final Value<double?> totalProteinG;
  final Value<double?> totalCarbsG;
  final Value<double?> totalFatG;
  final Value<String?> aiModel;
  final Value<String?> aiKeyMetadataId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const FoodLogsCompanion({
    this.id = const Value.absent(),
    this.localRequestId = const Value.absent(),
    this.localDate = const Value.absent(),
    this.consumedAtUtc = const Value.absent(),
    this.timezoneOffsetMinutes = const Value.absent(),
    this.mealType = const Value.absent(),
    this.source = const Value.absent(),
    this.status = const Value.absent(),
    this.originalUserText = const Value.absent(),
    this.notes = const Value.absent(),
    this.totalCaloriesKcal = const Value.absent(),
    this.totalProteinG = const Value.absent(),
    this.totalCarbsG = const Value.absent(),
    this.totalFatG = const Value.absent(),
    this.aiModel = const Value.absent(),
    this.aiKeyMetadataId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodLogsCompanion.insert({
    required String id,
    this.localRequestId = const Value.absent(),
    required String localDate,
    required DateTime consumedAtUtc,
    required int timezoneOffsetMinutes,
    required String mealType,
    required String source,
    required String status,
    this.originalUserText = const Value.absent(),
    this.notes = const Value.absent(),
    required double totalCaloriesKcal,
    this.totalProteinG = const Value.absent(),
    this.totalCarbsG = const Value.absent(),
    this.totalFatG = const Value.absent(),
    this.aiModel = const Value.absent(),
    this.aiKeyMetadataId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localDate = Value(localDate),
       consumedAtUtc = Value(consumedAtUtc),
       timezoneOffsetMinutes = Value(timezoneOffsetMinutes),
       mealType = Value(mealType),
       source = Value(source),
       status = Value(status),
       totalCaloriesKcal = Value(totalCaloriesKcal),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodLog> custom({
    Expression<String>? id,
    Expression<String>? localRequestId,
    Expression<String>? localDate,
    Expression<DateTime>? consumedAtUtc,
    Expression<int>? timezoneOffsetMinutes,
    Expression<String>? mealType,
    Expression<String>? source,
    Expression<String>? status,
    Expression<String>? originalUserText,
    Expression<String>? notes,
    Expression<double>? totalCaloriesKcal,
    Expression<double>? totalProteinG,
    Expression<double>? totalCarbsG,
    Expression<double>? totalFatG,
    Expression<String>? aiModel,
    Expression<String>? aiKeyMetadataId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localRequestId != null) 'local_request_id': localRequestId,
      if (localDate != null) 'local_date': localDate,
      if (consumedAtUtc != null) 'consumed_at_utc': consumedAtUtc,
      if (timezoneOffsetMinutes != null)
        'timezone_offset_minutes': timezoneOffsetMinutes,
      if (mealType != null) 'meal_type': mealType,
      if (source != null) 'source': source,
      if (status != null) 'status': status,
      if (originalUserText != null) 'original_user_text': originalUserText,
      if (notes != null) 'notes': notes,
      if (totalCaloriesKcal != null) 'total_calories_kcal': totalCaloriesKcal,
      if (totalProteinG != null) 'total_protein_g': totalProteinG,
      if (totalCarbsG != null) 'total_carbs_g': totalCarbsG,
      if (totalFatG != null) 'total_fat_g': totalFatG,
      if (aiModel != null) 'ai_model': aiModel,
      if (aiKeyMetadataId != null) 'ai_key_metadata_id': aiKeyMetadataId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodLogsCompanion copyWith({
    Value<String>? id,
    Value<String?>? localRequestId,
    Value<String>? localDate,
    Value<DateTime>? consumedAtUtc,
    Value<int>? timezoneOffsetMinutes,
    Value<String>? mealType,
    Value<String>? source,
    Value<String>? status,
    Value<String?>? originalUserText,
    Value<String?>? notes,
    Value<double>? totalCaloriesKcal,
    Value<double?>? totalProteinG,
    Value<double?>? totalCarbsG,
    Value<double?>? totalFatG,
    Value<String?>? aiModel,
    Value<String?>? aiKeyMetadataId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return FoodLogsCompanion(
      id: id ?? this.id,
      localRequestId: localRequestId ?? this.localRequestId,
      localDate: localDate ?? this.localDate,
      consumedAtUtc: consumedAtUtc ?? this.consumedAtUtc,
      timezoneOffsetMinutes:
          timezoneOffsetMinutes ?? this.timezoneOffsetMinutes,
      mealType: mealType ?? this.mealType,
      source: source ?? this.source,
      status: status ?? this.status,
      originalUserText: originalUserText ?? this.originalUserText,
      notes: notes ?? this.notes,
      totalCaloriesKcal: totalCaloriesKcal ?? this.totalCaloriesKcal,
      totalProteinG: totalProteinG ?? this.totalProteinG,
      totalCarbsG: totalCarbsG ?? this.totalCarbsG,
      totalFatG: totalFatG ?? this.totalFatG,
      aiModel: aiModel ?? this.aiModel,
      aiKeyMetadataId: aiKeyMetadataId ?? this.aiKeyMetadataId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localRequestId.present) {
      map['local_request_id'] = Variable<String>(localRequestId.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (consumedAtUtc.present) {
      map['consumed_at_utc'] = Variable<DateTime>(consumedAtUtc.value);
    }
    if (timezoneOffsetMinutes.present) {
      map['timezone_offset_minutes'] = Variable<int>(
        timezoneOffsetMinutes.value,
      );
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (originalUserText.present) {
      map['original_user_text'] = Variable<String>(originalUserText.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (totalCaloriesKcal.present) {
      map['total_calories_kcal'] = Variable<double>(totalCaloriesKcal.value);
    }
    if (totalProteinG.present) {
      map['total_protein_g'] = Variable<double>(totalProteinG.value);
    }
    if (totalCarbsG.present) {
      map['total_carbs_g'] = Variable<double>(totalCarbsG.value);
    }
    if (totalFatG.present) {
      map['total_fat_g'] = Variable<double>(totalFatG.value);
    }
    if (aiModel.present) {
      map['ai_model'] = Variable<String>(aiModel.value);
    }
    if (aiKeyMetadataId.present) {
      map['ai_key_metadata_id'] = Variable<String>(aiKeyMetadataId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogsCompanion(')
          ..write('id: $id, ')
          ..write('localRequestId: $localRequestId, ')
          ..write('localDate: $localDate, ')
          ..write('consumedAtUtc: $consumedAtUtc, ')
          ..write('timezoneOffsetMinutes: $timezoneOffsetMinutes, ')
          ..write('mealType: $mealType, ')
          ..write('source: $source, ')
          ..write('status: $status, ')
          ..write('originalUserText: $originalUserText, ')
          ..write('notes: $notes, ')
          ..write('totalCaloriesKcal: $totalCaloriesKcal, ')
          ..write('totalProteinG: $totalProteinG, ')
          ..write('totalCarbsG: $totalCarbsG, ')
          ..write('totalFatG: $totalFatG, ')
          ..write('aiModel: $aiModel, ')
          ..write('aiKeyMetadataId: $aiKeyMetadataId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodItemsTable extends FoodItems
    with TableInfo<$FoodItemsTable, FoodItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodLogIdMeta = const VerificationMeta(
    'foodLogId',
  );
  @override
  late final GeneratedColumn<String> foodLogId = GeneratedColumn<String>(
    'food_log_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food_logs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _portionTextMeta = const VerificationMeta(
    'portionText',
  );
  @override
  late final GeneratedColumn<String> portionText = GeneratedColumn<String>(
    'portion_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesKcalMeta = const VerificationMeta(
    'caloriesKcal',
  );
  @override
  late final GeneratedColumn<double> caloriesKcal = GeneratedColumn<double>(
    'calories_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
    'carbs_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
    'fat_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiberGMeta = const VerificationMeta('fiberG');
  @override
  late final GeneratedColumn<double> fiberG = GeneratedColumn<double>(
    'fiber_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sodiumMgMeta = const VerificationMeta(
    'sodiumMg',
  );
  @override
  late final GeneratedColumn<double> sodiumMg = GeneratedColumn<double>(
    'sodium_mg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assumptionNoteMeta = const VerificationMeta(
    'assumptionNote',
  );
  @override
  late final GeneratedColumn<String> assumptionNote = GeneratedColumn<String>(
    'assumption_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    foodLogId,
    displayName,
    normalizedName,
    quantity,
    unit,
    portionText,
    caloriesKcal,
    proteinG,
    carbsG,
    fatG,
    fiberG,
    sodiumMg,
    confidence,
    assumptionNote,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('food_log_id')) {
      context.handle(
        _foodLogIdMeta,
        foodLogId.isAcceptableOrUnknown(data['food_log_id']!, _foodLogIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foodLogIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('portion_text')) {
      context.handle(
        _portionTextMeta,
        portionText.isAcceptableOrUnknown(
          data['portion_text']!,
          _portionTextMeta,
        ),
      );
    }
    if (data.containsKey('calories_kcal')) {
      context.handle(
        _caloriesKcalMeta,
        caloriesKcal.isAcceptableOrUnknown(
          data['calories_kcal']!,
          _caloriesKcalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesKcalMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    }
    if (data.containsKey('fat_g')) {
      context.handle(
        _fatGMeta,
        fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta),
      );
    }
    if (data.containsKey('fiber_g')) {
      context.handle(
        _fiberGMeta,
        fiberG.isAcceptableOrUnknown(data['fiber_g']!, _fiberGMeta),
      );
    }
    if (data.containsKey('sodium_mg')) {
      context.handle(
        _sodiumMgMeta,
        sodiumMg.isAcceptableOrUnknown(data['sodium_mg']!, _sodiumMgMeta),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('assumption_note')) {
      context.handle(
        _assumptionNoteMeta,
        assumptionNote.isAcceptableOrUnknown(
          data['assumption_note']!,
          _assumptionNoteMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      foodLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_log_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      portionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portion_text'],
      ),
      caloriesKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_kcal'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g'],
      ),
      carbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_g'],
      ),
      fatG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g'],
      ),
      fiberG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber_g'],
      ),
      sodiumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sodium_mg'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
      assumptionNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assumption_note'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FoodItemsTable createAlias(String alias) {
    return $FoodItemsTable(attachedDatabase, alias);
  }
}

class FoodItem extends DataClass implements Insertable<FoodItem> {
  final String id;
  final String foodLogId;
  final String displayName;
  final String? normalizedName;
  final double? quantity;
  final String? unit;
  final String? portionText;
  final double caloriesKcal;
  final double? proteinG;
  final double? carbsG;
  final double? fatG;
  final double? fiberG;
  final double? sodiumMg;
  final double? confidence;
  final String? assumptionNote;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodItem({
    required this.id,
    required this.foodLogId,
    required this.displayName,
    this.normalizedName,
    this.quantity,
    this.unit,
    this.portionText,
    required this.caloriesKcal,
    this.proteinG,
    this.carbsG,
    this.fatG,
    this.fiberG,
    this.sodiumMg,
    this.confidence,
    this.assumptionNote,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['food_log_id'] = Variable<String>(foodLogId);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || normalizedName != null) {
      map['normalized_name'] = Variable<String>(normalizedName);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || portionText != null) {
      map['portion_text'] = Variable<String>(portionText);
    }
    map['calories_kcal'] = Variable<double>(caloriesKcal);
    if (!nullToAbsent || proteinG != null) {
      map['protein_g'] = Variable<double>(proteinG);
    }
    if (!nullToAbsent || carbsG != null) {
      map['carbs_g'] = Variable<double>(carbsG);
    }
    if (!nullToAbsent || fatG != null) {
      map['fat_g'] = Variable<double>(fatG);
    }
    if (!nullToAbsent || fiberG != null) {
      map['fiber_g'] = Variable<double>(fiberG);
    }
    if (!nullToAbsent || sodiumMg != null) {
      map['sodium_mg'] = Variable<double>(sodiumMg);
    }
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    if (!nullToAbsent || assumptionNote != null) {
      map['assumption_note'] = Variable<String>(assumptionNote);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsCompanion(
      id: Value(id),
      foodLogId: Value(foodLogId),
      displayName: Value(displayName),
      normalizedName: normalizedName == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedName),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      portionText: portionText == null && nullToAbsent
          ? const Value.absent()
          : Value(portionText),
      caloriesKcal: Value(caloriesKcal),
      proteinG: proteinG == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinG),
      carbsG: carbsG == null && nullToAbsent
          ? const Value.absent()
          : Value(carbsG),
      fatG: fatG == null && nullToAbsent ? const Value.absent() : Value(fatG),
      fiberG: fiberG == null && nullToAbsent
          ? const Value.absent()
          : Value(fiberG),
      sodiumMg: sodiumMg == null && nullToAbsent
          ? const Value.absent()
          : Value(sodiumMg),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      assumptionNote: assumptionNote == null && nullToAbsent
          ? const Value.absent()
          : Value(assumptionNote),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItem(
      id: serializer.fromJson<String>(json['id']),
      foodLogId: serializer.fromJson<String>(json['foodLogId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      normalizedName: serializer.fromJson<String?>(json['normalizedName']),
      quantity: serializer.fromJson<double?>(json['quantity']),
      unit: serializer.fromJson<String?>(json['unit']),
      portionText: serializer.fromJson<String?>(json['portionText']),
      caloriesKcal: serializer.fromJson<double>(json['caloriesKcal']),
      proteinG: serializer.fromJson<double?>(json['proteinG']),
      carbsG: serializer.fromJson<double?>(json['carbsG']),
      fatG: serializer.fromJson<double?>(json['fatG']),
      fiberG: serializer.fromJson<double?>(json['fiberG']),
      sodiumMg: serializer.fromJson<double?>(json['sodiumMg']),
      confidence: serializer.fromJson<double?>(json['confidence']),
      assumptionNote: serializer.fromJson<String?>(json['assumptionNote']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'foodLogId': serializer.toJson<String>(foodLogId),
      'displayName': serializer.toJson<String>(displayName),
      'normalizedName': serializer.toJson<String?>(normalizedName),
      'quantity': serializer.toJson<double?>(quantity),
      'unit': serializer.toJson<String?>(unit),
      'portionText': serializer.toJson<String?>(portionText),
      'caloriesKcal': serializer.toJson<double>(caloriesKcal),
      'proteinG': serializer.toJson<double?>(proteinG),
      'carbsG': serializer.toJson<double?>(carbsG),
      'fatG': serializer.toJson<double?>(fatG),
      'fiberG': serializer.toJson<double?>(fiberG),
      'sodiumMg': serializer.toJson<double?>(sodiumMg),
      'confidence': serializer.toJson<double?>(confidence),
      'assumptionNote': serializer.toJson<String?>(assumptionNote),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodItem copyWith({
    String? id,
    String? foodLogId,
    String? displayName,
    Value<String?> normalizedName = const Value.absent(),
    Value<double?> quantity = const Value.absent(),
    Value<String?> unit = const Value.absent(),
    Value<String?> portionText = const Value.absent(),
    double? caloriesKcal,
    Value<double?> proteinG = const Value.absent(),
    Value<double?> carbsG = const Value.absent(),
    Value<double?> fatG = const Value.absent(),
    Value<double?> fiberG = const Value.absent(),
    Value<double?> sodiumMg = const Value.absent(),
    Value<double?> confidence = const Value.absent(),
    Value<String?> assumptionNote = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodItem(
    id: id ?? this.id,
    foodLogId: foodLogId ?? this.foodLogId,
    displayName: displayName ?? this.displayName,
    normalizedName: normalizedName.present
        ? normalizedName.value
        : this.normalizedName,
    quantity: quantity.present ? quantity.value : this.quantity,
    unit: unit.present ? unit.value : this.unit,
    portionText: portionText.present ? portionText.value : this.portionText,
    caloriesKcal: caloriesKcal ?? this.caloriesKcal,
    proteinG: proteinG.present ? proteinG.value : this.proteinG,
    carbsG: carbsG.present ? carbsG.value : this.carbsG,
    fatG: fatG.present ? fatG.value : this.fatG,
    fiberG: fiberG.present ? fiberG.value : this.fiberG,
    sodiumMg: sodiumMg.present ? sodiumMg.value : this.sodiumMg,
    confidence: confidence.present ? confidence.value : this.confidence,
    assumptionNote: assumptionNote.present
        ? assumptionNote.value
        : this.assumptionNote,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodItem copyWithCompanion(FoodItemsCompanion data) {
    return FoodItem(
      id: data.id.present ? data.id.value : this.id,
      foodLogId: data.foodLogId.present ? data.foodLogId.value : this.foodLogId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      portionText: data.portionText.present
          ? data.portionText.value
          : this.portionText,
      caloriesKcal: data.caloriesKcal.present
          ? data.caloriesKcal.value
          : this.caloriesKcal,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      fiberG: data.fiberG.present ? data.fiberG.value : this.fiberG,
      sodiumMg: data.sodiumMg.present ? data.sodiumMg.value : this.sodiumMg,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      assumptionNote: data.assumptionNote.present
          ? data.assumptionNote.value
          : this.assumptionNote,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItem(')
          ..write('id: $id, ')
          ..write('foodLogId: $foodLogId, ')
          ..write('displayName: $displayName, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('portionText: $portionText, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('fiberG: $fiberG, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('confidence: $confidence, ')
          ..write('assumptionNote: $assumptionNote, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    foodLogId,
    displayName,
    normalizedName,
    quantity,
    unit,
    portionText,
    caloriesKcal,
    proteinG,
    carbsG,
    fatG,
    fiberG,
    sodiumMg,
    confidence,
    assumptionNote,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          other.id == this.id &&
          other.foodLogId == this.foodLogId &&
          other.displayName == this.displayName &&
          other.normalizedName == this.normalizedName &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.portionText == this.portionText &&
          other.caloriesKcal == this.caloriesKcal &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.fiberG == this.fiberG &&
          other.sodiumMg == this.sodiumMg &&
          other.confidence == this.confidence &&
          other.assumptionNote == this.assumptionNote &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodItemsCompanion extends UpdateCompanion<FoodItem> {
  final Value<String> id;
  final Value<String> foodLogId;
  final Value<String> displayName;
  final Value<String?> normalizedName;
  final Value<double?> quantity;
  final Value<String?> unit;
  final Value<String?> portionText;
  final Value<double> caloriesKcal;
  final Value<double?> proteinG;
  final Value<double?> carbsG;
  final Value<double?> fatG;
  final Value<double?> fiberG;
  final Value<double?> sodiumMg;
  final Value<double?> confidence;
  final Value<String?> assumptionNote;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FoodItemsCompanion({
    this.id = const Value.absent(),
    this.foodLogId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.portionText = const Value.absent(),
    this.caloriesKcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.fiberG = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.confidence = const Value.absent(),
    this.assumptionNote = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodItemsCompanion.insert({
    required String id,
    required String foodLogId,
    required String displayName,
    this.normalizedName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.portionText = const Value.absent(),
    required double caloriesKcal,
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.fiberG = const Value.absent(),
    this.sodiumMg = const Value.absent(),
    this.confidence = const Value.absent(),
    this.assumptionNote = const Value.absent(),
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       foodLogId = Value(foodLogId),
       displayName = Value(displayName),
       caloriesKcal = Value(caloriesKcal),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodItem> custom({
    Expression<String>? id,
    Expression<String>? foodLogId,
    Expression<String>? displayName,
    Expression<String>? normalizedName,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<String>? portionText,
    Expression<double>? caloriesKcal,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatG,
    Expression<double>? fiberG,
    Expression<double>? sodiumMg,
    Expression<double>? confidence,
    Expression<String>? assumptionNote,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (foodLogId != null) 'food_log_id': foodLogId,
      if (displayName != null) 'display_name': displayName,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (portionText != null) 'portion_text': portionText,
      if (caloriesKcal != null) 'calories_kcal': caloriesKcal,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (fiberG != null) 'fiber_g': fiberG,
      if (sodiumMg != null) 'sodium_mg': sodiumMg,
      if (confidence != null) 'confidence': confidence,
      if (assumptionNote != null) 'assumption_note': assumptionNote,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? foodLogId,
    Value<String>? displayName,
    Value<String?>? normalizedName,
    Value<double?>? quantity,
    Value<String?>? unit,
    Value<String?>? portionText,
    Value<double>? caloriesKcal,
    Value<double?>? proteinG,
    Value<double?>? carbsG,
    Value<double?>? fatG,
    Value<double?>? fiberG,
    Value<double?>? sodiumMg,
    Value<double?>? confidence,
    Value<String?>? assumptionNote,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FoodItemsCompanion(
      id: id ?? this.id,
      foodLogId: foodLogId ?? this.foodLogId,
      displayName: displayName ?? this.displayName,
      normalizedName: normalizedName ?? this.normalizedName,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      portionText: portionText ?? this.portionText,
      caloriesKcal: caloriesKcal ?? this.caloriesKcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      fiberG: fiberG ?? this.fiberG,
      sodiumMg: sodiumMg ?? this.sodiumMg,
      confidence: confidence ?? this.confidence,
      assumptionNote: assumptionNote ?? this.assumptionNote,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (foodLogId.present) {
      map['food_log_id'] = Variable<String>(foodLogId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (portionText.present) {
      map['portion_text'] = Variable<String>(portionText.value);
    }
    if (caloriesKcal.present) {
      map['calories_kcal'] = Variable<double>(caloriesKcal.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (fiberG.present) {
      map['fiber_g'] = Variable<double>(fiberG.value);
    }
    if (sodiumMg.present) {
      map['sodium_mg'] = Variable<double>(sodiumMg.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (assumptionNote.present) {
      map['assumption_note'] = Variable<String>(assumptionNote.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsCompanion(')
          ..write('id: $id, ')
          ..write('foodLogId: $foodLogId, ')
          ..write('displayName: $displayName, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('portionText: $portionText, ')
          ..write('caloriesKcal: $caloriesKcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('fiberG: $fiberG, ')
          ..write('sodiumMg: $sodiumMg, ')
          ..write('confidence: $confidence, ')
          ..write('assumptionNote: $assumptionNote, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatSessionsTable extends ChatSessions
    with TableInfo<$ChatSessionsTable, ChatSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localDate,
    title,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ChatSessionsTable createAlias(String alias) {
    return $ChatSessionsTable(attachedDatabase, alias);
  }
}

class ChatSession extends DataClass implements Insertable<ChatSession> {
  final String id;
  final String localDate;
  final String? title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChatSession({
    required this.id,
    required this.localDate,
    this.title,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_date'] = Variable<String>(localDate);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChatSessionsCompanion toCompanion(bool nullToAbsent) {
    return ChatSessionsCompanion(
      id: Value(id),
      localDate: Value(localDate),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChatSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatSession(
      id: serializer.fromJson<String>(json['id']),
      localDate: serializer.fromJson<String>(json['localDate']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localDate': serializer.toJson<String>(localDate),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChatSession copyWith({
    String? id,
    String? localDate,
    Value<String?> title = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ChatSession(
    id: id ?? this.id,
    localDate: localDate ?? this.localDate,
    title: title.present ? title.value : this.title,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ChatSession copyWithCompanion(ChatSessionsCompanion data) {
    return ChatSession(
      id: data.id.present ? data.id.value : this.id,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatSession(')
          ..write('id: $id, ')
          ..write('localDate: $localDate, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, localDate, title, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatSession &&
          other.id == this.id &&
          other.localDate == this.localDate &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChatSessionsCompanion extends UpdateCompanion<ChatSession> {
  final Value<String> id;
  final Value<String> localDate;
  final Value<String?> title;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChatSessionsCompanion({
    this.id = const Value.absent(),
    this.localDate = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatSessionsCompanion.insert({
    required String id,
    required String localDate,
    this.title = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localDate = Value(localDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ChatSession> custom({
    Expression<String>? id,
    Expression<String>? localDate,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localDate != null) 'local_date': localDate,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? localDate,
    Value<String?>? title,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ChatSessionsCompanion(
      id: id ?? this.id,
      localDate: localDate ?? this.localDate,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatSessionsCompanion(')
          ..write('id: $id, ')
          ..write('localDate: $localDate, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chat_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTextMeta = const VerificationMeta(
    'contentText',
  );
  @override
  late final GeneratedColumn<String> contentText = GeneratedColumn<String>(
    'content_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodLogIdMeta = const VerificationMeta(
    'foodLogId',
  );
  @override
  late final GeneratedColumn<String> foodLogId = GeneratedColumn<String>(
    'food_log_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES food_logs (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _localRequestIdMeta = const VerificationMeta(
    'localRequestId',
  );
  @override
  late final GeneratedColumn<String> localRequestId = GeneratedColumn<String>(
    'local_request_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorCategoryMeta = const VerificationMeta(
    'errorCategory',
  );
  @override
  late final GeneratedColumn<String> errorCategory = GeneratedColumn<String>(
    'error_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    role,
    contentText,
    status,
    foodLogId,
    localRequestId,
    errorCategory,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content_text')) {
      context.handle(
        _contentTextMeta,
        contentText.isAcceptableOrUnknown(
          data['content_text']!,
          _contentTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTextMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('food_log_id')) {
      context.handle(
        _foodLogIdMeta,
        foodLogId.isAcceptableOrUnknown(data['food_log_id']!, _foodLogIdMeta),
      );
    }
    if (data.containsKey('local_request_id')) {
      context.handle(
        _localRequestIdMeta,
        localRequestId.isAcceptableOrUnknown(
          data['local_request_id']!,
          _localRequestIdMeta,
        ),
      );
    }
    if (data.containsKey('error_category')) {
      context.handle(
        _errorCategoryMeta,
        errorCategory.isAcceptableOrUnknown(
          data['error_category']!,
          _errorCategoryMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      contentText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_text'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      foodLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_log_id'],
      ),
      localRequestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_request_id'],
      ),
      errorCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_category'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final String id;
  final String sessionId;
  final String role;
  final String contentText;
  final String status;
  final String? foodLogId;
  final String? localRequestId;
  final String? errorCategory;
  final DateTime createdAt;
  const ChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.contentText,
    required this.status,
    this.foodLogId,
    this.localRequestId,
    this.errorCategory,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['role'] = Variable<String>(role);
    map['content_text'] = Variable<String>(contentText);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || foodLogId != null) {
      map['food_log_id'] = Variable<String>(foodLogId);
    }
    if (!nullToAbsent || localRequestId != null) {
      map['local_request_id'] = Variable<String>(localRequestId);
    }
    if (!nullToAbsent || errorCategory != null) {
      map['error_category'] = Variable<String>(errorCategory);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      role: Value(role),
      contentText: Value(contentText),
      status: Value(status),
      foodLogId: foodLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(foodLogId),
      localRequestId: localRequestId == null && nullToAbsent
          ? const Value.absent()
          : Value(localRequestId),
      errorCategory: errorCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCategory),
      createdAt: Value(createdAt),
    );
  }

  factory ChatMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessage(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      role: serializer.fromJson<String>(json['role']),
      contentText: serializer.fromJson<String>(json['contentText']),
      status: serializer.fromJson<String>(json['status']),
      foodLogId: serializer.fromJson<String?>(json['foodLogId']),
      localRequestId: serializer.fromJson<String?>(json['localRequestId']),
      errorCategory: serializer.fromJson<String?>(json['errorCategory']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'role': serializer.toJson<String>(role),
      'contentText': serializer.toJson<String>(contentText),
      'status': serializer.toJson<String>(status),
      'foodLogId': serializer.toJson<String?>(foodLogId),
      'localRequestId': serializer.toJson<String?>(localRequestId),
      'errorCategory': serializer.toJson<String?>(errorCategory),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChatMessage copyWith({
    String? id,
    String? sessionId,
    String? role,
    String? contentText,
    String? status,
    Value<String?> foodLogId = const Value.absent(),
    Value<String?> localRequestId = const Value.absent(),
    Value<String?> errorCategory = const Value.absent(),
    DateTime? createdAt,
  }) => ChatMessage(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    role: role ?? this.role,
    contentText: contentText ?? this.contentText,
    status: status ?? this.status,
    foodLogId: foodLogId.present ? foodLogId.value : this.foodLogId,
    localRequestId: localRequestId.present
        ? localRequestId.value
        : this.localRequestId,
    errorCategory: errorCategory.present
        ? errorCategory.value
        : this.errorCategory,
    createdAt: createdAt ?? this.createdAt,
  );
  ChatMessage copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessage(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      role: data.role.present ? data.role.value : this.role,
      contentText: data.contentText.present
          ? data.contentText.value
          : this.contentText,
      status: data.status.present ? data.status.value : this.status,
      foodLogId: data.foodLogId.present ? data.foodLogId.value : this.foodLogId,
      localRequestId: data.localRequestId.present
          ? data.localRequestId.value
          : this.localRequestId,
      errorCategory: data.errorCategory.present
          ? data.errorCategory.value
          : this.errorCategory,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('contentText: $contentText, ')
          ..write('status: $status, ')
          ..write('foodLogId: $foodLogId, ')
          ..write('localRequestId: $localRequestId, ')
          ..write('errorCategory: $errorCategory, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    role,
    contentText,
    status,
    foodLogId,
    localRequestId,
    errorCategory,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.role == this.role &&
          other.contentText == this.contentText &&
          other.status == this.status &&
          other.foodLogId == this.foodLogId &&
          other.localRequestId == this.localRequestId &&
          other.errorCategory == this.errorCategory &&
          other.createdAt == this.createdAt);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> role;
  final Value<String> contentText;
  final Value<String> status;
  final Value<String?> foodLogId;
  final Value<String?> localRequestId;
  final Value<String?> errorCategory;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.role = const Value.absent(),
    this.contentText = const Value.absent(),
    this.status = const Value.absent(),
    this.foodLogId = const Value.absent(),
    this.localRequestId = const Value.absent(),
    this.errorCategory = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    required String id,
    required String sessionId,
    required String role,
    required String contentText,
    required String status,
    this.foodLogId = const Value.absent(),
    this.localRequestId = const Value.absent(),
    this.errorCategory = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       role = Value(role),
       contentText = Value(contentText),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<ChatMessage> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? role,
    Expression<String>? contentText,
    Expression<String>? status,
    Expression<String>? foodLogId,
    Expression<String>? localRequestId,
    Expression<String>? errorCategory,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (role != null) 'role': role,
      if (contentText != null) 'content_text': contentText,
      if (status != null) 'status': status,
      if (foodLogId != null) 'food_log_id': foodLogId,
      if (localRequestId != null) 'local_request_id': localRequestId,
      if (errorCategory != null) 'error_category': errorCategory,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatMessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? role,
    Value<String>? contentText,
    Value<String>? status,
    Value<String?>? foodLogId,
    Value<String?>? localRequestId,
    Value<String?>? errorCategory,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      role: role ?? this.role,
      contentText: contentText ?? this.contentText,
      status: status ?? this.status,
      foodLogId: foodLogId ?? this.foodLogId,
      localRequestId: localRequestId ?? this.localRequestId,
      errorCategory: errorCategory ?? this.errorCategory,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (contentText.present) {
      map['content_text'] = Variable<String>(contentText.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (foodLogId.present) {
      map['food_log_id'] = Variable<String>(foodLogId.value);
    }
    if (localRequestId.present) {
      map['local_request_id'] = Variable<String>(localRequestId.value);
    }
    if (errorCategory.present) {
      map['error_category'] = Variable<String>(errorCategory.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('contentText: $contentText, ')
          ..write('status: $status, ')
          ..write('foodLogId: $foodLogId, ')
          ..write('localRequestId: $localRequestId, ')
          ..write('errorCategory: $errorCategory, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ApiKeyUsageEventsTable extends ApiKeyUsageEvents
    with TableInfo<$ApiKeyUsageEventsTable, ApiKeyUsageEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiKeyUsageEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apiKeyMetadataIdMeta = const VerificationMeta(
    'apiKeyMetadataId',
  );
  @override
  late final GeneratedColumn<String> apiKeyMetadataId = GeneratedColumn<String>(
    'api_key_metadata_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES api_key_metadata (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _localRequestIdMeta = const VerificationMeta(
    'localRequestId',
  );
  @override
  late final GeneratedColumn<String> localRequestId = GeneratedColumn<String>(
    'local_request_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorCategoryMeta = const VerificationMeta(
    'errorCategory',
  );
  @override
  late final GeneratedColumn<String> errorCategory = GeneratedColumn<String>(
    'error_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _httpStatusMeta = const VerificationMeta(
    'httpStatus',
  );
  @override
  late final GeneratedColumn<int> httpStatus = GeneratedColumn<int>(
    'http_status',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latencyMsMeta = const VerificationMeta(
    'latencyMs',
  );
  @override
  late final GeneratedColumn<int> latencyMs = GeneratedColumn<int>(
    'latency_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promptTokensMeta = const VerificationMeta(
    'promptTokens',
  );
  @override
  late final GeneratedColumn<int> promptTokens = GeneratedColumn<int>(
    'prompt_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outputTokensMeta = const VerificationMeta(
    'outputTokens',
  );
  @override
  late final GeneratedColumn<int> outputTokens = GeneratedColumn<int>(
    'output_tokens',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelIdMeta = const VerificationMeta(
    'modelId',
  );
  @override
  late final GeneratedColumn<String> modelId = GeneratedColumn<String>(
    'model_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    apiKeyMetadataId,
    localRequestId,
    operation,
    outcome,
    errorCategory,
    httpStatus,
    latencyMs,
    promptTokens,
    outputTokens,
    modelId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'api_key_usage_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApiKeyUsageEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('api_key_metadata_id')) {
      context.handle(
        _apiKeyMetadataIdMeta,
        apiKeyMetadataId.isAcceptableOrUnknown(
          data['api_key_metadata_id']!,
          _apiKeyMetadataIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_apiKeyMetadataIdMeta);
    }
    if (data.containsKey('local_request_id')) {
      context.handle(
        _localRequestIdMeta,
        localRequestId.isAcceptableOrUnknown(
          data['local_request_id']!,
          _localRequestIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localRequestIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    if (data.containsKey('error_category')) {
      context.handle(
        _errorCategoryMeta,
        errorCategory.isAcceptableOrUnknown(
          data['error_category']!,
          _errorCategoryMeta,
        ),
      );
    }
    if (data.containsKey('http_status')) {
      context.handle(
        _httpStatusMeta,
        httpStatus.isAcceptableOrUnknown(data['http_status']!, _httpStatusMeta),
      );
    }
    if (data.containsKey('latency_ms')) {
      context.handle(
        _latencyMsMeta,
        latencyMs.isAcceptableOrUnknown(data['latency_ms']!, _latencyMsMeta),
      );
    }
    if (data.containsKey('prompt_tokens')) {
      context.handle(
        _promptTokensMeta,
        promptTokens.isAcceptableOrUnknown(
          data['prompt_tokens']!,
          _promptTokensMeta,
        ),
      );
    }
    if (data.containsKey('output_tokens')) {
      context.handle(
        _outputTokensMeta,
        outputTokens.isAcceptableOrUnknown(
          data['output_tokens']!,
          _outputTokensMeta,
        ),
      );
    }
    if (data.containsKey('model_id')) {
      context.handle(
        _modelIdMeta,
        modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApiKeyUsageEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApiKeyUsageEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      apiKeyMetadataId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key_metadata_id'],
      )!,
      localRequestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_request_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
      errorCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_category'],
      ),
      httpStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}http_status'],
      ),
      latencyMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}latency_ms'],
      ),
      promptTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prompt_tokens'],
      ),
      outputTokens: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}output_tokens'],
      ),
      modelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ApiKeyUsageEventsTable createAlias(String alias) {
    return $ApiKeyUsageEventsTable(attachedDatabase, alias);
  }
}

class ApiKeyUsageEvent extends DataClass
    implements Insertable<ApiKeyUsageEvent> {
  final String id;
  final String apiKeyMetadataId;
  final String localRequestId;
  final String operation;
  final String outcome;
  final String? errorCategory;
  final int? httpStatus;
  final int? latencyMs;
  final int? promptTokens;
  final int? outputTokens;
  final String? modelId;
  final DateTime createdAt;
  const ApiKeyUsageEvent({
    required this.id,
    required this.apiKeyMetadataId,
    required this.localRequestId,
    required this.operation,
    required this.outcome,
    this.errorCategory,
    this.httpStatus,
    this.latencyMs,
    this.promptTokens,
    this.outputTokens,
    this.modelId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['api_key_metadata_id'] = Variable<String>(apiKeyMetadataId);
    map['local_request_id'] = Variable<String>(localRequestId);
    map['operation'] = Variable<String>(operation);
    map['outcome'] = Variable<String>(outcome);
    if (!nullToAbsent || errorCategory != null) {
      map['error_category'] = Variable<String>(errorCategory);
    }
    if (!nullToAbsent || httpStatus != null) {
      map['http_status'] = Variable<int>(httpStatus);
    }
    if (!nullToAbsent || latencyMs != null) {
      map['latency_ms'] = Variable<int>(latencyMs);
    }
    if (!nullToAbsent || promptTokens != null) {
      map['prompt_tokens'] = Variable<int>(promptTokens);
    }
    if (!nullToAbsent || outputTokens != null) {
      map['output_tokens'] = Variable<int>(outputTokens);
    }
    if (!nullToAbsent || modelId != null) {
      map['model_id'] = Variable<String>(modelId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ApiKeyUsageEventsCompanion toCompanion(bool nullToAbsent) {
    return ApiKeyUsageEventsCompanion(
      id: Value(id),
      apiKeyMetadataId: Value(apiKeyMetadataId),
      localRequestId: Value(localRequestId),
      operation: Value(operation),
      outcome: Value(outcome),
      errorCategory: errorCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCategory),
      httpStatus: httpStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(httpStatus),
      latencyMs: latencyMs == null && nullToAbsent
          ? const Value.absent()
          : Value(latencyMs),
      promptTokens: promptTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(promptTokens),
      outputTokens: outputTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(outputTokens),
      modelId: modelId == null && nullToAbsent
          ? const Value.absent()
          : Value(modelId),
      createdAt: Value(createdAt),
    );
  }

  factory ApiKeyUsageEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApiKeyUsageEvent(
      id: serializer.fromJson<String>(json['id']),
      apiKeyMetadataId: serializer.fromJson<String>(json['apiKeyMetadataId']),
      localRequestId: serializer.fromJson<String>(json['localRequestId']),
      operation: serializer.fromJson<String>(json['operation']),
      outcome: serializer.fromJson<String>(json['outcome']),
      errorCategory: serializer.fromJson<String?>(json['errorCategory']),
      httpStatus: serializer.fromJson<int?>(json['httpStatus']),
      latencyMs: serializer.fromJson<int?>(json['latencyMs']),
      promptTokens: serializer.fromJson<int?>(json['promptTokens']),
      outputTokens: serializer.fromJson<int?>(json['outputTokens']),
      modelId: serializer.fromJson<String?>(json['modelId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'apiKeyMetadataId': serializer.toJson<String>(apiKeyMetadataId),
      'localRequestId': serializer.toJson<String>(localRequestId),
      'operation': serializer.toJson<String>(operation),
      'outcome': serializer.toJson<String>(outcome),
      'errorCategory': serializer.toJson<String?>(errorCategory),
      'httpStatus': serializer.toJson<int?>(httpStatus),
      'latencyMs': serializer.toJson<int?>(latencyMs),
      'promptTokens': serializer.toJson<int?>(promptTokens),
      'outputTokens': serializer.toJson<int?>(outputTokens),
      'modelId': serializer.toJson<String?>(modelId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ApiKeyUsageEvent copyWith({
    String? id,
    String? apiKeyMetadataId,
    String? localRequestId,
    String? operation,
    String? outcome,
    Value<String?> errorCategory = const Value.absent(),
    Value<int?> httpStatus = const Value.absent(),
    Value<int?> latencyMs = const Value.absent(),
    Value<int?> promptTokens = const Value.absent(),
    Value<int?> outputTokens = const Value.absent(),
    Value<String?> modelId = const Value.absent(),
    DateTime? createdAt,
  }) => ApiKeyUsageEvent(
    id: id ?? this.id,
    apiKeyMetadataId: apiKeyMetadataId ?? this.apiKeyMetadataId,
    localRequestId: localRequestId ?? this.localRequestId,
    operation: operation ?? this.operation,
    outcome: outcome ?? this.outcome,
    errorCategory: errorCategory.present
        ? errorCategory.value
        : this.errorCategory,
    httpStatus: httpStatus.present ? httpStatus.value : this.httpStatus,
    latencyMs: latencyMs.present ? latencyMs.value : this.latencyMs,
    promptTokens: promptTokens.present ? promptTokens.value : this.promptTokens,
    outputTokens: outputTokens.present ? outputTokens.value : this.outputTokens,
    modelId: modelId.present ? modelId.value : this.modelId,
    createdAt: createdAt ?? this.createdAt,
  );
  ApiKeyUsageEvent copyWithCompanion(ApiKeyUsageEventsCompanion data) {
    return ApiKeyUsageEvent(
      id: data.id.present ? data.id.value : this.id,
      apiKeyMetadataId: data.apiKeyMetadataId.present
          ? data.apiKeyMetadataId.value
          : this.apiKeyMetadataId,
      localRequestId: data.localRequestId.present
          ? data.localRequestId.value
          : this.localRequestId,
      operation: data.operation.present ? data.operation.value : this.operation,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      errorCategory: data.errorCategory.present
          ? data.errorCategory.value
          : this.errorCategory,
      httpStatus: data.httpStatus.present
          ? data.httpStatus.value
          : this.httpStatus,
      latencyMs: data.latencyMs.present ? data.latencyMs.value : this.latencyMs,
      promptTokens: data.promptTokens.present
          ? data.promptTokens.value
          : this.promptTokens,
      outputTokens: data.outputTokens.present
          ? data.outputTokens.value
          : this.outputTokens,
      modelId: data.modelId.present ? data.modelId.value : this.modelId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApiKeyUsageEvent(')
          ..write('id: $id, ')
          ..write('apiKeyMetadataId: $apiKeyMetadataId, ')
          ..write('localRequestId: $localRequestId, ')
          ..write('operation: $operation, ')
          ..write('outcome: $outcome, ')
          ..write('errorCategory: $errorCategory, ')
          ..write('httpStatus: $httpStatus, ')
          ..write('latencyMs: $latencyMs, ')
          ..write('promptTokens: $promptTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('modelId: $modelId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    apiKeyMetadataId,
    localRequestId,
    operation,
    outcome,
    errorCategory,
    httpStatus,
    latencyMs,
    promptTokens,
    outputTokens,
    modelId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiKeyUsageEvent &&
          other.id == this.id &&
          other.apiKeyMetadataId == this.apiKeyMetadataId &&
          other.localRequestId == this.localRequestId &&
          other.operation == this.operation &&
          other.outcome == this.outcome &&
          other.errorCategory == this.errorCategory &&
          other.httpStatus == this.httpStatus &&
          other.latencyMs == this.latencyMs &&
          other.promptTokens == this.promptTokens &&
          other.outputTokens == this.outputTokens &&
          other.modelId == this.modelId &&
          other.createdAt == this.createdAt);
}

class ApiKeyUsageEventsCompanion extends UpdateCompanion<ApiKeyUsageEvent> {
  final Value<String> id;
  final Value<String> apiKeyMetadataId;
  final Value<String> localRequestId;
  final Value<String> operation;
  final Value<String> outcome;
  final Value<String?> errorCategory;
  final Value<int?> httpStatus;
  final Value<int?> latencyMs;
  final Value<int?> promptTokens;
  final Value<int?> outputTokens;
  final Value<String?> modelId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ApiKeyUsageEventsCompanion({
    this.id = const Value.absent(),
    this.apiKeyMetadataId = const Value.absent(),
    this.localRequestId = const Value.absent(),
    this.operation = const Value.absent(),
    this.outcome = const Value.absent(),
    this.errorCategory = const Value.absent(),
    this.httpStatus = const Value.absent(),
    this.latencyMs = const Value.absent(),
    this.promptTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.modelId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApiKeyUsageEventsCompanion.insert({
    required String id,
    required String apiKeyMetadataId,
    required String localRequestId,
    required String operation,
    required String outcome,
    this.errorCategory = const Value.absent(),
    this.httpStatus = const Value.absent(),
    this.latencyMs = const Value.absent(),
    this.promptTokens = const Value.absent(),
    this.outputTokens = const Value.absent(),
    this.modelId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       apiKeyMetadataId = Value(apiKeyMetadataId),
       localRequestId = Value(localRequestId),
       operation = Value(operation),
       outcome = Value(outcome),
       createdAt = Value(createdAt);
  static Insertable<ApiKeyUsageEvent> custom({
    Expression<String>? id,
    Expression<String>? apiKeyMetadataId,
    Expression<String>? localRequestId,
    Expression<String>? operation,
    Expression<String>? outcome,
    Expression<String>? errorCategory,
    Expression<int>? httpStatus,
    Expression<int>? latencyMs,
    Expression<int>? promptTokens,
    Expression<int>? outputTokens,
    Expression<String>? modelId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (apiKeyMetadataId != null) 'api_key_metadata_id': apiKeyMetadataId,
      if (localRequestId != null) 'local_request_id': localRequestId,
      if (operation != null) 'operation': operation,
      if (outcome != null) 'outcome': outcome,
      if (errorCategory != null) 'error_category': errorCategory,
      if (httpStatus != null) 'http_status': httpStatus,
      if (latencyMs != null) 'latency_ms': latencyMs,
      if (promptTokens != null) 'prompt_tokens': promptTokens,
      if (outputTokens != null) 'output_tokens': outputTokens,
      if (modelId != null) 'model_id': modelId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApiKeyUsageEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? apiKeyMetadataId,
    Value<String>? localRequestId,
    Value<String>? operation,
    Value<String>? outcome,
    Value<String?>? errorCategory,
    Value<int?>? httpStatus,
    Value<int?>? latencyMs,
    Value<int?>? promptTokens,
    Value<int?>? outputTokens,
    Value<String?>? modelId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ApiKeyUsageEventsCompanion(
      id: id ?? this.id,
      apiKeyMetadataId: apiKeyMetadataId ?? this.apiKeyMetadataId,
      localRequestId: localRequestId ?? this.localRequestId,
      operation: operation ?? this.operation,
      outcome: outcome ?? this.outcome,
      errorCategory: errorCategory ?? this.errorCategory,
      httpStatus: httpStatus ?? this.httpStatus,
      latencyMs: latencyMs ?? this.latencyMs,
      promptTokens: promptTokens ?? this.promptTokens,
      outputTokens: outputTokens ?? this.outputTokens,
      modelId: modelId ?? this.modelId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (apiKeyMetadataId.present) {
      map['api_key_metadata_id'] = Variable<String>(apiKeyMetadataId.value);
    }
    if (localRequestId.present) {
      map['local_request_id'] = Variable<String>(localRequestId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (errorCategory.present) {
      map['error_category'] = Variable<String>(errorCategory.value);
    }
    if (httpStatus.present) {
      map['http_status'] = Variable<int>(httpStatus.value);
    }
    if (latencyMs.present) {
      map['latency_ms'] = Variable<int>(latencyMs.value);
    }
    if (promptTokens.present) {
      map['prompt_tokens'] = Variable<int>(promptTokens.value);
    }
    if (outputTokens.present) {
      map['output_tokens'] = Variable<int>(outputTokens.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<String>(modelId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiKeyUsageEventsCompanion(')
          ..write('id: $id, ')
          ..write('apiKeyMetadataId: $apiKeyMetadataId, ')
          ..write('localRequestId: $localRequestId, ')
          ..write('operation: $operation, ')
          ..write('outcome: $outcome, ')
          ..write('errorCategory: $errorCategory, ')
          ..write('httpStatus: $httpStatus, ')
          ..write('latencyMs: $latencyMs, ')
          ..write('promptTokens: $promptTokens, ')
          ..write('outputTokens: $outputTokens, ')
          ..write('modelId: $modelId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoriteTemplatesTable extends FavoriteTemplates
    with TableInfo<$FavoriteTemplatesTable, FavoriteTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateJsonMeta = const VerificationMeta(
    'templateJson',
  );
  @override
  late final GeneratedColumn<String> templateJson = GeneratedColumn<String>(
    'template_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _useCountMeta = const VerificationMeta(
    'useCount',
  );
  @override
  late final GeneratedColumn<int> useCount = GeneratedColumn<int>(
    'use_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    templateJson,
    useCount,
    lastUsedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('template_json')) {
      context.handle(
        _templateJsonMeta,
        templateJson.isAcceptableOrUnknown(
          data['template_json']!,
          _templateJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateJsonMeta);
    }
    if (data.containsKey('use_count')) {
      context.handle(
        _useCountMeta,
        useCount.isAcceptableOrUnknown(data['use_count']!, _useCountMeta),
      );
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      templateJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_json'],
      )!,
      useCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}use_count'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FavoriteTemplatesTable createAlias(String alias) {
    return $FavoriteTemplatesTable(attachedDatabase, alias);
  }
}

class FavoriteTemplate extends DataClass
    implements Insertable<FavoriteTemplate> {
  final String id;
  final String name;
  final String templateJson;
  final int useCount;
  final DateTime? lastUsedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FavoriteTemplate({
    required this.id,
    required this.name,
    required this.templateJson,
    required this.useCount,
    this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['template_json'] = Variable<String>(templateJson);
    map['use_count'] = Variable<int>(useCount);
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FavoriteTemplatesCompanion toCompanion(bool nullToAbsent) {
    return FavoriteTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      templateJson: Value(templateJson),
      useCount: Value(useCount),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FavoriteTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteTemplate(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      templateJson: serializer.fromJson<String>(json['templateJson']),
      useCount: serializer.fromJson<int>(json['useCount']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'templateJson': serializer.toJson<String>(templateJson),
      'useCount': serializer.toJson<int>(useCount),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FavoriteTemplate copyWith({
    String? id,
    String? name,
    String? templateJson,
    int? useCount,
    Value<DateTime?> lastUsedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FavoriteTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    templateJson: templateJson ?? this.templateJson,
    useCount: useCount ?? this.useCount,
    lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FavoriteTemplate copyWithCompanion(FavoriteTemplatesCompanion data) {
    return FavoriteTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      templateJson: data.templateJson.present
          ? data.templateJson.value
          : this.templateJson,
      useCount: data.useCount.present ? data.useCount.value : this.useCount,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('templateJson: $templateJson, ')
          ..write('useCount: $useCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    templateJson,
    useCount,
    lastUsedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.templateJson == this.templateJson &&
          other.useCount == this.useCount &&
          other.lastUsedAt == this.lastUsedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FavoriteTemplatesCompanion extends UpdateCompanion<FavoriteTemplate> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> templateJson;
  final Value<int> useCount;
  final Value<DateTime?> lastUsedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FavoriteTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.templateJson = const Value.absent(),
    this.useCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteTemplatesCompanion.insert({
    required String id,
    required String name,
    required String templateJson,
    this.useCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       templateJson = Value(templateJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FavoriteTemplate> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? templateJson,
    Expression<int>? useCount,
    Expression<DateTime>? lastUsedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (templateJson != null) 'template_json': templateJson,
      if (useCount != null) 'use_count': useCount,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? templateJson,
    Value<int>? useCount,
    Value<DateTime?>? lastUsedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FavoriteTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      templateJson: templateJson ?? this.templateJson,
      useCount: useCount ?? this.useCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (templateJson.present) {
      map['template_json'] = Variable<String>(templateJson.value);
    }
    if (useCount.present) {
      map['use_count'] = Variable<int>(useCount.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('templateJson: $templateJson, ')
          ..write('useCount: $useCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReminderSettingsTable extends ReminderSettings
    with TableInfo<$ReminderSettingsTable, ReminderSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL CHECK (id = 1)',
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _reminderTimeLocalMeta = const VerificationMeta(
    'reminderTimeLocal',
  );
  @override
  late final GeneratedColumn<String> reminderTimeLocal =
      GeneratedColumn<String>(
        'reminder_time_local',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _thresholdPercentMeta = const VerificationMeta(
    'thresholdPercent',
  );
  @override
  late final GeneratedColumn<int> thresholdPercent = GeneratedColumn<int>(
    'threshold_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeWeekdaysMaskMeta =
      const VerificationMeta('activeWeekdaysMask');
  @override
  late final GeneratedColumn<int> activeWeekdaysMask = GeneratedColumn<int>(
    'active_weekdays_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quietHoursStartMeta = const VerificationMeta(
    'quietHoursStart',
  );
  @override
  late final GeneratedColumn<String> quietHoursStart = GeneratedColumn<String>(
    'quiet_hours_start',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quietHoursEndMeta = const VerificationMeta(
    'quietHoursEnd',
  );
  @override
  late final GeneratedColumn<String> quietHoursEnd = GeneratedColumn<String>(
    'quiet_hours_end',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _permissionStatusMeta = const VerificationMeta(
    'permissionStatus',
  );
  @override
  late final GeneratedColumn<String> permissionStatus = GeneratedColumn<String>(
    'permission_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    isEnabled,
    reminderTimeLocal,
    thresholdPercent,
    activeWeekdaysMask,
    quietHoursStart,
    quietHoursEnd,
    permissionStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    } else if (isInserting) {
      context.missing(_isEnabledMeta);
    }
    if (data.containsKey('reminder_time_local')) {
      context.handle(
        _reminderTimeLocalMeta,
        reminderTimeLocal.isAcceptableOrUnknown(
          data['reminder_time_local']!,
          _reminderTimeLocalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reminderTimeLocalMeta);
    }
    if (data.containsKey('threshold_percent')) {
      context.handle(
        _thresholdPercentMeta,
        thresholdPercent.isAcceptableOrUnknown(
          data['threshold_percent']!,
          _thresholdPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_thresholdPercentMeta);
    }
    if (data.containsKey('active_weekdays_mask')) {
      context.handle(
        _activeWeekdaysMaskMeta,
        activeWeekdaysMask.isAcceptableOrUnknown(
          data['active_weekdays_mask']!,
          _activeWeekdaysMaskMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activeWeekdaysMaskMeta);
    }
    if (data.containsKey('quiet_hours_start')) {
      context.handle(
        _quietHoursStartMeta,
        quietHoursStart.isAcceptableOrUnknown(
          data['quiet_hours_start']!,
          _quietHoursStartMeta,
        ),
      );
    }
    if (data.containsKey('quiet_hours_end')) {
      context.handle(
        _quietHoursEndMeta,
        quietHoursEnd.isAcceptableOrUnknown(
          data['quiet_hours_end']!,
          _quietHoursEndMeta,
        ),
      );
    }
    if (data.containsKey('permission_status')) {
      context.handle(
        _permissionStatusMeta,
        permissionStatus.isAcceptableOrUnknown(
          data['permission_status']!,
          _permissionStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_permissionStatusMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      reminderTimeLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_time_local'],
      )!,
      thresholdPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}threshold_percent'],
      )!,
      activeWeekdaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_weekdays_mask'],
      )!,
      quietHoursStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quiet_hours_start'],
      ),
      quietHoursEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quiet_hours_end'],
      ),
      permissionStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permission_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReminderSettingsTable createAlias(String alias) {
    return $ReminderSettingsTable(attachedDatabase, alias);
  }
}

class ReminderSetting extends DataClass implements Insertable<ReminderSetting> {
  final int id;
  final bool isEnabled;
  final String reminderTimeLocal;
  final int thresholdPercent;
  final int activeWeekdaysMask;
  final String? quietHoursStart;
  final String? quietHoursEnd;
  final String permissionStatus;
  final DateTime updatedAt;
  const ReminderSetting({
    required this.id,
    required this.isEnabled,
    required this.reminderTimeLocal,
    required this.thresholdPercent,
    required this.activeWeekdaysMask,
    this.quietHoursStart,
    this.quietHoursEnd,
    required this.permissionStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['reminder_time_local'] = Variable<String>(reminderTimeLocal);
    map['threshold_percent'] = Variable<int>(thresholdPercent);
    map['active_weekdays_mask'] = Variable<int>(activeWeekdaysMask);
    if (!nullToAbsent || quietHoursStart != null) {
      map['quiet_hours_start'] = Variable<String>(quietHoursStart);
    }
    if (!nullToAbsent || quietHoursEnd != null) {
      map['quiet_hours_end'] = Variable<String>(quietHoursEnd);
    }
    map['permission_status'] = Variable<String>(permissionStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReminderSettingsCompanion toCompanion(bool nullToAbsent) {
    return ReminderSettingsCompanion(
      id: Value(id),
      isEnabled: Value(isEnabled),
      reminderTimeLocal: Value(reminderTimeLocal),
      thresholdPercent: Value(thresholdPercent),
      activeWeekdaysMask: Value(activeWeekdaysMask),
      quietHoursStart: quietHoursStart == null && nullToAbsent
          ? const Value.absent()
          : Value(quietHoursStart),
      quietHoursEnd: quietHoursEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(quietHoursEnd),
      permissionStatus: Value(permissionStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReminderSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderSetting(
      id: serializer.fromJson<int>(json['id']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      reminderTimeLocal: serializer.fromJson<String>(json['reminderTimeLocal']),
      thresholdPercent: serializer.fromJson<int>(json['thresholdPercent']),
      activeWeekdaysMask: serializer.fromJson<int>(json['activeWeekdaysMask']),
      quietHoursStart: serializer.fromJson<String?>(json['quietHoursStart']),
      quietHoursEnd: serializer.fromJson<String?>(json['quietHoursEnd']),
      permissionStatus: serializer.fromJson<String>(json['permissionStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'reminderTimeLocal': serializer.toJson<String>(reminderTimeLocal),
      'thresholdPercent': serializer.toJson<int>(thresholdPercent),
      'activeWeekdaysMask': serializer.toJson<int>(activeWeekdaysMask),
      'quietHoursStart': serializer.toJson<String?>(quietHoursStart),
      'quietHoursEnd': serializer.toJson<String?>(quietHoursEnd),
      'permissionStatus': serializer.toJson<String>(permissionStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReminderSetting copyWith({
    int? id,
    bool? isEnabled,
    String? reminderTimeLocal,
    int? thresholdPercent,
    int? activeWeekdaysMask,
    Value<String?> quietHoursStart = const Value.absent(),
    Value<String?> quietHoursEnd = const Value.absent(),
    String? permissionStatus,
    DateTime? updatedAt,
  }) => ReminderSetting(
    id: id ?? this.id,
    isEnabled: isEnabled ?? this.isEnabled,
    reminderTimeLocal: reminderTimeLocal ?? this.reminderTimeLocal,
    thresholdPercent: thresholdPercent ?? this.thresholdPercent,
    activeWeekdaysMask: activeWeekdaysMask ?? this.activeWeekdaysMask,
    quietHoursStart: quietHoursStart.present
        ? quietHoursStart.value
        : this.quietHoursStart,
    quietHoursEnd: quietHoursEnd.present
        ? quietHoursEnd.value
        : this.quietHoursEnd,
    permissionStatus: permissionStatus ?? this.permissionStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReminderSetting copyWithCompanion(ReminderSettingsCompanion data) {
    return ReminderSetting(
      id: data.id.present ? data.id.value : this.id,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      reminderTimeLocal: data.reminderTimeLocal.present
          ? data.reminderTimeLocal.value
          : this.reminderTimeLocal,
      thresholdPercent: data.thresholdPercent.present
          ? data.thresholdPercent.value
          : this.thresholdPercent,
      activeWeekdaysMask: data.activeWeekdaysMask.present
          ? data.activeWeekdaysMask.value
          : this.activeWeekdaysMask,
      quietHoursStart: data.quietHoursStart.present
          ? data.quietHoursStart.value
          : this.quietHoursStart,
      quietHoursEnd: data.quietHoursEnd.present
          ? data.quietHoursEnd.value
          : this.quietHoursEnd,
      permissionStatus: data.permissionStatus.present
          ? data.permissionStatus.value
          : this.permissionStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSetting(')
          ..write('id: $id, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('reminderTimeLocal: $reminderTimeLocal, ')
          ..write('thresholdPercent: $thresholdPercent, ')
          ..write('activeWeekdaysMask: $activeWeekdaysMask, ')
          ..write('quietHoursStart: $quietHoursStart, ')
          ..write('quietHoursEnd: $quietHoursEnd, ')
          ..write('permissionStatus: $permissionStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    isEnabled,
    reminderTimeLocal,
    thresholdPercent,
    activeWeekdaysMask,
    quietHoursStart,
    quietHoursEnd,
    permissionStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderSetting &&
          other.id == this.id &&
          other.isEnabled == this.isEnabled &&
          other.reminderTimeLocal == this.reminderTimeLocal &&
          other.thresholdPercent == this.thresholdPercent &&
          other.activeWeekdaysMask == this.activeWeekdaysMask &&
          other.quietHoursStart == this.quietHoursStart &&
          other.quietHoursEnd == this.quietHoursEnd &&
          other.permissionStatus == this.permissionStatus &&
          other.updatedAt == this.updatedAt);
}

class ReminderSettingsCompanion extends UpdateCompanion<ReminderSetting> {
  final Value<int> id;
  final Value<bool> isEnabled;
  final Value<String> reminderTimeLocal;
  final Value<int> thresholdPercent;
  final Value<int> activeWeekdaysMask;
  final Value<String?> quietHoursStart;
  final Value<String?> quietHoursEnd;
  final Value<String> permissionStatus;
  final Value<DateTime> updatedAt;
  const ReminderSettingsCompanion({
    this.id = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.reminderTimeLocal = const Value.absent(),
    this.thresholdPercent = const Value.absent(),
    this.activeWeekdaysMask = const Value.absent(),
    this.quietHoursStart = const Value.absent(),
    this.quietHoursEnd = const Value.absent(),
    this.permissionStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReminderSettingsCompanion.insert({
    this.id = const Value.absent(),
    required bool isEnabled,
    required String reminderTimeLocal,
    required int thresholdPercent,
    required int activeWeekdaysMask,
    this.quietHoursStart = const Value.absent(),
    this.quietHoursEnd = const Value.absent(),
    required String permissionStatus,
    required DateTime updatedAt,
  }) : isEnabled = Value(isEnabled),
       reminderTimeLocal = Value(reminderTimeLocal),
       thresholdPercent = Value(thresholdPercent),
       activeWeekdaysMask = Value(activeWeekdaysMask),
       permissionStatus = Value(permissionStatus),
       updatedAt = Value(updatedAt);
  static Insertable<ReminderSetting> custom({
    Expression<int>? id,
    Expression<bool>? isEnabled,
    Expression<String>? reminderTimeLocal,
    Expression<int>? thresholdPercent,
    Expression<int>? activeWeekdaysMask,
    Expression<String>? quietHoursStart,
    Expression<String>? quietHoursEnd,
    Expression<String>? permissionStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (reminderTimeLocal != null) 'reminder_time_local': reminderTimeLocal,
      if (thresholdPercent != null) 'threshold_percent': thresholdPercent,
      if (activeWeekdaysMask != null)
        'active_weekdays_mask': activeWeekdaysMask,
      if (quietHoursStart != null) 'quiet_hours_start': quietHoursStart,
      if (quietHoursEnd != null) 'quiet_hours_end': quietHoursEnd,
      if (permissionStatus != null) 'permission_status': permissionStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReminderSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? isEnabled,
    Value<String>? reminderTimeLocal,
    Value<int>? thresholdPercent,
    Value<int>? activeWeekdaysMask,
    Value<String?>? quietHoursStart,
    Value<String?>? quietHoursEnd,
    Value<String>? permissionStatus,
    Value<DateTime>? updatedAt,
  }) {
    return ReminderSettingsCompanion(
      id: id ?? this.id,
      isEnabled: isEnabled ?? this.isEnabled,
      reminderTimeLocal: reminderTimeLocal ?? this.reminderTimeLocal,
      thresholdPercent: thresholdPercent ?? this.thresholdPercent,
      activeWeekdaysMask: activeWeekdaysMask ?? this.activeWeekdaysMask,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      permissionStatus: permissionStatus ?? this.permissionStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (reminderTimeLocal.present) {
      map['reminder_time_local'] = Variable<String>(reminderTimeLocal.value);
    }
    if (thresholdPercent.present) {
      map['threshold_percent'] = Variable<int>(thresholdPercent.value);
    }
    if (activeWeekdaysMask.present) {
      map['active_weekdays_mask'] = Variable<int>(activeWeekdaysMask.value);
    }
    if (quietHoursStart.present) {
      map['quiet_hours_start'] = Variable<String>(quietHoursStart.value);
    }
    if (quietHoursEnd.present) {
      map['quiet_hours_end'] = Variable<String>(quietHoursEnd.value);
    }
    if (permissionStatus.present) {
      map['permission_status'] = Variable<String>(permissionStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSettingsCompanion(')
          ..write('id: $id, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('reminderTimeLocal: $reminderTimeLocal, ')
          ..write('thresholdPercent: $thresholdPercent, ')
          ..write('activeWeekdaysMask: $activeWeekdaysMask, ')
          ..write('quietHoursStart: $quietHoursStart, ')
          ..write('quietHoursEnd: $quietHoursEnd, ')
          ..write('permissionStatus: $permissionStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationEventsTable extends NotificationEvents
    with TableInfo<$NotificationEventsTable, NotificationEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformNotificationIdMeta =
      const VerificationMeta('platformNotificationId');
  @override
  late final GeneratedColumn<int> platformNotificationId = GeneratedColumn<int>(
    'platform_notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _scheduledForMeta = const VerificationMeta(
    'scheduledFor',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
    'scheduled_for',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localDate,
    platformNotificationId,
    scheduledFor,
    status,
    openedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('platform_notification_id')) {
      context.handle(
        _platformNotificationIdMeta,
        platformNotificationId.isAcceptableOrUnknown(
          data['platform_notification_id']!,
          _platformNotificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_platformNotificationIdMeta);
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
        _scheduledForMeta,
        scheduledFor.isAcceptableOrUnknown(
          data['scheduled_for']!,
          _scheduledForMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledForMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      platformNotificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}platform_notification_id'],
      )!,
      scheduledFor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_for'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationEventsTable createAlias(String alias) {
    return $NotificationEventsTable(attachedDatabase, alias);
  }
}

class NotificationEvent extends DataClass
    implements Insertable<NotificationEvent> {
  final String id;
  final String localDate;
  final int platformNotificationId;
  final DateTime scheduledFor;
  final String status;
  final DateTime? openedAt;
  final DateTime updatedAt;
  const NotificationEvent({
    required this.id,
    required this.localDate,
    required this.platformNotificationId,
    required this.scheduledFor,
    required this.status,
    this.openedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_date'] = Variable<String>(localDate);
    map['platform_notification_id'] = Variable<int>(platformNotificationId);
    map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || openedAt != null) {
      map['opened_at'] = Variable<DateTime>(openedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotificationEventsCompanion toCompanion(bool nullToAbsent) {
    return NotificationEventsCompanion(
      id: Value(id),
      localDate: Value(localDate),
      platformNotificationId: Value(platformNotificationId),
      scheduledFor: Value(scheduledFor),
      status: Value(status),
      openedAt: openedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(openedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationEvent(
      id: serializer.fromJson<String>(json['id']),
      localDate: serializer.fromJson<String>(json['localDate']),
      platformNotificationId: serializer.fromJson<int>(
        json['platformNotificationId'],
      ),
      scheduledFor: serializer.fromJson<DateTime>(json['scheduledFor']),
      status: serializer.fromJson<String>(json['status']),
      openedAt: serializer.fromJson<DateTime?>(json['openedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localDate': serializer.toJson<String>(localDate),
      'platformNotificationId': serializer.toJson<int>(platformNotificationId),
      'scheduledFor': serializer.toJson<DateTime>(scheduledFor),
      'status': serializer.toJson<String>(status),
      'openedAt': serializer.toJson<DateTime?>(openedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotificationEvent copyWith({
    String? id,
    String? localDate,
    int? platformNotificationId,
    DateTime? scheduledFor,
    String? status,
    Value<DateTime?> openedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => NotificationEvent(
    id: id ?? this.id,
    localDate: localDate ?? this.localDate,
    platformNotificationId:
        platformNotificationId ?? this.platformNotificationId,
    scheduledFor: scheduledFor ?? this.scheduledFor,
    status: status ?? this.status,
    openedAt: openedAt.present ? openedAt.value : this.openedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationEvent copyWithCompanion(NotificationEventsCompanion data) {
    return NotificationEvent(
      id: data.id.present ? data.id.value : this.id,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      platformNotificationId: data.platformNotificationId.present
          ? data.platformNotificationId.value
          : this.platformNotificationId,
      scheduledFor: data.scheduledFor.present
          ? data.scheduledFor.value
          : this.scheduledFor,
      status: data.status.present ? data.status.value : this.status,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationEvent(')
          ..write('id: $id, ')
          ..write('localDate: $localDate, ')
          ..write('platformNotificationId: $platformNotificationId, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localDate,
    platformNotificationId,
    scheduledFor,
    status,
    openedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationEvent &&
          other.id == this.id &&
          other.localDate == this.localDate &&
          other.platformNotificationId == this.platformNotificationId &&
          other.scheduledFor == this.scheduledFor &&
          other.status == this.status &&
          other.openedAt == this.openedAt &&
          other.updatedAt == this.updatedAt);
}

class NotificationEventsCompanion extends UpdateCompanion<NotificationEvent> {
  final Value<String> id;
  final Value<String> localDate;
  final Value<int> platformNotificationId;
  final Value<DateTime> scheduledFor;
  final Value<String> status;
  final Value<DateTime?> openedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NotificationEventsCompanion({
    this.id = const Value.absent(),
    this.localDate = const Value.absent(),
    this.platformNotificationId = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.status = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationEventsCompanion.insert({
    required String id,
    required String localDate,
    required int platformNotificationId,
    required DateTime scheduledFor,
    required String status,
    this.openedAt = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localDate = Value(localDate),
       platformNotificationId = Value(platformNotificationId),
       scheduledFor = Value(scheduledFor),
       status = Value(status),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationEvent> custom({
    Expression<String>? id,
    Expression<String>? localDate,
    Expression<int>? platformNotificationId,
    Expression<DateTime>? scheduledFor,
    Expression<String>? status,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localDate != null) 'local_date': localDate,
      if (platformNotificationId != null)
        'platform_notification_id': platformNotificationId,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
      if (status != null) 'status': status,
      if (openedAt != null) 'opened_at': openedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? localDate,
    Value<int>? platformNotificationId,
    Value<DateTime>? scheduledFor,
    Value<String>? status,
    Value<DateTime?>? openedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationEventsCompanion(
      id: id ?? this.id,
      localDate: localDate ?? this.localDate,
      platformNotificationId:
          platformNotificationId ?? this.platformNotificationId,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      status: status ?? this.status,
      openedAt: openedAt ?? this.openedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (platformNotificationId.present) {
      map['platform_notification_id'] = Variable<int>(
        platformNotificationId.value,
      );
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationEventsCompanion(')
          ..write('id: $id, ')
          ..write('localDate: $localDate, ')
          ..write('platformNotificationId: $platformNotificationId, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $ApiKeyMetadataTable apiKeyMetadata = $ApiKeyMetadataTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $DailyTargetsTable dailyTargets = $DailyTargetsTable(this);
  late final $FoodLogsTable foodLogs = $FoodLogsTable(this);
  late final $FoodItemsTable foodItems = $FoodItemsTable(this);
  late final $ChatSessionsTable chatSessions = $ChatSessionsTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $ApiKeyUsageEventsTable apiKeyUsageEvents =
      $ApiKeyUsageEventsTable(this);
  late final $FavoriteTemplatesTable favoriteTemplates =
      $FavoriteTemplatesTable(this);
  late final $ReminderSettingsTable reminderSettings = $ReminderSettingsTable(
    this,
  );
  late final $NotificationEventsTable notificationEvents =
      $NotificationEventsTable(this);
  late final Index idxDailyTargetsEffective = Index(
    'idx_daily_targets_effective',
    'CREATE INDEX idx_daily_targets_effective ON daily_targets (effective_from_date)',
  );
  late final Index idxFoodLogsLocalDateDeletedStatus = Index(
    'idx_food_logs_local_date_deleted_status',
    'CREATE INDEX idx_food_logs_local_date_deleted_status ON food_logs (local_date, deleted_at, status)',
  );
  late final Index idxFoodLogsConsumedAt = Index(
    'idx_food_logs_consumed_at',
    'CREATE INDEX idx_food_logs_consumed_at ON food_logs (consumed_at_utc)',
  );
  late final Index idxFoodItemsLogSort = Index(
    'idx_food_items_log_sort',
    'CREATE INDEX idx_food_items_log_sort ON food_items (food_log_id, sort_order)',
  );
  late final Index idxFoodItemsNormalizedName = Index(
    'idx_food_items_normalized_name',
    'CREATE INDEX idx_food_items_normalized_name ON food_items (normalized_name)',
  );
  late final Index idxChatSessionsLocalDate = Index(
    'idx_chat_sessions_local_date',
    'CREATE INDEX idx_chat_sessions_local_date ON chat_sessions (local_date)',
  );
  late final Index idxChatMessagesSessionCreated = Index(
    'idx_chat_messages_session_created',
    'CREATE INDEX idx_chat_messages_session_created ON chat_messages (session_id, created_at)',
  );
  late final Index idxChatMessagesLocalRequest = Index(
    'idx_chat_messages_local_request',
    'CREATE INDEX idx_chat_messages_local_request ON chat_messages (local_request_id)',
  );
  late final Index idxApiKeysSelection = Index(
    'idx_api_keys_selection',
    'CREATE INDEX idx_api_keys_selection ON api_key_metadata (is_enabled, priority_order, health_status, cooldown_until)',
  );
  late final Index idxApiUsageKeyCreated = Index(
    'idx_api_usage_key_created',
    'CREATE INDEX idx_api_usage_key_created ON api_key_usage_events (api_key_metadata_id, created_at)',
  );
  late final Index idxApiUsageRequest = Index(
    'idx_api_usage_request',
    'CREATE INDEX idx_api_usage_request ON api_key_usage_events (local_request_id)',
  );
  late final Index idxFavoritesName = Index(
    'idx_favorites_name',
    'CREATE INDEX idx_favorites_name ON favorite_templates (name)',
  );
  late final Index idxNotificationLocalDateStatus = Index(
    'idx_notification_local_date_status',
    'CREATE INDEX idx_notification_local_date_status ON notification_events (local_date, status)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    apiKeyMetadata,
    appSettings,
    dailyTargets,
    foodLogs,
    foodItems,
    chatSessions,
    chatMessages,
    apiKeyUsageEvents,
    favoriteTemplates,
    reminderSettings,
    notificationEvents,
    idxDailyTargetsEffective,
    idxFoodLogsLocalDateDeletedStatus,
    idxFoodLogsConsumedAt,
    idxFoodItemsLogSort,
    idxFoodItemsNormalizedName,
    idxChatSessionsLocalDate,
    idxChatMessagesSessionCreated,
    idxChatMessagesLocalRequest,
    idxApiKeysSelection,
    idxApiUsageKeyCreated,
    idxApiUsageRequest,
    idxFavoritesName,
    idxNotificationLocalDateStatus,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'api_key_metadata',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('app_settings', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'api_key_metadata',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('food_logs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'food_logs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('food_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chat_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chat_messages', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'food_logs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chat_messages', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'api_key_metadata',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('api_key_usage_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String id,
      Value<String?> displayName,
      Value<int?> birthYearOrAge,
      Value<String?> sexForFormula,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<String?> activityLevel,
      Value<String?> goalType,
      Value<int?> goalAdjustmentKcal,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> id,
      Value<String?> displayName,
      Value<int?> birthYearOrAge,
      Value<String?> sexForFormula,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<String?> activityLevel,
      Value<String?> goalType,
      Value<int?> goalAdjustmentKcal,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get birthYearOrAge => $composableBuilder(
    column: $table.birthYearOrAge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sexForFormula => $composableBuilder(
    column: $table.sexForFormula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalAdjustmentKcal => $composableBuilder(
    column: $table.goalAdjustmentKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get birthYearOrAge => $composableBuilder(
    column: $table.birthYearOrAge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sexForFormula => $composableBuilder(
    column: $table.sexForFormula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalAdjustmentKcal => $composableBuilder(
    column: $table.goalAdjustmentKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get birthYearOrAge => $composableBuilder(
    column: $table.birthYearOrAge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sexForFormula => $composableBuilder(
    column: $table.sexForFormula,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<int> get goalAdjustmentKcal => $composableBuilder(
    column: $table.goalAdjustmentKcal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<int?> birthYearOrAge = const Value.absent(),
                Value<String?> sexForFormula = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> activityLevel = const Value.absent(),
                Value<String?> goalType = const Value.absent(),
                Value<int?> goalAdjustmentKcal = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                displayName: displayName,
                birthYearOrAge: birthYearOrAge,
                sexForFormula: sexForFormula,
                heightCm: heightCm,
                weightKg: weightKg,
                activityLevel: activityLevel,
                goalType: goalType,
                goalAdjustmentKcal: goalAdjustmentKcal,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> displayName = const Value.absent(),
                Value<int?> birthYearOrAge = const Value.absent(),
                Value<String?> sexForFormula = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> activityLevel = const Value.absent(),
                Value<String?> goalType = const Value.absent(),
                Value<int?> goalAdjustmentKcal = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                displayName: displayName,
                birthYearOrAge: birthYearOrAge,
                sexForFormula: sexForFormula,
                heightCm: heightCm,
                weightKg: weightKg,
                activityLevel: activityLevel,
                goalType: goalType,
                goalAdjustmentKcal: goalAdjustmentKcal,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$ApiKeyMetadataTableCreateCompanionBuilder =
    ApiKeyMetadataCompanion Function({
      required String id,
      required String alias,
      required String secureRef,
      required String maskedSuffix,
      required int priorityOrder,
      required bool isEnabled,
      required String healthStatus,
      Value<DateTime?> cooldownUntil,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastFailureAt,
      Value<String?> lastErrorCategory,
      Value<int> successCount,
      Value<int> failureCount,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ApiKeyMetadataTableUpdateCompanionBuilder =
    ApiKeyMetadataCompanion Function({
      Value<String> id,
      Value<String> alias,
      Value<String> secureRef,
      Value<String> maskedSuffix,
      Value<int> priorityOrder,
      Value<bool> isEnabled,
      Value<String> healthStatus,
      Value<DateTime?> cooldownUntil,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastFailureAt,
      Value<String?> lastErrorCategory,
      Value<int> successCount,
      Value<int> failureCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ApiKeyMetadataTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ApiKeyMetadataTable,
          ApiKeyMetadataData
        > {
  $$ApiKeyMetadataTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AppSettingsTable, List<AppSetting>>
  _appSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appSettings,
    aliasName: 'api_key_metadata__id__app_settings__active_key_id',
  );

  $$AppSettingsTableProcessedTableManager get appSettingsRefs {
    final manager = $$AppSettingsTableTableManager(
      $_db,
      $_db.appSettings,
    ).filter((f) => f.activeKeyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_appSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FoodLogsTable, List<FoodLog>> _foodLogsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.foodLogs,
    aliasName: 'api_key_metadata__id__food_logs__ai_key_metadata_id',
  );

  $$FoodLogsTableProcessedTableManager get foodLogsRefs {
    final manager = $$FoodLogsTableTableManager($_db, $_db.foodLogs).filter(
      (f) => f.aiKeyMetadataId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_foodLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ApiKeyUsageEventsTable, List<ApiKeyUsageEvent>>
  _apiKeyUsageEventsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.apiKeyUsageEvents,
        aliasName:
            'api_key_metadata__id__api_key_usage_events__api_key_metadata_id',
      );

  $$ApiKeyUsageEventsTableProcessedTableManager get apiKeyUsageEventsRefs {
    final manager =
        $$ApiKeyUsageEventsTableTableManager(
          $_db,
          $_db.apiKeyUsageEvents,
        ).filter(
          (f) => f.apiKeyMetadataId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _apiKeyUsageEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ApiKeyMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $ApiKeyMetadataTable> {
  $$ApiKeyMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secureRef => $composableBuilder(
    column: $table.secureRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maskedSuffix => $composableBuilder(
    column: $table.maskedSuffix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityOrder => $composableBuilder(
    column: $table.priorityOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get healthStatus => $composableBuilder(
    column: $table.healthStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cooldownUntil => $composableBuilder(
    column: $table.cooldownUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastFailureAt => $composableBuilder(
    column: $table.lastFailureAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastErrorCategory => $composableBuilder(
    column: $table.lastErrorCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get successCount => $composableBuilder(
    column: $table.successCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> appSettingsRefs(
    Expression<bool> Function($$AppSettingsTableFilterComposer f) f,
  ) {
    final $$AppSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.activeKeyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableFilterComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> foodLogsRefs(
    Expression<bool> Function($$FoodLogsTableFilterComposer f) f,
  ) {
    final $$FoodLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.aiKeyMetadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableFilterComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> apiKeyUsageEventsRefs(
    Expression<bool> Function($$ApiKeyUsageEventsTableFilterComposer f) f,
  ) {
    final $$ApiKeyUsageEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.apiKeyUsageEvents,
      getReferencedColumn: (t) => t.apiKeyMetadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyUsageEventsTableFilterComposer(
            $db: $db,
            $table: $db.apiKeyUsageEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ApiKeyMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $ApiKeyMetadataTable> {
  $$ApiKeyMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alias => $composableBuilder(
    column: $table.alias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secureRef => $composableBuilder(
    column: $table.secureRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maskedSuffix => $composableBuilder(
    column: $table.maskedSuffix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityOrder => $composableBuilder(
    column: $table.priorityOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get healthStatus => $composableBuilder(
    column: $table.healthStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cooldownUntil => $composableBuilder(
    column: $table.cooldownUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastFailureAt => $composableBuilder(
    column: $table.lastFailureAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastErrorCategory => $composableBuilder(
    column: $table.lastErrorCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get successCount => $composableBuilder(
    column: $table.successCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApiKeyMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApiKeyMetadataTable> {
  $$ApiKeyMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get secureRef =>
      $composableBuilder(column: $table.secureRef, builder: (column) => column);

  GeneratedColumn<String> get maskedSuffix => $composableBuilder(
    column: $table.maskedSuffix,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priorityOrder => $composableBuilder(
    column: $table.priorityOrder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get healthStatus => $composableBuilder(
    column: $table.healthStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cooldownUntil => $composableBuilder(
    column: $table.cooldownUntil,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastFailureAt => $composableBuilder(
    column: $table.lastFailureAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastErrorCategory => $composableBuilder(
    column: $table.lastErrorCategory,
    builder: (column) => column,
  );

  GeneratedColumn<int> get successCount => $composableBuilder(
    column: $table.successCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failureCount => $composableBuilder(
    column: $table.failureCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> appSettingsRefs<T extends Object>(
    Expression<T> Function($$AppSettingsTableAnnotationComposer a) f,
  ) {
    final $$AppSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.activeKeyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> foodLogsRefs<T extends Object>(
    Expression<T> Function($$FoodLogsTableAnnotationComposer a) f,
  ) {
    final $$FoodLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.aiKeyMetadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> apiKeyUsageEventsRefs<T extends Object>(
    Expression<T> Function($$ApiKeyUsageEventsTableAnnotationComposer a) f,
  ) {
    final $$ApiKeyUsageEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.apiKeyUsageEvents,
          getReferencedColumn: (t) => t.apiKeyMetadataId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ApiKeyUsageEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.apiKeyUsageEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ApiKeyMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApiKeyMetadataTable,
          ApiKeyMetadataData,
          $$ApiKeyMetadataTableFilterComposer,
          $$ApiKeyMetadataTableOrderingComposer,
          $$ApiKeyMetadataTableAnnotationComposer,
          $$ApiKeyMetadataTableCreateCompanionBuilder,
          $$ApiKeyMetadataTableUpdateCompanionBuilder,
          (ApiKeyMetadataData, $$ApiKeyMetadataTableReferences),
          ApiKeyMetadataData,
          PrefetchHooks Function({
            bool appSettingsRefs,
            bool foodLogsRefs,
            bool apiKeyUsageEventsRefs,
          })
        > {
  $$ApiKeyMetadataTableTableManager(
    _$AppDatabase db,
    $ApiKeyMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApiKeyMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApiKeyMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApiKeyMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> alias = const Value.absent(),
                Value<String> secureRef = const Value.absent(),
                Value<String> maskedSuffix = const Value.absent(),
                Value<int> priorityOrder = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> healthStatus = const Value.absent(),
                Value<DateTime?> cooldownUntil = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastFailureAt = const Value.absent(),
                Value<String?> lastErrorCategory = const Value.absent(),
                Value<int> successCount = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApiKeyMetadataCompanion(
                id: id,
                alias: alias,
                secureRef: secureRef,
                maskedSuffix: maskedSuffix,
                priorityOrder: priorityOrder,
                isEnabled: isEnabled,
                healthStatus: healthStatus,
                cooldownUntil: cooldownUntil,
                lastSuccessAt: lastSuccessAt,
                lastFailureAt: lastFailureAt,
                lastErrorCategory: lastErrorCategory,
                successCount: successCount,
                failureCount: failureCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String alias,
                required String secureRef,
                required String maskedSuffix,
                required int priorityOrder,
                required bool isEnabled,
                required String healthStatus,
                Value<DateTime?> cooldownUntil = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastFailureAt = const Value.absent(),
                Value<String?> lastErrorCategory = const Value.absent(),
                Value<int> successCount = const Value.absent(),
                Value<int> failureCount = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ApiKeyMetadataCompanion.insert(
                id: id,
                alias: alias,
                secureRef: secureRef,
                maskedSuffix: maskedSuffix,
                priorityOrder: priorityOrder,
                isEnabled: isEnabled,
                healthStatus: healthStatus,
                cooldownUntil: cooldownUntil,
                lastSuccessAt: lastSuccessAt,
                lastFailureAt: lastFailureAt,
                lastErrorCategory: lastErrorCategory,
                successCount: successCount,
                failureCount: failureCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ApiKeyMetadataTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                appSettingsRefs = false,
                foodLogsRefs = false,
                apiKeyUsageEventsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (appSettingsRefs) db.appSettings,
                    if (foodLogsRefs) db.foodLogs,
                    if (apiKeyUsageEventsRefs) db.apiKeyUsageEvents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (appSettingsRefs)
                        await $_getPrefetchedData<
                          ApiKeyMetadataData,
                          $ApiKeyMetadataTable,
                          AppSetting
                        >(
                          currentTable: table,
                          referencedTable: $$ApiKeyMetadataTableReferences
                              ._appSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ApiKeyMetadataTableReferences(
                                db,
                                table,
                                p0,
                              ).appSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.activeKeyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (foodLogsRefs)
                        await $_getPrefetchedData<
                          ApiKeyMetadataData,
                          $ApiKeyMetadataTable,
                          FoodLog
                        >(
                          currentTable: table,
                          referencedTable: $$ApiKeyMetadataTableReferences
                              ._foodLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ApiKeyMetadataTableReferences(
                                db,
                                table,
                                p0,
                              ).foodLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.aiKeyMetadataId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (apiKeyUsageEventsRefs)
                        await $_getPrefetchedData<
                          ApiKeyMetadataData,
                          $ApiKeyMetadataTable,
                          ApiKeyUsageEvent
                        >(
                          currentTable: table,
                          referencedTable: $$ApiKeyMetadataTableReferences
                              ._apiKeyUsageEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ApiKeyMetadataTableReferences(
                                db,
                                table,
                                p0,
                              ).apiKeyUsageEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.apiKeyMetadataId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ApiKeyMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApiKeyMetadataTable,
      ApiKeyMetadataData,
      $$ApiKeyMetadataTableFilterComposer,
      $$ApiKeyMetadataTableOrderingComposer,
      $$ApiKeyMetadataTableAnnotationComposer,
      $$ApiKeyMetadataTableCreateCompanionBuilder,
      $$ApiKeyMetadataTableUpdateCompanionBuilder,
      (ApiKeyMetadataData, $$ApiKeyMetadataTableReferences),
      ApiKeyMetadataData,
      PrefetchHooks Function({
        bool appSettingsRefs,
        bool foodLogsRefs,
        bool apiKeyUsageEventsRefs,
      })
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      required bool onboardingCompleted,
      required String weightUnit,
      required String heightUnit,
      required String themeMode,
      required String locale,
      Value<String?> activeKeyId,
      required String geminiModel,
      required bool previewBeforeSave,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingCompleted,
      Value<String> weightUnit,
      Value<String> heightUnit,
      Value<String> themeMode,
      Value<String> locale,
      Value<String?> activeKeyId,
      Value<String> geminiModel,
      Value<bool> previewBeforeSave,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$AppSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting> {
  $$AppSettingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ApiKeyMetadataTable _activeKeyIdTable(_$AppDatabase db) => db
      .apiKeyMetadata
      .createAlias('app_settings__active_key_id__api_key_metadata__id');

  $$ApiKeyMetadataTableProcessedTableManager? get activeKeyId {
    final $_column = $_itemColumn<String>('active_key_id');
    if ($_column == null) return null;
    final manager = $$ApiKeyMetadataTableTableManager(
      $_db,
      $_db.apiKeyMetadata,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activeKeyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heightUnit => $composableBuilder(
    column: $table.heightUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get geminiModel => $composableBuilder(
    column: $table.geminiModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get previewBeforeSave => $composableBuilder(
    column: $table.previewBeforeSave,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ApiKeyMetadataTableFilterComposer get activeKeyId {
    final $$ApiKeyMetadataTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeKeyId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableFilterComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heightUnit => $composableBuilder(
    column: $table.heightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get geminiModel => $composableBuilder(
    column: $table.geminiModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get previewBeforeSave => $composableBuilder(
    column: $table.previewBeforeSave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ApiKeyMetadataTableOrderingComposer get activeKeyId {
    final $$ApiKeyMetadataTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeKeyId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableOrderingComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get heightUnit => $composableBuilder(
    column: $table.heightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get geminiModel => $composableBuilder(
    column: $table.geminiModel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get previewBeforeSave => $composableBuilder(
    column: $table.previewBeforeSave,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ApiKeyMetadataTableAnnotationComposer get activeKeyId {
    final $$ApiKeyMetadataTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activeKeyId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableAnnotationComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (AppSetting, $$AppSettingsTableReferences),
          AppSetting,
          PrefetchHooks Function({bool activeKeyId})
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<String> weightUnit = const Value.absent(),
                Value<String> heightUnit = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<String?> activeKeyId = const Value.absent(),
                Value<String> geminiModel = const Value.absent(),
                Value<bool> previewBeforeSave = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                onboardingCompleted: onboardingCompleted,
                weightUnit: weightUnit,
                heightUnit: heightUnit,
                themeMode: themeMode,
                locale: locale,
                activeKeyId: activeKeyId,
                geminiModel: geminiModel,
                previewBeforeSave: previewBeforeSave,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool onboardingCompleted,
                required String weightUnit,
                required String heightUnit,
                required String themeMode,
                required String locale,
                Value<String?> activeKeyId = const Value.absent(),
                required String geminiModel,
                required bool previewBeforeSave,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => AppSettingsCompanion.insert(
                id: id,
                onboardingCompleted: onboardingCompleted,
                weightUnit: weightUnit,
                heightUnit: heightUnit,
                themeMode: themeMode,
                locale: locale,
                activeKeyId: activeKeyId,
                geminiModel: geminiModel,
                previewBeforeSave: previewBeforeSave,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({activeKeyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (activeKeyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activeKeyId,
                                referencedTable: $$AppSettingsTableReferences
                                    ._activeKeyIdTable(db),
                                referencedColumn: $$AppSettingsTableReferences
                                    ._activeKeyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (AppSetting, $$AppSettingsTableReferences),
      AppSetting,
      PrefetchHooks Function({bool activeKeyId})
    >;
typedef $$DailyTargetsTableCreateCompanionBuilder =
    DailyTargetsCompanion Function({
      required String id,
      required String effectiveFromDate,
      required int calorieTarget,
      Value<double?> proteinTargetG,
      Value<double?> carbsTargetG,
      Value<double?> fatTargetG,
      required String source,
      Value<String?> formulaSnapshotJson,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$DailyTargetsTableUpdateCompanionBuilder =
    DailyTargetsCompanion Function({
      Value<String> id,
      Value<String> effectiveFromDate,
      Value<int> calorieTarget,
      Value<double?> proteinTargetG,
      Value<double?> carbsTargetG,
      Value<double?> fatTargetG,
      Value<String> source,
      Value<String?> formulaSnapshotJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$DailyTargetsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyTargetsTable> {
  $$DailyTargetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectiveFromDate => $composableBuilder(
    column: $table.effectiveFromDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calorieTarget => $composableBuilder(
    column: $table.calorieTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinTargetG => $composableBuilder(
    column: $table.proteinTargetG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsTargetG => $composableBuilder(
    column: $table.carbsTargetG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatTargetG => $composableBuilder(
    column: $table.fatTargetG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formulaSnapshotJson => $composableBuilder(
    column: $table.formulaSnapshotJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyTargetsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyTargetsTable> {
  $$DailyTargetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectiveFromDate => $composableBuilder(
    column: $table.effectiveFromDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calorieTarget => $composableBuilder(
    column: $table.calorieTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinTargetG => $composableBuilder(
    column: $table.proteinTargetG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsTargetG => $composableBuilder(
    column: $table.carbsTargetG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatTargetG => $composableBuilder(
    column: $table.fatTargetG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formulaSnapshotJson => $composableBuilder(
    column: $table.formulaSnapshotJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyTargetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyTargetsTable> {
  $$DailyTargetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get effectiveFromDate => $composableBuilder(
    column: $table.effectiveFromDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calorieTarget => $composableBuilder(
    column: $table.calorieTarget,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinTargetG => $composableBuilder(
    column: $table.proteinTargetG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsTargetG => $composableBuilder(
    column: $table.carbsTargetG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatTargetG => $composableBuilder(
    column: $table.fatTargetG,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get formulaSnapshotJson => $composableBuilder(
    column: $table.formulaSnapshotJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DailyTargetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyTargetsTable,
          DailyTarget,
          $$DailyTargetsTableFilterComposer,
          $$DailyTargetsTableOrderingComposer,
          $$DailyTargetsTableAnnotationComposer,
          $$DailyTargetsTableCreateCompanionBuilder,
          $$DailyTargetsTableUpdateCompanionBuilder,
          (
            DailyTarget,
            BaseReferences<_$AppDatabase, $DailyTargetsTable, DailyTarget>,
          ),
          DailyTarget,
          PrefetchHooks Function()
        > {
  $$DailyTargetsTableTableManager(_$AppDatabase db, $DailyTargetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyTargetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyTargetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyTargetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> effectiveFromDate = const Value.absent(),
                Value<int> calorieTarget = const Value.absent(),
                Value<double?> proteinTargetG = const Value.absent(),
                Value<double?> carbsTargetG = const Value.absent(),
                Value<double?> fatTargetG = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> formulaSnapshotJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyTargetsCompanion(
                id: id,
                effectiveFromDate: effectiveFromDate,
                calorieTarget: calorieTarget,
                proteinTargetG: proteinTargetG,
                carbsTargetG: carbsTargetG,
                fatTargetG: fatTargetG,
                source: source,
                formulaSnapshotJson: formulaSnapshotJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String effectiveFromDate,
                required int calorieTarget,
                Value<double?> proteinTargetG = const Value.absent(),
                Value<double?> carbsTargetG = const Value.absent(),
                Value<double?> fatTargetG = const Value.absent(),
                required String source,
                Value<String?> formulaSnapshotJson = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyTargetsCompanion.insert(
                id: id,
                effectiveFromDate: effectiveFromDate,
                calorieTarget: calorieTarget,
                proteinTargetG: proteinTargetG,
                carbsTargetG: carbsTargetG,
                fatTargetG: fatTargetG,
                source: source,
                formulaSnapshotJson: formulaSnapshotJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyTargetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyTargetsTable,
      DailyTarget,
      $$DailyTargetsTableFilterComposer,
      $$DailyTargetsTableOrderingComposer,
      $$DailyTargetsTableAnnotationComposer,
      $$DailyTargetsTableCreateCompanionBuilder,
      $$DailyTargetsTableUpdateCompanionBuilder,
      (
        DailyTarget,
        BaseReferences<_$AppDatabase, $DailyTargetsTable, DailyTarget>,
      ),
      DailyTarget,
      PrefetchHooks Function()
    >;
typedef $$FoodLogsTableCreateCompanionBuilder =
    FoodLogsCompanion Function({
      required String id,
      Value<String?> localRequestId,
      required String localDate,
      required DateTime consumedAtUtc,
      required int timezoneOffsetMinutes,
      required String mealType,
      required String source,
      required String status,
      Value<String?> originalUserText,
      Value<String?> notes,
      required double totalCaloriesKcal,
      Value<double?> totalProteinG,
      Value<double?> totalCarbsG,
      Value<double?> totalFatG,
      Value<String?> aiModel,
      Value<String?> aiKeyMetadataId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$FoodLogsTableUpdateCompanionBuilder =
    FoodLogsCompanion Function({
      Value<String> id,
      Value<String?> localRequestId,
      Value<String> localDate,
      Value<DateTime> consumedAtUtc,
      Value<int> timezoneOffsetMinutes,
      Value<String> mealType,
      Value<String> source,
      Value<String> status,
      Value<String?> originalUserText,
      Value<String?> notes,
      Value<double> totalCaloriesKcal,
      Value<double?> totalProteinG,
      Value<double?> totalCarbsG,
      Value<double?> totalFatG,
      Value<String?> aiModel,
      Value<String?> aiKeyMetadataId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$FoodLogsTableReferences
    extends BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog> {
  $$FoodLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ApiKeyMetadataTable _aiKeyMetadataIdTable(_$AppDatabase db) => db
      .apiKeyMetadata
      .createAlias('food_logs__ai_key_metadata_id__api_key_metadata__id');

  $$ApiKeyMetadataTableProcessedTableManager? get aiKeyMetadataId {
    final $_column = $_itemColumn<String>('ai_key_metadata_id');
    if ($_column == null) return null;
    final manager = $$ApiKeyMetadataTableTableManager(
      $_db,
      $_db.apiKeyMetadata,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_aiKeyMetadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FoodItemsTable, List<FoodItem>>
  _foodItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.foodItems,
    aliasName: 'food_logs__id__food_items__food_log_id',
  );

  $$FoodItemsTableProcessedTableManager get foodItemsRefs {
    final manager = $$FoodItemsTableTableManager(
      $_db,
      $_db.foodItems,
    ).filter((f) => f.foodLogId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_foodItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatMessagesTable, List<ChatMessage>>
  _chatMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chatMessages,
    aliasName: 'food_logs__id__chat_messages__food_log_id',
  );

  $$ChatMessagesTableProcessedTableManager get chatMessagesRefs {
    final manager = $$ChatMessagesTableTableManager(
      $_db,
      $_db.chatMessages,
    ).filter((f) => f.foodLogId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FoodLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get consumedAtUtc => $composableBuilder(
    column: $table.consumedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timezoneOffsetMinutes => $composableBuilder(
    column: $table.timezoneOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalUserText => $composableBuilder(
    column: $table.originalUserText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCaloriesKcal => $composableBuilder(
    column: $table.totalCaloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalProteinG => $composableBuilder(
    column: $table.totalProteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCarbsG => $composableBuilder(
    column: $table.totalCarbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalFatG => $composableBuilder(
    column: $table.totalFatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiModel => $composableBuilder(
    column: $table.aiModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ApiKeyMetadataTableFilterComposer get aiKeyMetadataId {
    final $$ApiKeyMetadataTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aiKeyMetadataId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableFilterComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> foodItemsRefs(
    Expression<bool> Function($$FoodItemsTableFilterComposer f) f,
  ) {
    final $$FoodItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.foodLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableFilterComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> chatMessagesRefs(
    Expression<bool> Function($$ChatMessagesTableFilterComposer f) f,
  ) {
    final $$ChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.foodLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get consumedAtUtc => $composableBuilder(
    column: $table.consumedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timezoneOffsetMinutes => $composableBuilder(
    column: $table.timezoneOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalUserText => $composableBuilder(
    column: $table.originalUserText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCaloriesKcal => $composableBuilder(
    column: $table.totalCaloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalProteinG => $composableBuilder(
    column: $table.totalProteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCarbsG => $composableBuilder(
    column: $table.totalCarbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalFatG => $composableBuilder(
    column: $table.totalFatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiModel => $composableBuilder(
    column: $table.aiModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ApiKeyMetadataTableOrderingComposer get aiKeyMetadataId {
    final $$ApiKeyMetadataTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aiKeyMetadataId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableOrderingComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<DateTime> get consumedAtUtc => $composableBuilder(
    column: $table.consumedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timezoneOffsetMinutes => $composableBuilder(
    column: $table.timezoneOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get originalUserText => $composableBuilder(
    column: $table.originalUserText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get totalCaloriesKcal => $composableBuilder(
    column: $table.totalCaloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalProteinG => $composableBuilder(
    column: $table.totalProteinG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCarbsG => $composableBuilder(
    column: $table.totalCarbsG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalFatG =>
      $composableBuilder(column: $table.totalFatG, builder: (column) => column);

  GeneratedColumn<String> get aiModel =>
      $composableBuilder(column: $table.aiModel, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ApiKeyMetadataTableAnnotationComposer get aiKeyMetadataId {
    final $$ApiKeyMetadataTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.aiKeyMetadataId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableAnnotationComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> foodItemsRefs<T extends Object>(
    Expression<T> Function($$FoodItemsTableAnnotationComposer a) f,
  ) {
    final $$FoodItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.foodItems,
      getReferencedColumn: (t) => t.foodLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> chatMessagesRefs<T extends Object>(
    Expression<T> Function($$ChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$ChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.foodLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoodLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodLogsTable,
          FoodLog,
          $$FoodLogsTableFilterComposer,
          $$FoodLogsTableOrderingComposer,
          $$FoodLogsTableAnnotationComposer,
          $$FoodLogsTableCreateCompanionBuilder,
          $$FoodLogsTableUpdateCompanionBuilder,
          (FoodLog, $$FoodLogsTableReferences),
          FoodLog,
          PrefetchHooks Function({
            bool aiKeyMetadataId,
            bool foodItemsRefs,
            bool chatMessagesRefs,
          })
        > {
  $$FoodLogsTableTableManager(_$AppDatabase db, $FoodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> localRequestId = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<DateTime> consumedAtUtc = const Value.absent(),
                Value<int> timezoneOffsetMinutes = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> originalUserText = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double> totalCaloriesKcal = const Value.absent(),
                Value<double?> totalProteinG = const Value.absent(),
                Value<double?> totalCarbsG = const Value.absent(),
                Value<double?> totalFatG = const Value.absent(),
                Value<String?> aiModel = const Value.absent(),
                Value<String?> aiKeyMetadataId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodLogsCompanion(
                id: id,
                localRequestId: localRequestId,
                localDate: localDate,
                consumedAtUtc: consumedAtUtc,
                timezoneOffsetMinutes: timezoneOffsetMinutes,
                mealType: mealType,
                source: source,
                status: status,
                originalUserText: originalUserText,
                notes: notes,
                totalCaloriesKcal: totalCaloriesKcal,
                totalProteinG: totalProteinG,
                totalCarbsG: totalCarbsG,
                totalFatG: totalFatG,
                aiModel: aiModel,
                aiKeyMetadataId: aiKeyMetadataId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> localRequestId = const Value.absent(),
                required String localDate,
                required DateTime consumedAtUtc,
                required int timezoneOffsetMinutes,
                required String mealType,
                required String source,
                required String status,
                Value<String?> originalUserText = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required double totalCaloriesKcal,
                Value<double?> totalProteinG = const Value.absent(),
                Value<double?> totalCarbsG = const Value.absent(),
                Value<double?> totalFatG = const Value.absent(),
                Value<String?> aiModel = const Value.absent(),
                Value<String?> aiKeyMetadataId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodLogsCompanion.insert(
                id: id,
                localRequestId: localRequestId,
                localDate: localDate,
                consumedAtUtc: consumedAtUtc,
                timezoneOffsetMinutes: timezoneOffsetMinutes,
                mealType: mealType,
                source: source,
                status: status,
                originalUserText: originalUserText,
                notes: notes,
                totalCaloriesKcal: totalCaloriesKcal,
                totalProteinG: totalProteinG,
                totalCarbsG: totalCarbsG,
                totalFatG: totalFatG,
                aiModel: aiModel,
                aiKeyMetadataId: aiKeyMetadataId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                aiKeyMetadataId = false,
                foodItemsRefs = false,
                chatMessagesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (foodItemsRefs) db.foodItems,
                    if (chatMessagesRefs) db.chatMessages,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (aiKeyMetadataId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.aiKeyMetadataId,
                                    referencedTable: $$FoodLogsTableReferences
                                        ._aiKeyMetadataIdTable(db),
                                    referencedColumn: $$FoodLogsTableReferences
                                        ._aiKeyMetadataIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (foodItemsRefs)
                        await $_getPrefetchedData<
                          FoodLog,
                          $FoodLogsTable,
                          FoodItem
                        >(
                          currentTable: table,
                          referencedTable: $$FoodLogsTableReferences
                              ._foodItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodLogsTableReferences(
                                db,
                                table,
                                p0,
                              ).foodItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodLogId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (chatMessagesRefs)
                        await $_getPrefetchedData<
                          FoodLog,
                          $FoodLogsTable,
                          ChatMessage
                        >(
                          currentTable: table,
                          referencedTable: $$FoodLogsTableReferences
                              ._chatMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FoodLogsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foodLogId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FoodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodLogsTable,
      FoodLog,
      $$FoodLogsTableFilterComposer,
      $$FoodLogsTableOrderingComposer,
      $$FoodLogsTableAnnotationComposer,
      $$FoodLogsTableCreateCompanionBuilder,
      $$FoodLogsTableUpdateCompanionBuilder,
      (FoodLog, $$FoodLogsTableReferences),
      FoodLog,
      PrefetchHooks Function({
        bool aiKeyMetadataId,
        bool foodItemsRefs,
        bool chatMessagesRefs,
      })
    >;
typedef $$FoodItemsTableCreateCompanionBuilder =
    FoodItemsCompanion Function({
      required String id,
      required String foodLogId,
      required String displayName,
      Value<String?> normalizedName,
      Value<double?> quantity,
      Value<String?> unit,
      Value<String?> portionText,
      required double caloriesKcal,
      Value<double?> proteinG,
      Value<double?> carbsG,
      Value<double?> fatG,
      Value<double?> fiberG,
      Value<double?> sodiumMg,
      Value<double?> confidence,
      Value<String?> assumptionNote,
      required int sortOrder,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FoodItemsTableUpdateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<String> id,
      Value<String> foodLogId,
      Value<String> displayName,
      Value<String?> normalizedName,
      Value<double?> quantity,
      Value<String?> unit,
      Value<String?> portionText,
      Value<double> caloriesKcal,
      Value<double?> proteinG,
      Value<double?> carbsG,
      Value<double?> fatG,
      Value<double?> fiberG,
      Value<double?> sodiumMg,
      Value<double?> confidence,
      Value<String?> assumptionNote,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FoodItemsTableReferences
    extends BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem> {
  $$FoodItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FoodLogsTable _foodLogIdTable(_$AppDatabase db) =>
      db.foodLogs.createAlias('food_items__food_log_id__food_logs__id');

  $$FoodLogsTableProcessedTableManager get foodLogId {
    final $_column = $_itemColumn<String>('food_log_id')!;

    final manager = $$FoodLogsTableTableManager(
      $_db,
      $_db.foodLogs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodLogIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FoodItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get portionText => $composableBuilder(
    column: $table.portionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiberG => $composableBuilder(
    column: $table.fiberG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sodiumMg => $composableBuilder(
    column: $table.sodiumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assumptionNote => $composableBuilder(
    column: $table.assumptionNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FoodLogsTableFilterComposer get foodLogId {
    final $$FoodLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodLogId,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableFilterComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get portionText => $composableBuilder(
    column: $table.portionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiberG => $composableBuilder(
    column: $table.fiberG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sodiumMg => $composableBuilder(
    column: $table.sodiumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assumptionNote => $composableBuilder(
    column: $table.assumptionNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoodLogsTableOrderingComposer get foodLogId {
    final $$FoodLogsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodLogId,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableOrderingComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get portionText => $composableBuilder(
    column: $table.portionText,
    builder: (column) => column,
  );

  GeneratedColumn<double> get caloriesKcal => $composableBuilder(
    column: $table.caloriesKcal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<double> get fiberG =>
      $composableBuilder(column: $table.fiberG, builder: (column) => column);

  GeneratedColumn<double> get sodiumMg =>
      $composableBuilder(column: $table.sodiumMg, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assumptionNote => $composableBuilder(
    column: $table.assumptionNote,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FoodLogsTableAnnotationComposer get foodLogId {
    final $$FoodLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodLogId,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoodItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemsTable,
          FoodItem,
          $$FoodItemsTableFilterComposer,
          $$FoodItemsTableOrderingComposer,
          $$FoodItemsTableAnnotationComposer,
          $$FoodItemsTableCreateCompanionBuilder,
          $$FoodItemsTableUpdateCompanionBuilder,
          (FoodItem, $$FoodItemsTableReferences),
          FoodItem,
          PrefetchHooks Function({bool foodLogId})
        > {
  $$FoodItemsTableTableManager(_$AppDatabase db, $FoodItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> foodLogId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> normalizedName = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> portionText = const Value.absent(),
                Value<double> caloriesKcal = const Value.absent(),
                Value<double?> proteinG = const Value.absent(),
                Value<double?> carbsG = const Value.absent(),
                Value<double?> fatG = const Value.absent(),
                Value<double?> fiberG = const Value.absent(),
                Value<double?> sodiumMg = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<String?> assumptionNote = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FoodItemsCompanion(
                id: id,
                foodLogId: foodLogId,
                displayName: displayName,
                normalizedName: normalizedName,
                quantity: quantity,
                unit: unit,
                portionText: portionText,
                caloriesKcal: caloriesKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                fiberG: fiberG,
                sodiumMg: sodiumMg,
                confidence: confidence,
                assumptionNote: assumptionNote,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String foodLogId,
                required String displayName,
                Value<String?> normalizedName = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> portionText = const Value.absent(),
                required double caloriesKcal,
                Value<double?> proteinG = const Value.absent(),
                Value<double?> carbsG = const Value.absent(),
                Value<double?> fatG = const Value.absent(),
                Value<double?> fiberG = const Value.absent(),
                Value<double?> sodiumMg = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<String?> assumptionNote = const Value.absent(),
                required int sortOrder,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FoodItemsCompanion.insert(
                id: id,
                foodLogId: foodLogId,
                displayName: displayName,
                normalizedName: normalizedName,
                quantity: quantity,
                unit: unit,
                portionText: portionText,
                caloriesKcal: caloriesKcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                fiberG: fiberG,
                sodiumMg: sodiumMg,
                confidence: confidence,
                assumptionNote: assumptionNote,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FoodItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foodLogId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foodLogId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodLogId,
                                referencedTable: $$FoodItemsTableReferences
                                    ._foodLogIdTable(db),
                                referencedColumn: $$FoodItemsTableReferences
                                    ._foodLogIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FoodItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemsTable,
      FoodItem,
      $$FoodItemsTableFilterComposer,
      $$FoodItemsTableOrderingComposer,
      $$FoodItemsTableAnnotationComposer,
      $$FoodItemsTableCreateCompanionBuilder,
      $$FoodItemsTableUpdateCompanionBuilder,
      (FoodItem, $$FoodItemsTableReferences),
      FoodItem,
      PrefetchHooks Function({bool foodLogId})
    >;
typedef $$ChatSessionsTableCreateCompanionBuilder =
    ChatSessionsCompanion Function({
      required String id,
      required String localDate,
      Value<String?> title,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ChatSessionsTableUpdateCompanionBuilder =
    ChatSessionsCompanion Function({
      Value<String> id,
      Value<String> localDate,
      Value<String?> title,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ChatSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $ChatSessionsTable, ChatSession> {
  $$ChatSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChatMessagesTable, List<ChatMessage>>
  _chatMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chatMessages,
    aliasName: 'chat_sessions__id__chat_messages__session_id',
  );

  $$ChatMessagesTableProcessedTableManager get chatMessagesRefs {
    final manager = $$ChatMessagesTableTableManager(
      $_db,
      $_db.chatMessages,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChatSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chatMessagesRefs(
    Expression<bool> Function($$ChatMessagesTableFilterComposer f) f,
  ) {
    final $$ChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChatSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatSessionsTable> {
  $$ChatSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> chatMessagesRefs<T extends Object>(
    Expression<T> Function($$ChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$ChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatSessionsTable,
          ChatSession,
          $$ChatSessionsTableFilterComposer,
          $$ChatSessionsTableOrderingComposer,
          $$ChatSessionsTableAnnotationComposer,
          $$ChatSessionsTableCreateCompanionBuilder,
          $$ChatSessionsTableUpdateCompanionBuilder,
          (ChatSession, $$ChatSessionsTableReferences),
          ChatSession,
          PrefetchHooks Function({bool chatMessagesRefs})
        > {
  $$ChatSessionsTableTableManager(_$AppDatabase db, $ChatSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatSessionsCompanion(
                id: id,
                localDate: localDate,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localDate,
                Value<String?> title = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ChatSessionsCompanion.insert(
                id: id,
                localDate: localDate,
                title: title,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({chatMessagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (chatMessagesRefs) db.chatMessages],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatMessagesRefs)
                    await $_getPrefetchedData<
                      ChatSession,
                      $ChatSessionsTable,
                      ChatMessage
                    >(
                      currentTable: table,
                      referencedTable: $$ChatSessionsTableReferences
                          ._chatMessagesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ChatSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).chatMessagesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChatSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatSessionsTable,
      ChatSession,
      $$ChatSessionsTableFilterComposer,
      $$ChatSessionsTableOrderingComposer,
      $$ChatSessionsTableAnnotationComposer,
      $$ChatSessionsTableCreateCompanionBuilder,
      $$ChatSessionsTableUpdateCompanionBuilder,
      (ChatSession, $$ChatSessionsTableReferences),
      ChatSession,
      PrefetchHooks Function({bool chatMessagesRefs})
    >;
typedef $$ChatMessagesTableCreateCompanionBuilder =
    ChatMessagesCompanion Function({
      required String id,
      required String sessionId,
      required String role,
      required String contentText,
      required String status,
      Value<String?> foodLogId,
      Value<String?> localRequestId,
      Value<String?> errorCategory,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ChatMessagesTableUpdateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> role,
      Value<String> contentText,
      Value<String> status,
      Value<String?> foodLogId,
      Value<String?> localRequestId,
      Value<String?> errorCategory,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ChatMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage> {
  $$ChatMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatSessionsTable _sessionIdTable(_$AppDatabase db) => db.chatSessions
      .createAlias('chat_messages__session_id__chat_sessions__id');

  $$ChatSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$ChatSessionsTableTableManager(
      $_db,
      $_db.chatSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FoodLogsTable _foodLogIdTable(_$AppDatabase db) =>
      db.foodLogs.createAlias('chat_messages__food_log_id__food_logs__id');

  $$FoodLogsTableProcessedTableManager? get foodLogId {
    final $_column = $_itemColumn<String>('food_log_id');
    if ($_column == null) return null;
    final manager = $$FoodLogsTableTableManager(
      $_db,
      $_db.foodLogs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foodLogIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentText => $composableBuilder(
    column: $table.contentText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCategory => $composableBuilder(
    column: $table.errorCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ChatSessionsTableFilterComposer get sessionId {
    final $$ChatSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableFilterComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodLogsTableFilterComposer get foodLogId {
    final $$FoodLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodLogId,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableFilterComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentText => $composableBuilder(
    column: $table.contentText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCategory => $composableBuilder(
    column: $table.errorCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChatSessionsTableOrderingComposer get sessionId {
    final $$ChatSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodLogsTableOrderingComposer get foodLogId {
    final $$FoodLogsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodLogId,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableOrderingComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get contentText => $composableBuilder(
    column: $table.contentText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorCategory => $composableBuilder(
    column: $table.errorCategory,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChatSessionsTableAnnotationComposer get sessionId {
    final $$ChatSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.chatSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.chatSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FoodLogsTableAnnotationComposer get foodLogId {
    final $$FoodLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foodLogId,
      referencedTable: $db.foodLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoodLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.foodLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatMessagesTable,
          ChatMessage,
          $$ChatMessagesTableFilterComposer,
          $$ChatMessagesTableOrderingComposer,
          $$ChatMessagesTableAnnotationComposer,
          $$ChatMessagesTableCreateCompanionBuilder,
          $$ChatMessagesTableUpdateCompanionBuilder,
          (ChatMessage, $$ChatMessagesTableReferences),
          ChatMessage,
          PrefetchHooks Function({bool sessionId, bool foodLogId})
        > {
  $$ChatMessagesTableTableManager(_$AppDatabase db, $ChatMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> contentText = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> foodLogId = const Value.absent(),
                Value<String?> localRequestId = const Value.absent(),
                Value<String?> errorCategory = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatMessagesCompanion(
                id: id,
                sessionId: sessionId,
                role: role,
                contentText: contentText,
                status: status,
                foodLogId: foodLogId,
                localRequestId: localRequestId,
                errorCategory: errorCategory,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String role,
                required String contentText,
                required String status,
                Value<String?> foodLogId = const Value.absent(),
                Value<String?> localRequestId = const Value.absent(),
                Value<String?> errorCategory = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ChatMessagesCompanion.insert(
                id: id,
                sessionId: sessionId,
                role: role,
                contentText: contentText,
                status: status,
                foodLogId: foodLogId,
                localRequestId: localRequestId,
                errorCategory: errorCategory,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, foodLogId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$ChatMessagesTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$ChatMessagesTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (foodLogId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foodLogId,
                                referencedTable: $$ChatMessagesTableReferences
                                    ._foodLogIdTable(db),
                                referencedColumn: $$ChatMessagesTableReferences
                                    ._foodLogIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatMessagesTable,
      ChatMessage,
      $$ChatMessagesTableFilterComposer,
      $$ChatMessagesTableOrderingComposer,
      $$ChatMessagesTableAnnotationComposer,
      $$ChatMessagesTableCreateCompanionBuilder,
      $$ChatMessagesTableUpdateCompanionBuilder,
      (ChatMessage, $$ChatMessagesTableReferences),
      ChatMessage,
      PrefetchHooks Function({bool sessionId, bool foodLogId})
    >;
typedef $$ApiKeyUsageEventsTableCreateCompanionBuilder =
    ApiKeyUsageEventsCompanion Function({
      required String id,
      required String apiKeyMetadataId,
      required String localRequestId,
      required String operation,
      required String outcome,
      Value<String?> errorCategory,
      Value<int?> httpStatus,
      Value<int?> latencyMs,
      Value<int?> promptTokens,
      Value<int?> outputTokens,
      Value<String?> modelId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ApiKeyUsageEventsTableUpdateCompanionBuilder =
    ApiKeyUsageEventsCompanion Function({
      Value<String> id,
      Value<String> apiKeyMetadataId,
      Value<String> localRequestId,
      Value<String> operation,
      Value<String> outcome,
      Value<String?> errorCategory,
      Value<int?> httpStatus,
      Value<int?> latencyMs,
      Value<int?> promptTokens,
      Value<int?> outputTokens,
      Value<String?> modelId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ApiKeyUsageEventsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ApiKeyUsageEventsTable,
          ApiKeyUsageEvent
        > {
  $$ApiKeyUsageEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ApiKeyMetadataTable _apiKeyMetadataIdTable(_$AppDatabase db) =>
      db.apiKeyMetadata.createAlias(
        'api_key_usage_events__api_key_metadata_id__api_key_metadata__id',
      );

  $$ApiKeyMetadataTableProcessedTableManager get apiKeyMetadataId {
    final $_column = $_itemColumn<String>('api_key_metadata_id')!;

    final manager = $$ApiKeyMetadataTableTableManager(
      $_db,
      $_db.apiKeyMetadata,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_apiKeyMetadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ApiKeyUsageEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ApiKeyUsageEventsTable> {
  $$ApiKeyUsageEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCategory => $composableBuilder(
    column: $table.errorCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get httpStatus => $composableBuilder(
    column: $table.httpStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get latencyMs => $composableBuilder(
    column: $table.latencyMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get promptTokens => $composableBuilder(
    column: $table.promptTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ApiKeyMetadataTableFilterComposer get apiKeyMetadataId {
    final $$ApiKeyMetadataTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiKeyMetadataId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableFilterComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApiKeyUsageEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ApiKeyUsageEventsTable> {
  $$ApiKeyUsageEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCategory => $composableBuilder(
    column: $table.errorCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get httpStatus => $composableBuilder(
    column: $table.httpStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get latencyMs => $composableBuilder(
    column: $table.latencyMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get promptTokens => $composableBuilder(
    column: $table.promptTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ApiKeyMetadataTableOrderingComposer get apiKeyMetadataId {
    final $$ApiKeyMetadataTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiKeyMetadataId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableOrderingComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApiKeyUsageEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApiKeyUsageEventsTable> {
  $$ApiKeyUsageEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localRequestId => $composableBuilder(
    column: $table.localRequestId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get errorCategory => $composableBuilder(
    column: $table.errorCategory,
    builder: (column) => column,
  );

  GeneratedColumn<int> get httpStatus => $composableBuilder(
    column: $table.httpStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get latencyMs =>
      $composableBuilder(column: $table.latencyMs, builder: (column) => column);

  GeneratedColumn<int> get promptTokens => $composableBuilder(
    column: $table.promptTokens,
    builder: (column) => column,
  );

  GeneratedColumn<int> get outputTokens => $composableBuilder(
    column: $table.outputTokens,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelId =>
      $composableBuilder(column: $table.modelId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ApiKeyMetadataTableAnnotationComposer get apiKeyMetadataId {
    final $$ApiKeyMetadataTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiKeyMetadataId,
      referencedTable: $db.apiKeyMetadata,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiKeyMetadataTableAnnotationComposer(
            $db: $db,
            $table: $db.apiKeyMetadata,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ApiKeyUsageEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApiKeyUsageEventsTable,
          ApiKeyUsageEvent,
          $$ApiKeyUsageEventsTableFilterComposer,
          $$ApiKeyUsageEventsTableOrderingComposer,
          $$ApiKeyUsageEventsTableAnnotationComposer,
          $$ApiKeyUsageEventsTableCreateCompanionBuilder,
          $$ApiKeyUsageEventsTableUpdateCompanionBuilder,
          (ApiKeyUsageEvent, $$ApiKeyUsageEventsTableReferences),
          ApiKeyUsageEvent,
          PrefetchHooks Function({bool apiKeyMetadataId})
        > {
  $$ApiKeyUsageEventsTableTableManager(
    _$AppDatabase db,
    $ApiKeyUsageEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApiKeyUsageEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApiKeyUsageEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApiKeyUsageEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> apiKeyMetadataId = const Value.absent(),
                Value<String> localRequestId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<String?> errorCategory = const Value.absent(),
                Value<int?> httpStatus = const Value.absent(),
                Value<int?> latencyMs = const Value.absent(),
                Value<int?> promptTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<String?> modelId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApiKeyUsageEventsCompanion(
                id: id,
                apiKeyMetadataId: apiKeyMetadataId,
                localRequestId: localRequestId,
                operation: operation,
                outcome: outcome,
                errorCategory: errorCategory,
                httpStatus: httpStatus,
                latencyMs: latencyMs,
                promptTokens: promptTokens,
                outputTokens: outputTokens,
                modelId: modelId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String apiKeyMetadataId,
                required String localRequestId,
                required String operation,
                required String outcome,
                Value<String?> errorCategory = const Value.absent(),
                Value<int?> httpStatus = const Value.absent(),
                Value<int?> latencyMs = const Value.absent(),
                Value<int?> promptTokens = const Value.absent(),
                Value<int?> outputTokens = const Value.absent(),
                Value<String?> modelId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ApiKeyUsageEventsCompanion.insert(
                id: id,
                apiKeyMetadataId: apiKeyMetadataId,
                localRequestId: localRequestId,
                operation: operation,
                outcome: outcome,
                errorCategory: errorCategory,
                httpStatus: httpStatus,
                latencyMs: latencyMs,
                promptTokens: promptTokens,
                outputTokens: outputTokens,
                modelId: modelId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ApiKeyUsageEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({apiKeyMetadataId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (apiKeyMetadataId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.apiKeyMetadataId,
                                referencedTable:
                                    $$ApiKeyUsageEventsTableReferences
                                        ._apiKeyMetadataIdTable(db),
                                referencedColumn:
                                    $$ApiKeyUsageEventsTableReferences
                                        ._apiKeyMetadataIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ApiKeyUsageEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApiKeyUsageEventsTable,
      ApiKeyUsageEvent,
      $$ApiKeyUsageEventsTableFilterComposer,
      $$ApiKeyUsageEventsTableOrderingComposer,
      $$ApiKeyUsageEventsTableAnnotationComposer,
      $$ApiKeyUsageEventsTableCreateCompanionBuilder,
      $$ApiKeyUsageEventsTableUpdateCompanionBuilder,
      (ApiKeyUsageEvent, $$ApiKeyUsageEventsTableReferences),
      ApiKeyUsageEvent,
      PrefetchHooks Function({bool apiKeyMetadataId})
    >;
typedef $$FavoriteTemplatesTableCreateCompanionBuilder =
    FavoriteTemplatesCompanion Function({
      required String id,
      required String name,
      required String templateJson,
      Value<int> useCount,
      Value<DateTime?> lastUsedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FavoriteTemplatesTableUpdateCompanionBuilder =
    FavoriteTemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> templateJson,
      Value<int> useCount,
      Value<DateTime?> lastUsedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$FavoriteTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteTemplatesTable> {
  $$FavoriteTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateJson => $composableBuilder(
    column: $table.templateJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get useCount => $composableBuilder(
    column: $table.useCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteTemplatesTable> {
  $$FavoriteTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateJson => $composableBuilder(
    column: $table.templateJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get useCount => $composableBuilder(
    column: $table.useCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteTemplatesTable> {
  $$FavoriteTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get templateJson => $composableBuilder(
    column: $table.templateJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get useCount =>
      $composableBuilder(column: $table.useCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FavoriteTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteTemplatesTable,
          FavoriteTemplate,
          $$FavoriteTemplatesTableFilterComposer,
          $$FavoriteTemplatesTableOrderingComposer,
          $$FavoriteTemplatesTableAnnotationComposer,
          $$FavoriteTemplatesTableCreateCompanionBuilder,
          $$FavoriteTemplatesTableUpdateCompanionBuilder,
          (
            FavoriteTemplate,
            BaseReferences<
              _$AppDatabase,
              $FavoriteTemplatesTable,
              FavoriteTemplate
            >,
          ),
          FavoriteTemplate,
          PrefetchHooks Function()
        > {
  $$FavoriteTemplatesTableTableManager(
    _$AppDatabase db,
    $FavoriteTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> templateJson = const Value.absent(),
                Value<int> useCount = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteTemplatesCompanion(
                id: id,
                name: name,
                templateJson: templateJson,
                useCount: useCount,
                lastUsedAt: lastUsedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String templateJson,
                Value<int> useCount = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteTemplatesCompanion.insert(
                id: id,
                name: name,
                templateJson: templateJson,
                useCount: useCount,
                lastUsedAt: lastUsedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteTemplatesTable,
      FavoriteTemplate,
      $$FavoriteTemplatesTableFilterComposer,
      $$FavoriteTemplatesTableOrderingComposer,
      $$FavoriteTemplatesTableAnnotationComposer,
      $$FavoriteTemplatesTableCreateCompanionBuilder,
      $$FavoriteTemplatesTableUpdateCompanionBuilder,
      (
        FavoriteTemplate,
        BaseReferences<
          _$AppDatabase,
          $FavoriteTemplatesTable,
          FavoriteTemplate
        >,
      ),
      FavoriteTemplate,
      PrefetchHooks Function()
    >;
typedef $$ReminderSettingsTableCreateCompanionBuilder =
    ReminderSettingsCompanion Function({
      Value<int> id,
      required bool isEnabled,
      required String reminderTimeLocal,
      required int thresholdPercent,
      required int activeWeekdaysMask,
      Value<String?> quietHoursStart,
      Value<String?> quietHoursEnd,
      required String permissionStatus,
      required DateTime updatedAt,
    });
typedef $$ReminderSettingsTableUpdateCompanionBuilder =
    ReminderSettingsCompanion Function({
      Value<int> id,
      Value<bool> isEnabled,
      Value<String> reminderTimeLocal,
      Value<int> thresholdPercent,
      Value<int> activeWeekdaysMask,
      Value<String?> quietHoursStart,
      Value<String?> quietHoursEnd,
      Value<String> permissionStatus,
      Value<DateTime> updatedAt,
    });

class $$ReminderSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTimeLocal => $composableBuilder(
    column: $table.reminderTimeLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get thresholdPercent => $composableBuilder(
    column: $table.thresholdPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeWeekdaysMask => $composableBuilder(
    column: $table.activeWeekdaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quietHoursStart => $composableBuilder(
    column: $table.quietHoursStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quietHoursEnd => $composableBuilder(
    column: $table.quietHoursEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get permissionStatus => $composableBuilder(
    column: $table.permissionStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReminderSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTimeLocal => $composableBuilder(
    column: $table.reminderTimeLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get thresholdPercent => $composableBuilder(
    column: $table.thresholdPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeWeekdaysMask => $composableBuilder(
    column: $table.activeWeekdaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quietHoursStart => $composableBuilder(
    column: $table.quietHoursStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quietHoursEnd => $composableBuilder(
    column: $table.quietHoursEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get permissionStatus => $composableBuilder(
    column: $table.permissionStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get reminderTimeLocal => $composableBuilder(
    column: $table.reminderTimeLocal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get thresholdPercent => $composableBuilder(
    column: $table.thresholdPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get activeWeekdaysMask => $composableBuilder(
    column: $table.activeWeekdaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quietHoursStart => $composableBuilder(
    column: $table.quietHoursStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quietHoursEnd => $composableBuilder(
    column: $table.quietHoursEnd,
    builder: (column) => column,
  );

  GeneratedColumn<String> get permissionStatus => $composableBuilder(
    column: $table.permissionStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ReminderSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderSettingsTable,
          ReminderSetting,
          $$ReminderSettingsTableFilterComposer,
          $$ReminderSettingsTableOrderingComposer,
          $$ReminderSettingsTableAnnotationComposer,
          $$ReminderSettingsTableCreateCompanionBuilder,
          $$ReminderSettingsTableUpdateCompanionBuilder,
          (
            ReminderSetting,
            BaseReferences<
              _$AppDatabase,
              $ReminderSettingsTable,
              ReminderSetting
            >,
          ),
          ReminderSetting,
          PrefetchHooks Function()
        > {
  $$ReminderSettingsTableTableManager(
    _$AppDatabase db,
    $ReminderSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<String> reminderTimeLocal = const Value.absent(),
                Value<int> thresholdPercent = const Value.absent(),
                Value<int> activeWeekdaysMask = const Value.absent(),
                Value<String?> quietHoursStart = const Value.absent(),
                Value<String?> quietHoursEnd = const Value.absent(),
                Value<String> permissionStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReminderSettingsCompanion(
                id: id,
                isEnabled: isEnabled,
                reminderTimeLocal: reminderTimeLocal,
                thresholdPercent: thresholdPercent,
                activeWeekdaysMask: activeWeekdaysMask,
                quietHoursStart: quietHoursStart,
                quietHoursEnd: quietHoursEnd,
                permissionStatus: permissionStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool isEnabled,
                required String reminderTimeLocal,
                required int thresholdPercent,
                required int activeWeekdaysMask,
                Value<String?> quietHoursStart = const Value.absent(),
                Value<String?> quietHoursEnd = const Value.absent(),
                required String permissionStatus,
                required DateTime updatedAt,
              }) => ReminderSettingsCompanion.insert(
                id: id,
                isEnabled: isEnabled,
                reminderTimeLocal: reminderTimeLocal,
                thresholdPercent: thresholdPercent,
                activeWeekdaysMask: activeWeekdaysMask,
                quietHoursStart: quietHoursStart,
                quietHoursEnd: quietHoursEnd,
                permissionStatus: permissionStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReminderSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderSettingsTable,
      ReminderSetting,
      $$ReminderSettingsTableFilterComposer,
      $$ReminderSettingsTableOrderingComposer,
      $$ReminderSettingsTableAnnotationComposer,
      $$ReminderSettingsTableCreateCompanionBuilder,
      $$ReminderSettingsTableUpdateCompanionBuilder,
      (
        ReminderSetting,
        BaseReferences<_$AppDatabase, $ReminderSettingsTable, ReminderSetting>,
      ),
      ReminderSetting,
      PrefetchHooks Function()
    >;
typedef $$NotificationEventsTableCreateCompanionBuilder =
    NotificationEventsCompanion Function({
      required String id,
      required String localDate,
      required int platformNotificationId,
      required DateTime scheduledFor,
      required String status,
      Value<DateTime?> openedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationEventsTableUpdateCompanionBuilder =
    NotificationEventsCompanion Function({
      Value<String> id,
      Value<String> localDate,
      Value<int> platformNotificationId,
      Value<DateTime> scheduledFor,
      Value<String> status,
      Value<DateTime?> openedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$NotificationEventsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationEventsTable> {
  $$NotificationEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationEventsTable> {
  $$NotificationEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationEventsTable> {
  $$NotificationEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationEventsTable,
          NotificationEvent,
          $$NotificationEventsTableFilterComposer,
          $$NotificationEventsTableOrderingComposer,
          $$NotificationEventsTableAnnotationComposer,
          $$NotificationEventsTableCreateCompanionBuilder,
          $$NotificationEventsTableUpdateCompanionBuilder,
          (
            NotificationEvent,
            BaseReferences<
              _$AppDatabase,
              $NotificationEventsTable,
              NotificationEvent
            >,
          ),
          NotificationEvent,
          PrefetchHooks Function()
        > {
  $$NotificationEventsTableTableManager(
    _$AppDatabase db,
    $NotificationEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<int> platformNotificationId = const Value.absent(),
                Value<DateTime> scheduledFor = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationEventsCompanion(
                id: id,
                localDate: localDate,
                platformNotificationId: platformNotificationId,
                scheduledFor: scheduledFor,
                status: status,
                openedAt: openedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localDate,
                required int platformNotificationId,
                required DateTime scheduledFor,
                required String status,
                Value<DateTime?> openedAt = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationEventsCompanion.insert(
                id: id,
                localDate: localDate,
                platformNotificationId: platformNotificationId,
                scheduledFor: scheduledFor,
                status: status,
                openedAt: openedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationEventsTable,
      NotificationEvent,
      $$NotificationEventsTableFilterComposer,
      $$NotificationEventsTableOrderingComposer,
      $$NotificationEventsTableAnnotationComposer,
      $$NotificationEventsTableCreateCompanionBuilder,
      $$NotificationEventsTableUpdateCompanionBuilder,
      (
        NotificationEvent,
        BaseReferences<
          _$AppDatabase,
          $NotificationEventsTable,
          NotificationEvent
        >,
      ),
      NotificationEvent,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$ApiKeyMetadataTableTableManager get apiKeyMetadata =>
      $$ApiKeyMetadataTableTableManager(_db, _db.apiKeyMetadata);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$DailyTargetsTableTableManager get dailyTargets =>
      $$DailyTargetsTableTableManager(_db, _db.dailyTargets);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db, _db.foodLogs);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db, _db.foodItems);
  $$ChatSessionsTableTableManager get chatSessions =>
      $$ChatSessionsTableTableManager(_db, _db.chatSessions);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$ApiKeyUsageEventsTableTableManager get apiKeyUsageEvents =>
      $$ApiKeyUsageEventsTableTableManager(_db, _db.apiKeyUsageEvents);
  $$FavoriteTemplatesTableTableManager get favoriteTemplates =>
      $$FavoriteTemplatesTableTableManager(_db, _db.favoriteTemplates);
  $$ReminderSettingsTableTableManager get reminderSettings =>
      $$ReminderSettingsTableTableManager(_db, _db.reminderSettings);
  $$NotificationEventsTableTableManager get notificationEvents =>
      $$NotificationEventsTableTableManager(_db, _db.notificationEvents);
}
