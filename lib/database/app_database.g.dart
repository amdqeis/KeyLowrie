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
  static const VerificationMeta _voiceDisclosureAcknowledgedMeta =
      const VerificationMeta('voiceDisclosureAcknowledged');
  @override
  late final GeneratedColumn<bool> voiceDisclosureAcknowledged =
      GeneratedColumn<bool>(
        'voice_disclosure_acknowledged',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("voice_disclosure_acknowledged" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
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
    voiceDisclosureAcknowledged,
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
    if (data.containsKey('voice_disclosure_acknowledged')) {
      context.handle(
        _voiceDisclosureAcknowledgedMeta,
        voiceDisclosureAcknowledged.isAcceptableOrUnknown(
          data['voice_disclosure_acknowledged']!,
          _voiceDisclosureAcknowledgedMeta,
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
      voiceDisclosureAcknowledged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}voice_disclosure_acknowledged'],
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
  final bool voiceDisclosureAcknowledged;
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
    required this.voiceDisclosureAcknowledged,
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
    map['voice_disclosure_acknowledged'] = Variable<bool>(
      voiceDisclosureAcknowledged,
    );
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
      voiceDisclosureAcknowledged: Value(voiceDisclosureAcknowledged),
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
      voiceDisclosureAcknowledged: serializer.fromJson<bool>(
        json['voiceDisclosureAcknowledged'],
      ),
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
      'voiceDisclosureAcknowledged': serializer.toJson<bool>(
        voiceDisclosureAcknowledged,
      ),
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
    bool? voiceDisclosureAcknowledged,
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
    voiceDisclosureAcknowledged:
        voiceDisclosureAcknowledged ?? this.voiceDisclosureAcknowledged,
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
      voiceDisclosureAcknowledged: data.voiceDisclosureAcknowledged.present
          ? data.voiceDisclosureAcknowledged.value
          : this.voiceDisclosureAcknowledged,
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
          ..write('voiceDisclosureAcknowledged: $voiceDisclosureAcknowledged, ')
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
    voiceDisclosureAcknowledged,
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
          other.voiceDisclosureAcknowledged ==
              this.voiceDisclosureAcknowledged &&
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
  final Value<bool> voiceDisclosureAcknowledged;
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
    this.voiceDisclosureAcknowledged = const Value.absent(),
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
    this.voiceDisclosureAcknowledged = const Value.absent(),
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
    Expression<bool>? voiceDisclosureAcknowledged,
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
      if (voiceDisclosureAcknowledged != null)
        'voice_disclosure_acknowledged': voiceDisclosureAcknowledged,
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
    Value<bool>? voiceDisclosureAcknowledged,
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
      voiceDisclosureAcknowledged:
          voiceDisclosureAcknowledged ?? this.voiceDisclosureAcknowledged,
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
    if (voiceDisclosureAcknowledged.present) {
      map['voice_disclosure_acknowledged'] = Variable<bool>(
        voiceDisclosureAcknowledged.value,
      );
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
          ..write('voiceDisclosureAcknowledged: $voiceDisclosureAcknowledged, ')
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

class $FinancialCategoriesTable extends FinancialCategories
    with TableInfo<$FinancialCategoriesTable, FinancialCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialCategoriesTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
    type,
    iconKey,
    isSystem,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialCategory> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {type, name},
  ];
  @override
  FinancialCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      ),
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
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
  $FinancialCategoriesTable createAlias(String alias) {
    return $FinancialCategoriesTable(attachedDatabase, alias);
  }
}

class FinancialCategory extends DataClass
    implements Insertable<FinancialCategory> {
  final String id;
  final String name;
  final String type;
  final String? iconKey;
  final bool isSystem;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FinancialCategory({
    required this.id,
    required this.name,
    required this.type,
    this.iconKey,
    required this.isSystem,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || iconKey != null) {
      map['icon_key'] = Variable<String>(iconKey);
    }
    map['is_system'] = Variable<bool>(isSystem);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FinancialCategoriesCompanion toCompanion(bool nullToAbsent) {
    return FinancialCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      iconKey: iconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(iconKey),
      isSystem: Value(isSystem),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FinancialCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialCategory(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      iconKey: serializer.fromJson<String?>(json['iconKey']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      isActive: serializer.fromJson<bool>(json['isActive']),
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
      'type': serializer.toJson<String>(type),
      'iconKey': serializer.toJson<String?>(iconKey),
      'isSystem': serializer.toJson<bool>(isSystem),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FinancialCategory copyWith({
    String? id,
    String? name,
    String? type,
    Value<String?> iconKey = const Value.absent(),
    bool? isSystem,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FinancialCategory(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    iconKey: iconKey.present ? iconKey.value : this.iconKey,
    isSystem: isSystem ?? this.isSystem,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FinancialCategory copyWithCompanion(FinancialCategoriesCompanion data) {
    return FinancialCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    iconKey,
    isSystem,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.iconKey == this.iconKey &&
          other.isSystem == this.isSystem &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FinancialCategoriesCompanion extends UpdateCompanion<FinancialCategory> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> iconKey;
  final Value<bool> isSystem;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FinancialCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialCategoriesCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.iconKey = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FinancialCategory> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? iconKey,
    Expression<bool>? isSystem,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (iconKey != null) 'icon_key': iconKey,
      if (isSystem != null) 'is_system': isSystem,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? iconKey,
    Value<bool>? isSystem,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FinancialCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      iconKey: iconKey ?? this.iconKey,
      isSystem: isSystem ?? this.isSystem,
      isActive: isActive ?? this.isActive,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
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
    return (StringBuffer('FinancialCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialPeriodsTable extends FinancialPeriods
    with TableInfo<$FinancialPeriodsTable, FinancialPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialPeriodsTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cycleStartDayMeta = const VerificationMeta(
    'cycleStartDay',
  );
  @override
  late final GeneratedColumn<int> cycleStartDay = GeneratedColumn<int>(
    'cycle_start_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _budgetAmountMeta = const VerificationMeta(
    'budgetAmount',
  );
  @override
  late final GeneratedColumn<int> budgetAmount = GeneratedColumn<int>(
    'budget_amount',
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
    name,
    startDate,
    endDate,
    cycleStartDay,
    budgetAmount,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialPeriod> instance, {
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
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('cycle_start_day')) {
      context.handle(
        _cycleStartDayMeta,
        cycleStartDay.isAcceptableOrUnknown(
          data['cycle_start_day']!,
          _cycleStartDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cycleStartDayMeta);
    }
    if (data.containsKey('budget_amount')) {
      context.handle(
        _budgetAmountMeta,
        budgetAmount.isAcceptableOrUnknown(
          data['budget_amount']!,
          _budgetAmountMeta,
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {startDate, endDate},
  ];
  @override
  FinancialPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialPeriod(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      cycleStartDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycle_start_day'],
      )!,
      budgetAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}budget_amount'],
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
  $FinancialPeriodsTable createAlias(String alias) {
    return $FinancialPeriodsTable(attachedDatabase, alias);
  }
}

class FinancialPeriod extends DataClass implements Insertable<FinancialPeriod> {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final int cycleStartDay;
  final int budgetAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FinancialPeriod({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.cycleStartDay,
    required this.budgetAmount,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['cycle_start_day'] = Variable<int>(cycleStartDay);
    map['budget_amount'] = Variable<int>(budgetAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FinancialPeriodsCompanion toCompanion(bool nullToAbsent) {
    return FinancialPeriodsCompanion(
      id: Value(id),
      name: Value(name),
      startDate: Value(startDate),
      endDate: Value(endDate),
      cycleStartDay: Value(cycleStartDay),
      budgetAmount: Value(budgetAmount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FinancialPeriod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialPeriod(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      cycleStartDay: serializer.fromJson<int>(json['cycleStartDay']),
      budgetAmount: serializer.fromJson<int>(json['budgetAmount']),
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
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'cycleStartDay': serializer.toJson<int>(cycleStartDay),
      'budgetAmount': serializer.toJson<int>(budgetAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FinancialPeriod copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    int? cycleStartDay,
    int? budgetAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FinancialPeriod(
    id: id ?? this.id,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    cycleStartDay: cycleStartDay ?? this.cycleStartDay,
    budgetAmount: budgetAmount ?? this.budgetAmount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FinancialPeriod copyWithCompanion(FinancialPeriodsCompanion data) {
    return FinancialPeriod(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      cycleStartDay: data.cycleStartDay.present
          ? data.cycleStartDay.value
          : this.cycleStartDay,
      budgetAmount: data.budgetAmount.present
          ? data.budgetAmount.value
          : this.budgetAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialPeriod(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('cycleStartDay: $cycleStartDay, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    startDate,
    endDate,
    cycleStartDay,
    budgetAmount,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialPeriod &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.cycleStartDay == this.cycleStartDay &&
          other.budgetAmount == this.budgetAmount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FinancialPeriodsCompanion extends UpdateCompanion<FinancialPeriod> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<int> cycleStartDay;
  final Value<int> budgetAmount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FinancialPeriodsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.cycleStartDay = const Value.absent(),
    this.budgetAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialPeriodsCompanion.insert({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required int cycleStartDay,
    this.budgetAmount = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       startDate = Value(startDate),
       endDate = Value(endDate),
       cycleStartDay = Value(cycleStartDay),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FinancialPeriod> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? cycleStartDay,
    Expression<int>? budgetAmount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (cycleStartDay != null) 'cycle_start_day': cycleStartDay,
      if (budgetAmount != null) 'budget_amount': budgetAmount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialPeriodsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<int>? cycleStartDay,
    Value<int>? budgetAmount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FinancialPeriodsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cycleStartDay: cycleStartDay ?? this.cycleStartDay,
      budgetAmount: budgetAmount ?? this.budgetAmount,
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
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (cycleStartDay.present) {
      map['cycle_start_day'] = Variable<int>(cycleStartDay.value);
    }
    if (budgetAmount.present) {
      map['budget_amount'] = Variable<int>(budgetAmount.value);
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
    return (StringBuffer('FinancialPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('cycleStartDay: $cycleStartDay, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialTransactionsTable extends FinancialTransactions
    with TableInfo<$FinancialTransactionsTable, FinancialTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IDR'),
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES financial_categories (id) ON DELETE RESTRICT',
    ),
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
  static const VerificationMeta _isReimburseMeta = const VerificationMeta(
    'isReimburse',
  );
  @override
  late final GeneratedColumn<bool> isReimburse = GeneratedColumn<bool>(
    'is_reimburse',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_reimburse" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _financialPeriodIdMeta = const VerificationMeta(
    'financialPeriodId',
  );
  @override
  late final GeneratedColumn<String> financialPeriodId =
      GeneratedColumn<String>(
        'financial_period_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES financial_periods (id) ON DELETE RESTRICT',
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
    type,
    name,
    amount,
    currencyCode,
    transactionDate,
    categoryId,
    notes,
    isReimburse,
    financialPeriodId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_reimburse')) {
      context.handle(
        _isReimburseMeta,
        isReimburse.isAcceptableOrUnknown(
          data['is_reimburse']!,
          _isReimburseMeta,
        ),
      );
    }
    if (data.containsKey('financial_period_id')) {
      context.handle(
        _financialPeriodIdMeta,
        financialPeriodId.isAcceptableOrUnknown(
          data['financial_period_id']!,
          _financialPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_financialPeriodIdMeta);
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
  FinancialTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isReimburse: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_reimburse'],
      )!,
      financialPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}financial_period_id'],
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
  $FinancialTransactionsTable createAlias(String alias) {
    return $FinancialTransactionsTable(attachedDatabase, alias);
  }
}

class FinancialTransaction extends DataClass
    implements Insertable<FinancialTransaction> {
  final String id;
  final String type;
  final String name;
  final int amount;
  final String currencyCode;
  final DateTime transactionDate;
  final String categoryId;
  final String? notes;
  final bool isReimburse;
  final String financialPeriodId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FinancialTransaction({
    required this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.currencyCode,
    required this.transactionDate,
    required this.categoryId,
    this.notes,
    required this.isReimburse,
    required this.financialPeriodId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['currency_code'] = Variable<String>(currencyCode);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_reimburse'] = Variable<bool>(isReimburse);
    map['financial_period_id'] = Variable<String>(financialPeriodId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FinancialTransactionsCompanion toCompanion(bool nullToAbsent) {
    return FinancialTransactionsCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      amount: Value(amount),
      currencyCode: Value(currencyCode),
      transactionDate: Value(transactionDate),
      categoryId: Value(categoryId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isReimburse: Value(isReimburse),
      financialPeriodId: Value(financialPeriodId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FinancialTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialTransaction(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      notes: serializer.fromJson<String?>(json['notes']),
      isReimburse: serializer.fromJson<bool>(json['isReimburse']),
      financialPeriodId: serializer.fromJson<String>(json['financialPeriodId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'categoryId': serializer.toJson<String>(categoryId),
      'notes': serializer.toJson<String?>(notes),
      'isReimburse': serializer.toJson<bool>(isReimburse),
      'financialPeriodId': serializer.toJson<String>(financialPeriodId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FinancialTransaction copyWith({
    String? id,
    String? type,
    String? name,
    int? amount,
    String? currencyCode,
    DateTime? transactionDate,
    String? categoryId,
    Value<String?> notes = const Value.absent(),
    bool? isReimburse,
    String? financialPeriodId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FinancialTransaction(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    currencyCode: currencyCode ?? this.currencyCode,
    transactionDate: transactionDate ?? this.transactionDate,
    categoryId: categoryId ?? this.categoryId,
    notes: notes.present ? notes.value : this.notes,
    isReimburse: isReimburse ?? this.isReimburse,
    financialPeriodId: financialPeriodId ?? this.financialPeriodId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FinancialTransaction copyWithCompanion(FinancialTransactionsCompanion data) {
    return FinancialTransaction(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      notes: data.notes.present ? data.notes.value : this.notes,
      isReimburse: data.isReimburse.present
          ? data.isReimburse.value
          : this.isReimburse,
      financialPeriodId: data.financialPeriodId.present
          ? data.financialPeriodId.value
          : this.financialPeriodId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialTransaction(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('notes: $notes, ')
          ..write('isReimburse: $isReimburse, ')
          ..write('financialPeriodId: $financialPeriodId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    name,
    amount,
    currencyCode,
    transactionDate,
    categoryId,
    notes,
    isReimburse,
    financialPeriodId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialTransaction &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.currencyCode == this.currencyCode &&
          other.transactionDate == this.transactionDate &&
          other.categoryId == this.categoryId &&
          other.notes == this.notes &&
          other.isReimburse == this.isReimburse &&
          other.financialPeriodId == this.financialPeriodId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FinancialTransactionsCompanion
    extends UpdateCompanion<FinancialTransaction> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> name;
  final Value<int> amount;
  final Value<String> currencyCode;
  final Value<DateTime> transactionDate;
  final Value<String> categoryId;
  final Value<String?> notes;
  final Value<bool> isReimburse;
  final Value<String> financialPeriodId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FinancialTransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.notes = const Value.absent(),
    this.isReimburse = const Value.absent(),
    this.financialPeriodId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialTransactionsCompanion.insert({
    required String id,
    required String type,
    required String name,
    required int amount,
    this.currencyCode = const Value.absent(),
    required DateTime transactionDate,
    required String categoryId,
    this.notes = const Value.absent(),
    this.isReimburse = const Value.absent(),
    required String financialPeriodId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       name = Value(name),
       amount = Value(amount),
       transactionDate = Value(transactionDate),
       categoryId = Value(categoryId),
       financialPeriodId = Value(financialPeriodId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FinancialTransaction> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<String>? currencyCode,
    Expression<DateTime>? transactionDate,
    Expression<String>? categoryId,
    Expression<String>? notes,
    Expression<bool>? isReimburse,
    Expression<String>? financialPeriodId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (categoryId != null) 'category_id': categoryId,
      if (notes != null) 'notes': notes,
      if (isReimburse != null) 'is_reimburse': isReimburse,
      if (financialPeriodId != null) 'financial_period_id': financialPeriodId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? name,
    Value<int>? amount,
    Value<String>? currencyCode,
    Value<DateTime>? transactionDate,
    Value<String>? categoryId,
    Value<String?>? notes,
    Value<bool>? isReimburse,
    Value<String>? financialPeriodId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FinancialTransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
      transactionDate: transactionDate ?? this.transactionDate,
      categoryId: categoryId ?? this.categoryId,
      notes: notes ?? this.notes,
      isReimburse: isReimburse ?? this.isReimburse,
      financialPeriodId: financialPeriodId ?? this.financialPeriodId,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isReimburse.present) {
      map['is_reimburse'] = Variable<bool>(isReimburse.value);
    }
    if (financialPeriodId.present) {
      map['financial_period_id'] = Variable<String>(financialPeriodId.value);
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
    return (StringBuffer('FinancialTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('notes: $notes, ')
          ..write('isReimburse: $isReimburse, ')
          ..write('financialPeriodId: $financialPeriodId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinanceSettingsTable extends FinanceSettings
    with TableInfo<$FinanceSettingsTable, FinanceSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinanceSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _cycleStartDayMeta = const VerificationMeta(
    'cycleStartDay',
  );
  @override
  late final GeneratedColumn<int> cycleStartDay = GeneratedColumn<int>(
    'cycle_start_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  static const VerificationMeta _defaultBudgetAmountMeta =
      const VerificationMeta('defaultBudgetAmount');
  @override
  late final GeneratedColumn<int> defaultBudgetAmount = GeneratedColumn<int>(
    'default_budget_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IDR'),
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
    cycleStartDay,
    defaultBudgetAmount,
    currencyCode,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'finance_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinanceSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cycle_start_day')) {
      context.handle(
        _cycleStartDayMeta,
        cycleStartDay.isAcceptableOrUnknown(
          data['cycle_start_day']!,
          _cycleStartDayMeta,
        ),
      );
    }
    if (data.containsKey('default_budget_amount')) {
      context.handle(
        _defaultBudgetAmountMeta,
        defaultBudgetAmount.isAcceptableOrUnknown(
          data['default_budget_amount']!,
          _defaultBudgetAmountMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
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
  FinanceSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinanceSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cycleStartDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycle_start_day'],
      )!,
      defaultBudgetAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_budget_amount'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FinanceSettingsTable createAlias(String alias) {
    return $FinanceSettingsTable(attachedDatabase, alias);
  }
}

class FinanceSetting extends DataClass implements Insertable<FinanceSetting> {
  final int id;
  final int cycleStartDay;
  final int defaultBudgetAmount;
  final String currencyCode;
  final DateTime updatedAt;
  const FinanceSetting({
    required this.id,
    required this.cycleStartDay,
    required this.defaultBudgetAmount,
    required this.currencyCode,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cycle_start_day'] = Variable<int>(cycleStartDay);
    map['default_budget_amount'] = Variable<int>(defaultBudgetAmount);
    map['currency_code'] = Variable<String>(currencyCode);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FinanceSettingsCompanion toCompanion(bool nullToAbsent) {
    return FinanceSettingsCompanion(
      id: Value(id),
      cycleStartDay: Value(cycleStartDay),
      defaultBudgetAmount: Value(defaultBudgetAmount),
      currencyCode: Value(currencyCode),
      updatedAt: Value(updatedAt),
    );
  }

  factory FinanceSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinanceSetting(
      id: serializer.fromJson<int>(json['id']),
      cycleStartDay: serializer.fromJson<int>(json['cycleStartDay']),
      defaultBudgetAmount: serializer.fromJson<int>(
        json['defaultBudgetAmount'],
      ),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cycleStartDay': serializer.toJson<int>(cycleStartDay),
      'defaultBudgetAmount': serializer.toJson<int>(defaultBudgetAmount),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FinanceSetting copyWith({
    int? id,
    int? cycleStartDay,
    int? defaultBudgetAmount,
    String? currencyCode,
    DateTime? updatedAt,
  }) => FinanceSetting(
    id: id ?? this.id,
    cycleStartDay: cycleStartDay ?? this.cycleStartDay,
    defaultBudgetAmount: defaultBudgetAmount ?? this.defaultBudgetAmount,
    currencyCode: currencyCode ?? this.currencyCode,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FinanceSetting copyWithCompanion(FinanceSettingsCompanion data) {
    return FinanceSetting(
      id: data.id.present ? data.id.value : this.id,
      cycleStartDay: data.cycleStartDay.present
          ? data.cycleStartDay.value
          : this.cycleStartDay,
      defaultBudgetAmount: data.defaultBudgetAmount.present
          ? data.defaultBudgetAmount.value
          : this.defaultBudgetAmount,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinanceSetting(')
          ..write('id: $id, ')
          ..write('cycleStartDay: $cycleStartDay, ')
          ..write('defaultBudgetAmount: $defaultBudgetAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cycleStartDay,
    defaultBudgetAmount,
    currencyCode,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinanceSetting &&
          other.id == this.id &&
          other.cycleStartDay == this.cycleStartDay &&
          other.defaultBudgetAmount == this.defaultBudgetAmount &&
          other.currencyCode == this.currencyCode &&
          other.updatedAt == this.updatedAt);
}

class FinanceSettingsCompanion extends UpdateCompanion<FinanceSetting> {
  final Value<int> id;
  final Value<int> cycleStartDay;
  final Value<int> defaultBudgetAmount;
  final Value<String> currencyCode;
  final Value<DateTime> updatedAt;
  const FinanceSettingsCompanion({
    this.id = const Value.absent(),
    this.cycleStartDay = const Value.absent(),
    this.defaultBudgetAmount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FinanceSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.cycleStartDay = const Value.absent(),
    this.defaultBudgetAmount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<FinanceSetting> custom({
    Expression<int>? id,
    Expression<int>? cycleStartDay,
    Expression<int>? defaultBudgetAmount,
    Expression<String>? currencyCode,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cycleStartDay != null) 'cycle_start_day': cycleStartDay,
      if (defaultBudgetAmount != null)
        'default_budget_amount': defaultBudgetAmount,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FinanceSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? cycleStartDay,
    Value<int>? defaultBudgetAmount,
    Value<String>? currencyCode,
    Value<DateTime>? updatedAt,
  }) {
    return FinanceSettingsCompanion(
      id: id ?? this.id,
      cycleStartDay: cycleStartDay ?? this.cycleStartDay,
      defaultBudgetAmount: defaultBudgetAmount ?? this.defaultBudgetAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cycleStartDay.present) {
      map['cycle_start_day'] = Variable<int>(cycleStartDay.value);
    }
    if (defaultBudgetAmount.present) {
      map['default_budget_amount'] = Variable<int>(defaultBudgetAmount.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinanceSettingsCompanion(')
          ..write('id: $id, ')
          ..write('cycleStartDay: $cycleStartDay, ')
          ..write('defaultBudgetAmount: $defaultBudgetAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ChatDraftsTable extends ChatDrafts
    with TableInfo<$ChatDraftsTable, ChatDraft> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatDraftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _draftTextMeta = const VerificationMeta(
    'draftText',
  );
  @override
  late final GeneratedColumn<String> draftText = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 4000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedModeMeta = const VerificationMeta(
    'selectedMode',
  );
  @override
  late final GeneratedColumn<String> selectedMode = GeneratedColumn<String>(
    'selected_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    draftText,
    selectedMode,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_drafts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatDraft> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _draftTextMeta,
        draftText.isAcceptableOrUnknown(data['text']!, _draftTextMeta),
      );
    } else if (isInserting) {
      context.missing(_draftTextMeta);
    }
    if (data.containsKey('selected_mode')) {
      context.handle(
        _selectedModeMeta,
        selectedMode.isAcceptableOrUnknown(
          data['selected_mode']!,
          _selectedModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selectedModeMeta);
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
  ChatDraft map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatDraft(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      draftText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      selectedMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_mode'],
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
  $ChatDraftsTable createAlias(String alias) {
    return $ChatDraftsTable(attachedDatabase, alias);
  }
}

class ChatDraft extends DataClass implements Insertable<ChatDraft> {
  final String id;
  final String draftText;
  final String selectedMode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChatDraft({
    required this.id,
    required this.draftText,
    required this.selectedMode,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['text'] = Variable<String>(draftText);
    map['selected_mode'] = Variable<String>(selectedMode);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChatDraftsCompanion toCompanion(bool nullToAbsent) {
    return ChatDraftsCompanion(
      id: Value(id),
      draftText: Value(draftText),
      selectedMode: Value(selectedMode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ChatDraft.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatDraft(
      id: serializer.fromJson<String>(json['id']),
      draftText: serializer.fromJson<String>(json['draftText']),
      selectedMode: serializer.fromJson<String>(json['selectedMode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'draftText': serializer.toJson<String>(draftText),
      'selectedMode': serializer.toJson<String>(selectedMode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ChatDraft copyWith({
    String? id,
    String? draftText,
    String? selectedMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ChatDraft(
    id: id ?? this.id,
    draftText: draftText ?? this.draftText,
    selectedMode: selectedMode ?? this.selectedMode,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ChatDraft copyWithCompanion(ChatDraftsCompanion data) {
    return ChatDraft(
      id: data.id.present ? data.id.value : this.id,
      draftText: data.draftText.present ? data.draftText.value : this.draftText,
      selectedMode: data.selectedMode.present
          ? data.selectedMode.value
          : this.selectedMode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatDraft(')
          ..write('id: $id, ')
          ..write('draftText: $draftText, ')
          ..write('selectedMode: $selectedMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, draftText, selectedMode, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatDraft &&
          other.id == this.id &&
          other.draftText == this.draftText &&
          other.selectedMode == this.selectedMode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChatDraftsCompanion extends UpdateCompanion<ChatDraft> {
  final Value<String> id;
  final Value<String> draftText;
  final Value<String> selectedMode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChatDraftsCompanion({
    this.id = const Value.absent(),
    this.draftText = const Value.absent(),
    this.selectedMode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatDraftsCompanion.insert({
    required String id,
    required String draftText,
    required String selectedMode,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       draftText = Value(draftText),
       selectedMode = Value(selectedMode),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ChatDraft> custom({
    Expression<String>? id,
    Expression<String>? draftText,
    Expression<String>? selectedMode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (draftText != null) 'text': draftText,
      if (selectedMode != null) 'selected_mode': selectedMode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatDraftsCompanion copyWith({
    Value<String>? id,
    Value<String>? draftText,
    Value<String>? selectedMode,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ChatDraftsCompanion(
      id: id ?? this.id,
      draftText: draftText ?? this.draftText,
      selectedMode: selectedMode ?? this.selectedMode,
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
    if (draftText.present) {
      map['text'] = Variable<String>(draftText.value);
    }
    if (selectedMode.present) {
      map['selected_mode'] = Variable<String>(selectedMode.value);
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
    return (StringBuffer('ChatDraftsCompanion(')
          ..write('id: $id, ')
          ..write('draftText: $draftText, ')
          ..write('selectedMode: $selectedMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleCategoriesTable extends ScheduleCategories
    with TableInfo<$ScheduleCategoriesTable, ScheduleCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleCategoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
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
    name,
    iconKey,
    isSystem,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleCategory> instance, {
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
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    } else if (isInserting) {
      context.missing(_isSystemMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
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
  ScheduleCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      ),
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
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
  $ScheduleCategoriesTable createAlias(String alias) {
    return $ScheduleCategoriesTable(attachedDatabase, alias);
  }
}

class ScheduleCategory extends DataClass
    implements Insertable<ScheduleCategory> {
  final String id;
  final String name;
  final String? iconKey;
  final bool isSystem;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ScheduleCategory({
    required this.id,
    required this.name,
    this.iconKey,
    required this.isSystem,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconKey != null) {
      map['icon_key'] = Variable<String>(iconKey);
    }
    map['is_system'] = Variable<bool>(isSystem);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ScheduleCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ScheduleCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconKey: iconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(iconKey),
      isSystem: Value(isSystem),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScheduleCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleCategory(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconKey: serializer.fromJson<String?>(json['iconKey']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      isActive: serializer.fromJson<bool>(json['isActive']),
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
      'iconKey': serializer.toJson<String?>(iconKey),
      'isSystem': serializer.toJson<bool>(isSystem),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ScheduleCategory copyWith({
    String? id,
    String? name,
    Value<String?> iconKey = const Value.absent(),
    bool? isSystem,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ScheduleCategory(
    id: id ?? this.id,
    name: name ?? this.name,
    iconKey: iconKey.present ? iconKey.value : this.iconKey,
    isSystem: isSystem ?? this.isSystem,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ScheduleCategory copyWithCompanion(ScheduleCategoriesCompanion data) {
    return ScheduleCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, iconKey, isSystem, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconKey == this.iconKey &&
          other.isSystem == this.isSystem &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScheduleCategoriesCompanion extends UpdateCompanion<ScheduleCategory> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> iconKey;
  final Value<bool> isSystem;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ScheduleCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleCategoriesCompanion.insert({
    required String id,
    required String name,
    this.iconKey = const Value.absent(),
    required bool isSystem,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       isSystem = Value(isSystem),
       isActive = Value(isActive),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScheduleCategory> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? iconKey,
    Expression<bool>? isSystem,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconKey != null) 'icon_key': iconKey,
      if (isSystem != null) 'is_system': isSystem,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? iconKey,
    Value<bool>? isSystem,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ScheduleCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      isSystem: isSystem ?? this.isSystem,
      isActive: isActive ?? this.isActive,
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
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
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
    return (StringBuffer('ScheduleCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('isSystem: $isSystem, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleItemsTable extends ScheduleItems
    with TableInfo<$ScheduleItemsTable, ScheduleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
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
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startAtUtcMeta = const VerificationMeta(
    'startAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> startAtUtc = GeneratedColumn<DateTime>(
    'start_at_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endAtUtcMeta = const VerificationMeta(
    'endAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> endAtUtc = GeneratedColumn<DateTime>(
    'end_at_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtUtcMeta = const VerificationMeta(
    'dueAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> dueAtUtc = GeneratedColumn<DateTime>(
    'due_at_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localStartDateMeta = const VerificationMeta(
    'localStartDate',
  );
  @override
  late final GeneratedColumn<String> localStartDate = GeneratedColumn<String>(
    'local_start_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localStartTimeMeta = const VerificationMeta(
    'localStartTime',
  );
  @override
  late final GeneratedColumn<String> localStartTime = GeneratedColumn<String>(
    'local_start_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localEndTimeMeta = const VerificationMeta(
    'localEndTime',
  );
  @override
  late final GeneratedColumn<String> localEndTime = GeneratedColumn<String>(
    'local_end_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateLocalMeta = const VerificationMeta(
    'dueDateLocal',
  );
  @override
  late final GeneratedColumn<String> dueDateLocal = GeneratedColumn<String>(
    'due_date_local',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES schedule_categories (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
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
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recurrenceTypeMeta = const VerificationMeta(
    'recurrenceType',
  );
  @override
  late final GeneratedColumn<String> recurrenceType = GeneratedColumn<String>(
    'recurrence_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recurrenceIntervalMeta =
      const VerificationMeta('recurrenceInterval');
  @override
  late final GeneratedColumn<int> recurrenceInterval = GeneratedColumn<int>(
    'recurrence_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _recurrenceWeekdaysJsonMeta =
      const VerificationMeta('recurrenceWeekdaysJson');
  @override
  late final GeneratedColumn<String> recurrenceWeekdaysJson =
      GeneratedColumn<String>(
        'recurrence_weekdays_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _recurrenceEndDateLocalMeta =
      const VerificationMeta('recurrenceEndDateLocal');
  @override
  late final GeneratedColumn<String> recurrenceEndDateLocal =
      GeneratedColumn<String>(
        'recurrence_end_date_local',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
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
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
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
    itemType,
    title,
    description,
    startAtUtc,
    endAtUtc,
    dueAtUtc,
    localStartDate,
    localStartTime,
    localEndTime,
    dueDateLocal,
    allDay,
    categoryId,
    priority,
    status,
    timezone,
    recurrenceType,
    recurrenceInterval,
    recurrenceWeekdaysJson,
    recurrenceEndDateLocal,
    source,
    originalUserText,
    completedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_at_utc')) {
      context.handle(
        _startAtUtcMeta,
        startAtUtc.isAcceptableOrUnknown(
          data['start_at_utc']!,
          _startAtUtcMeta,
        ),
      );
    }
    if (data.containsKey('end_at_utc')) {
      context.handle(
        _endAtUtcMeta,
        endAtUtc.isAcceptableOrUnknown(data['end_at_utc']!, _endAtUtcMeta),
      );
    }
    if (data.containsKey('due_at_utc')) {
      context.handle(
        _dueAtUtcMeta,
        dueAtUtc.isAcceptableOrUnknown(data['due_at_utc']!, _dueAtUtcMeta),
      );
    }
    if (data.containsKey('local_start_date')) {
      context.handle(
        _localStartDateMeta,
        localStartDate.isAcceptableOrUnknown(
          data['local_start_date']!,
          _localStartDateMeta,
        ),
      );
    }
    if (data.containsKey('local_start_time')) {
      context.handle(
        _localStartTimeMeta,
        localStartTime.isAcceptableOrUnknown(
          data['local_start_time']!,
          _localStartTimeMeta,
        ),
      );
    }
    if (data.containsKey('local_end_time')) {
      context.handle(
        _localEndTimeMeta,
        localEndTime.isAcceptableOrUnknown(
          data['local_end_time']!,
          _localEndTimeMeta,
        ),
      );
    }
    if (data.containsKey('due_date_local')) {
      context.handle(
        _dueDateLocalMeta,
        dueDateLocal.isAcceptableOrUnknown(
          data['due_date_local']!,
          _dueDateLocalMeta,
        ),
      );
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    } else if (isInserting) {
      context.missing(_allDayMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('recurrence_type')) {
      context.handle(
        _recurrenceTypeMeta,
        recurrenceType.isAcceptableOrUnknown(
          data['recurrence_type']!,
          _recurrenceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recurrenceTypeMeta);
    }
    if (data.containsKey('recurrence_interval')) {
      context.handle(
        _recurrenceIntervalMeta,
        recurrenceInterval.isAcceptableOrUnknown(
          data['recurrence_interval']!,
          _recurrenceIntervalMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_weekdays_json')) {
      context.handle(
        _recurrenceWeekdaysJsonMeta,
        recurrenceWeekdaysJson.isAcceptableOrUnknown(
          data['recurrence_weekdays_json']!,
          _recurrenceWeekdaysJsonMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_end_date_local')) {
      context.handle(
        _recurrenceEndDateLocalMeta,
        recurrenceEndDateLocal.isAcceptableOrUnknown(
          data['recurrence_end_date_local']!,
          _recurrenceEndDateLocalMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
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
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
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
  ScheduleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      startAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at_utc'],
      ),
      endAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at_utc'],
      ),
      dueAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at_utc'],
      ),
      localStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_start_date'],
      ),
      localStartTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_start_time'],
      ),
      localEndTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_end_time'],
      ),
      dueDateLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date_local'],
      ),
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      recurrenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_type'],
      )!,
      recurrenceInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recurrence_interval'],
      )!,
      recurrenceWeekdaysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_weekdays_json'],
      ),
      recurrenceEndDateLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_end_date_local'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      originalUserText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_user_text'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
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
  $ScheduleItemsTable createAlias(String alias) {
    return $ScheduleItemsTable(attachedDatabase, alias);
  }
}

class ScheduleItem extends DataClass implements Insertable<ScheduleItem> {
  final String id;
  final String itemType;
  final String title;
  final String? description;
  final DateTime? startAtUtc;
  final DateTime? endAtUtc;
  final DateTime? dueAtUtc;
  final String? localStartDate;
  final String? localStartTime;
  final String? localEndTime;
  final String? dueDateLocal;
  final bool allDay;
  final String categoryId;
  final String priority;
  final String status;
  final String timezone;
  final String recurrenceType;
  final int recurrenceInterval;
  final String? recurrenceWeekdaysJson;
  final String? recurrenceEndDateLocal;
  final String source;
  final String? originalUserText;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ScheduleItem({
    required this.id,
    required this.itemType,
    required this.title,
    this.description,
    this.startAtUtc,
    this.endAtUtc,
    this.dueAtUtc,
    this.localStartDate,
    this.localStartTime,
    this.localEndTime,
    this.dueDateLocal,
    required this.allDay,
    required this.categoryId,
    required this.priority,
    required this.status,
    required this.timezone,
    required this.recurrenceType,
    required this.recurrenceInterval,
    this.recurrenceWeekdaysJson,
    this.recurrenceEndDateLocal,
    required this.source,
    this.originalUserText,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_type'] = Variable<String>(itemType);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || startAtUtc != null) {
      map['start_at_utc'] = Variable<DateTime>(startAtUtc);
    }
    if (!nullToAbsent || endAtUtc != null) {
      map['end_at_utc'] = Variable<DateTime>(endAtUtc);
    }
    if (!nullToAbsent || dueAtUtc != null) {
      map['due_at_utc'] = Variable<DateTime>(dueAtUtc);
    }
    if (!nullToAbsent || localStartDate != null) {
      map['local_start_date'] = Variable<String>(localStartDate);
    }
    if (!nullToAbsent || localStartTime != null) {
      map['local_start_time'] = Variable<String>(localStartTime);
    }
    if (!nullToAbsent || localEndTime != null) {
      map['local_end_time'] = Variable<String>(localEndTime);
    }
    if (!nullToAbsent || dueDateLocal != null) {
      map['due_date_local'] = Variable<String>(dueDateLocal);
    }
    map['all_day'] = Variable<bool>(allDay);
    map['category_id'] = Variable<String>(categoryId);
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    map['timezone'] = Variable<String>(timezone);
    map['recurrence_type'] = Variable<String>(recurrenceType);
    map['recurrence_interval'] = Variable<int>(recurrenceInterval);
    if (!nullToAbsent || recurrenceWeekdaysJson != null) {
      map['recurrence_weekdays_json'] = Variable<String>(
        recurrenceWeekdaysJson,
      );
    }
    if (!nullToAbsent || recurrenceEndDateLocal != null) {
      map['recurrence_end_date_local'] = Variable<String>(
        recurrenceEndDateLocal,
      );
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || originalUserText != null) {
      map['original_user_text'] = Variable<String>(originalUserText);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ScheduleItemsCompanion toCompanion(bool nullToAbsent) {
    return ScheduleItemsCompanion(
      id: Value(id),
      itemType: Value(itemType),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startAtUtc: startAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(startAtUtc),
      endAtUtc: endAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(endAtUtc),
      dueAtUtc: dueAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAtUtc),
      localStartDate: localStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(localStartDate),
      localStartTime: localStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(localStartTime),
      localEndTime: localEndTime == null && nullToAbsent
          ? const Value.absent()
          : Value(localEndTime),
      dueDateLocal: dueDateLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDateLocal),
      allDay: Value(allDay),
      categoryId: Value(categoryId),
      priority: Value(priority),
      status: Value(status),
      timezone: Value(timezone),
      recurrenceType: Value(recurrenceType),
      recurrenceInterval: Value(recurrenceInterval),
      recurrenceWeekdaysJson: recurrenceWeekdaysJson == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceWeekdaysJson),
      recurrenceEndDateLocal: recurrenceEndDateLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceEndDateLocal),
      source: Value(source),
      originalUserText: originalUserText == null && nullToAbsent
          ? const Value.absent()
          : Value(originalUserText),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScheduleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleItem(
      id: serializer.fromJson<String>(json['id']),
      itemType: serializer.fromJson<String>(json['itemType']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      startAtUtc: serializer.fromJson<DateTime?>(json['startAtUtc']),
      endAtUtc: serializer.fromJson<DateTime?>(json['endAtUtc']),
      dueAtUtc: serializer.fromJson<DateTime?>(json['dueAtUtc']),
      localStartDate: serializer.fromJson<String?>(json['localStartDate']),
      localStartTime: serializer.fromJson<String?>(json['localStartTime']),
      localEndTime: serializer.fromJson<String?>(json['localEndTime']),
      dueDateLocal: serializer.fromJson<String?>(json['dueDateLocal']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      timezone: serializer.fromJson<String>(json['timezone']),
      recurrenceType: serializer.fromJson<String>(json['recurrenceType']),
      recurrenceInterval: serializer.fromJson<int>(json['recurrenceInterval']),
      recurrenceWeekdaysJson: serializer.fromJson<String?>(
        json['recurrenceWeekdaysJson'],
      ),
      recurrenceEndDateLocal: serializer.fromJson<String?>(
        json['recurrenceEndDateLocal'],
      ),
      source: serializer.fromJson<String>(json['source']),
      originalUserText: serializer.fromJson<String?>(json['originalUserText']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemType': serializer.toJson<String>(itemType),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'startAtUtc': serializer.toJson<DateTime?>(startAtUtc),
      'endAtUtc': serializer.toJson<DateTime?>(endAtUtc),
      'dueAtUtc': serializer.toJson<DateTime?>(dueAtUtc),
      'localStartDate': serializer.toJson<String?>(localStartDate),
      'localStartTime': serializer.toJson<String?>(localStartTime),
      'localEndTime': serializer.toJson<String?>(localEndTime),
      'dueDateLocal': serializer.toJson<String?>(dueDateLocal),
      'allDay': serializer.toJson<bool>(allDay),
      'categoryId': serializer.toJson<String>(categoryId),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
      'timezone': serializer.toJson<String>(timezone),
      'recurrenceType': serializer.toJson<String>(recurrenceType),
      'recurrenceInterval': serializer.toJson<int>(recurrenceInterval),
      'recurrenceWeekdaysJson': serializer.toJson<String?>(
        recurrenceWeekdaysJson,
      ),
      'recurrenceEndDateLocal': serializer.toJson<String?>(
        recurrenceEndDateLocal,
      ),
      'source': serializer.toJson<String>(source),
      'originalUserText': serializer.toJson<String?>(originalUserText),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ScheduleItem copyWith({
    String? id,
    String? itemType,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<DateTime?> startAtUtc = const Value.absent(),
    Value<DateTime?> endAtUtc = const Value.absent(),
    Value<DateTime?> dueAtUtc = const Value.absent(),
    Value<String?> localStartDate = const Value.absent(),
    Value<String?> localStartTime = const Value.absent(),
    Value<String?> localEndTime = const Value.absent(),
    Value<String?> dueDateLocal = const Value.absent(),
    bool? allDay,
    String? categoryId,
    String? priority,
    String? status,
    String? timezone,
    String? recurrenceType,
    int? recurrenceInterval,
    Value<String?> recurrenceWeekdaysJson = const Value.absent(),
    Value<String?> recurrenceEndDateLocal = const Value.absent(),
    String? source,
    Value<String?> originalUserText = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ScheduleItem(
    id: id ?? this.id,
    itemType: itemType ?? this.itemType,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    startAtUtc: startAtUtc.present ? startAtUtc.value : this.startAtUtc,
    endAtUtc: endAtUtc.present ? endAtUtc.value : this.endAtUtc,
    dueAtUtc: dueAtUtc.present ? dueAtUtc.value : this.dueAtUtc,
    localStartDate: localStartDate.present
        ? localStartDate.value
        : this.localStartDate,
    localStartTime: localStartTime.present
        ? localStartTime.value
        : this.localStartTime,
    localEndTime: localEndTime.present ? localEndTime.value : this.localEndTime,
    dueDateLocal: dueDateLocal.present ? dueDateLocal.value : this.dueDateLocal,
    allDay: allDay ?? this.allDay,
    categoryId: categoryId ?? this.categoryId,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    timezone: timezone ?? this.timezone,
    recurrenceType: recurrenceType ?? this.recurrenceType,
    recurrenceInterval: recurrenceInterval ?? this.recurrenceInterval,
    recurrenceWeekdaysJson: recurrenceWeekdaysJson.present
        ? recurrenceWeekdaysJson.value
        : this.recurrenceWeekdaysJson,
    recurrenceEndDateLocal: recurrenceEndDateLocal.present
        ? recurrenceEndDateLocal.value
        : this.recurrenceEndDateLocal,
    source: source ?? this.source,
    originalUserText: originalUserText.present
        ? originalUserText.value
        : this.originalUserText,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ScheduleItem copyWithCompanion(ScheduleItemsCompanion data) {
    return ScheduleItem(
      id: data.id.present ? data.id.value : this.id,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      startAtUtc: data.startAtUtc.present
          ? data.startAtUtc.value
          : this.startAtUtc,
      endAtUtc: data.endAtUtc.present ? data.endAtUtc.value : this.endAtUtc,
      dueAtUtc: data.dueAtUtc.present ? data.dueAtUtc.value : this.dueAtUtc,
      localStartDate: data.localStartDate.present
          ? data.localStartDate.value
          : this.localStartDate,
      localStartTime: data.localStartTime.present
          ? data.localStartTime.value
          : this.localStartTime,
      localEndTime: data.localEndTime.present
          ? data.localEndTime.value
          : this.localEndTime,
      dueDateLocal: data.dueDateLocal.present
          ? data.dueDateLocal.value
          : this.dueDateLocal,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      recurrenceType: data.recurrenceType.present
          ? data.recurrenceType.value
          : this.recurrenceType,
      recurrenceInterval: data.recurrenceInterval.present
          ? data.recurrenceInterval.value
          : this.recurrenceInterval,
      recurrenceWeekdaysJson: data.recurrenceWeekdaysJson.present
          ? data.recurrenceWeekdaysJson.value
          : this.recurrenceWeekdaysJson,
      recurrenceEndDateLocal: data.recurrenceEndDateLocal.present
          ? data.recurrenceEndDateLocal.value
          : this.recurrenceEndDateLocal,
      source: data.source.present ? data.source.value : this.source,
      originalUserText: data.originalUserText.present
          ? data.originalUserText.value
          : this.originalUserText,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleItem(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startAtUtc: $startAtUtc, ')
          ..write('endAtUtc: $endAtUtc, ')
          ..write('dueAtUtc: $dueAtUtc, ')
          ..write('localStartDate: $localStartDate, ')
          ..write('localStartTime: $localStartTime, ')
          ..write('localEndTime: $localEndTime, ')
          ..write('dueDateLocal: $dueDateLocal, ')
          ..write('allDay: $allDay, ')
          ..write('categoryId: $categoryId, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('timezone: $timezone, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceInterval: $recurrenceInterval, ')
          ..write('recurrenceWeekdaysJson: $recurrenceWeekdaysJson, ')
          ..write('recurrenceEndDateLocal: $recurrenceEndDateLocal, ')
          ..write('source: $source, ')
          ..write('originalUserText: $originalUserText, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    itemType,
    title,
    description,
    startAtUtc,
    endAtUtc,
    dueAtUtc,
    localStartDate,
    localStartTime,
    localEndTime,
    dueDateLocal,
    allDay,
    categoryId,
    priority,
    status,
    timezone,
    recurrenceType,
    recurrenceInterval,
    recurrenceWeekdaysJson,
    recurrenceEndDateLocal,
    source,
    originalUserText,
    completedAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleItem &&
          other.id == this.id &&
          other.itemType == this.itemType &&
          other.title == this.title &&
          other.description == this.description &&
          other.startAtUtc == this.startAtUtc &&
          other.endAtUtc == this.endAtUtc &&
          other.dueAtUtc == this.dueAtUtc &&
          other.localStartDate == this.localStartDate &&
          other.localStartTime == this.localStartTime &&
          other.localEndTime == this.localEndTime &&
          other.dueDateLocal == this.dueDateLocal &&
          other.allDay == this.allDay &&
          other.categoryId == this.categoryId &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.timezone == this.timezone &&
          other.recurrenceType == this.recurrenceType &&
          other.recurrenceInterval == this.recurrenceInterval &&
          other.recurrenceWeekdaysJson == this.recurrenceWeekdaysJson &&
          other.recurrenceEndDateLocal == this.recurrenceEndDateLocal &&
          other.source == this.source &&
          other.originalUserText == this.originalUserText &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScheduleItemsCompanion extends UpdateCompanion<ScheduleItem> {
  final Value<String> id;
  final Value<String> itemType;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> startAtUtc;
  final Value<DateTime?> endAtUtc;
  final Value<DateTime?> dueAtUtc;
  final Value<String?> localStartDate;
  final Value<String?> localStartTime;
  final Value<String?> localEndTime;
  final Value<String?> dueDateLocal;
  final Value<bool> allDay;
  final Value<String> categoryId;
  final Value<String> priority;
  final Value<String> status;
  final Value<String> timezone;
  final Value<String> recurrenceType;
  final Value<int> recurrenceInterval;
  final Value<String?> recurrenceWeekdaysJson;
  final Value<String?> recurrenceEndDateLocal;
  final Value<String> source;
  final Value<String?> originalUserText;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ScheduleItemsCompanion({
    this.id = const Value.absent(),
    this.itemType = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.startAtUtc = const Value.absent(),
    this.endAtUtc = const Value.absent(),
    this.dueAtUtc = const Value.absent(),
    this.localStartDate = const Value.absent(),
    this.localStartTime = const Value.absent(),
    this.localEndTime = const Value.absent(),
    this.dueDateLocal = const Value.absent(),
    this.allDay = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.timezone = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceInterval = const Value.absent(),
    this.recurrenceWeekdaysJson = const Value.absent(),
    this.recurrenceEndDateLocal = const Value.absent(),
    this.source = const Value.absent(),
    this.originalUserText = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleItemsCompanion.insert({
    required String id,
    required String itemType,
    required String title,
    this.description = const Value.absent(),
    this.startAtUtc = const Value.absent(),
    this.endAtUtc = const Value.absent(),
    this.dueAtUtc = const Value.absent(),
    this.localStartDate = const Value.absent(),
    this.localStartTime = const Value.absent(),
    this.localEndTime = const Value.absent(),
    this.dueDateLocal = const Value.absent(),
    required bool allDay,
    required String categoryId,
    required String priority,
    required String status,
    required String timezone,
    required String recurrenceType,
    this.recurrenceInterval = const Value.absent(),
    this.recurrenceWeekdaysJson = const Value.absent(),
    this.recurrenceEndDateLocal = const Value.absent(),
    this.source = const Value.absent(),
    this.originalUserText = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemType = Value(itemType),
       title = Value(title),
       allDay = Value(allDay),
       categoryId = Value(categoryId),
       priority = Value(priority),
       status = Value(status),
       timezone = Value(timezone),
       recurrenceType = Value(recurrenceType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScheduleItem> custom({
    Expression<String>? id,
    Expression<String>? itemType,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? startAtUtc,
    Expression<DateTime>? endAtUtc,
    Expression<DateTime>? dueAtUtc,
    Expression<String>? localStartDate,
    Expression<String>? localStartTime,
    Expression<String>? localEndTime,
    Expression<String>? dueDateLocal,
    Expression<bool>? allDay,
    Expression<String>? categoryId,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<String>? timezone,
    Expression<String>? recurrenceType,
    Expression<int>? recurrenceInterval,
    Expression<String>? recurrenceWeekdaysJson,
    Expression<String>? recurrenceEndDateLocal,
    Expression<String>? source,
    Expression<String>? originalUserText,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemType != null) 'item_type': itemType,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (startAtUtc != null) 'start_at_utc': startAtUtc,
      if (endAtUtc != null) 'end_at_utc': endAtUtc,
      if (dueAtUtc != null) 'due_at_utc': dueAtUtc,
      if (localStartDate != null) 'local_start_date': localStartDate,
      if (localStartTime != null) 'local_start_time': localStartTime,
      if (localEndTime != null) 'local_end_time': localEndTime,
      if (dueDateLocal != null) 'due_date_local': dueDateLocal,
      if (allDay != null) 'all_day': allDay,
      if (categoryId != null) 'category_id': categoryId,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (timezone != null) 'timezone': timezone,
      if (recurrenceType != null) 'recurrence_type': recurrenceType,
      if (recurrenceInterval != null) 'recurrence_interval': recurrenceInterval,
      if (recurrenceWeekdaysJson != null)
        'recurrence_weekdays_json': recurrenceWeekdaysJson,
      if (recurrenceEndDateLocal != null)
        'recurrence_end_date_local': recurrenceEndDateLocal,
      if (source != null) 'source': source,
      if (originalUserText != null) 'original_user_text': originalUserText,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemType,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime?>? startAtUtc,
    Value<DateTime?>? endAtUtc,
    Value<DateTime?>? dueAtUtc,
    Value<String?>? localStartDate,
    Value<String?>? localStartTime,
    Value<String?>? localEndTime,
    Value<String?>? dueDateLocal,
    Value<bool>? allDay,
    Value<String>? categoryId,
    Value<String>? priority,
    Value<String>? status,
    Value<String>? timezone,
    Value<String>? recurrenceType,
    Value<int>? recurrenceInterval,
    Value<String?>? recurrenceWeekdaysJson,
    Value<String?>? recurrenceEndDateLocal,
    Value<String>? source,
    Value<String?>? originalUserText,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ScheduleItemsCompanion(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      title: title ?? this.title,
      description: description ?? this.description,
      startAtUtc: startAtUtc ?? this.startAtUtc,
      endAtUtc: endAtUtc ?? this.endAtUtc,
      dueAtUtc: dueAtUtc ?? this.dueAtUtc,
      localStartDate: localStartDate ?? this.localStartDate,
      localStartTime: localStartTime ?? this.localStartTime,
      localEndTime: localEndTime ?? this.localEndTime,
      dueDateLocal: dueDateLocal ?? this.dueDateLocal,
      allDay: allDay ?? this.allDay,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      timezone: timezone ?? this.timezone,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurrenceInterval: recurrenceInterval ?? this.recurrenceInterval,
      recurrenceWeekdaysJson:
          recurrenceWeekdaysJson ?? this.recurrenceWeekdaysJson,
      recurrenceEndDateLocal:
          recurrenceEndDateLocal ?? this.recurrenceEndDateLocal,
      source: source ?? this.source,
      originalUserText: originalUserText ?? this.originalUserText,
      completedAt: completedAt ?? this.completedAt,
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
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startAtUtc.present) {
      map['start_at_utc'] = Variable<DateTime>(startAtUtc.value);
    }
    if (endAtUtc.present) {
      map['end_at_utc'] = Variable<DateTime>(endAtUtc.value);
    }
    if (dueAtUtc.present) {
      map['due_at_utc'] = Variable<DateTime>(dueAtUtc.value);
    }
    if (localStartDate.present) {
      map['local_start_date'] = Variable<String>(localStartDate.value);
    }
    if (localStartTime.present) {
      map['local_start_time'] = Variable<String>(localStartTime.value);
    }
    if (localEndTime.present) {
      map['local_end_time'] = Variable<String>(localEndTime.value);
    }
    if (dueDateLocal.present) {
      map['due_date_local'] = Variable<String>(dueDateLocal.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (recurrenceType.present) {
      map['recurrence_type'] = Variable<String>(recurrenceType.value);
    }
    if (recurrenceInterval.present) {
      map['recurrence_interval'] = Variable<int>(recurrenceInterval.value);
    }
    if (recurrenceWeekdaysJson.present) {
      map['recurrence_weekdays_json'] = Variable<String>(
        recurrenceWeekdaysJson.value,
      );
    }
    if (recurrenceEndDateLocal.present) {
      map['recurrence_end_date_local'] = Variable<String>(
        recurrenceEndDateLocal.value,
      );
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (originalUserText.present) {
      map['original_user_text'] = Variable<String>(originalUserText.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
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
    return (StringBuffer('ScheduleItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startAtUtc: $startAtUtc, ')
          ..write('endAtUtc: $endAtUtc, ')
          ..write('dueAtUtc: $dueAtUtc, ')
          ..write('localStartDate: $localStartDate, ')
          ..write('localStartTime: $localStartTime, ')
          ..write('localEndTime: $localEndTime, ')
          ..write('dueDateLocal: $dueDateLocal, ')
          ..write('allDay: $allDay, ')
          ..write('categoryId: $categoryId, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('timezone: $timezone, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceInterval: $recurrenceInterval, ')
          ..write('recurrenceWeekdaysJson: $recurrenceWeekdaysJson, ')
          ..write('recurrenceEndDateLocal: $recurrenceEndDateLocal, ')
          ..write('source: $source, ')
          ..write('originalUserText: $originalUserText, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleRemindersTable extends ScheduleReminders
    with TableInfo<$ScheduleRemindersTable, ScheduleReminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleRemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleItemIdMeta = const VerificationMeta(
    'scheduleItemId',
  );
  @override
  late final GeneratedColumn<String> scheduleItemId = GeneratedColumn<String>(
    'schedule_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES schedule_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _offsetMinutesMeta = const VerificationMeta(
    'offsetMinutes',
  );
  @override
  late final GeneratedColumn<int> offsetMinutes = GeneratedColumn<int>(
    'offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    scheduleItemId,
    offsetMinutes,
    isEnabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleReminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('schedule_item_id')) {
      context.handle(
        _scheduleItemIdMeta,
        scheduleItemId.isAcceptableOrUnknown(
          data['schedule_item_id']!,
          _scheduleItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleItemIdMeta);
    }
    if (data.containsKey('offset_minutes')) {
      context.handle(
        _offsetMinutesMeta,
        offsetMinutes.isAcceptableOrUnknown(
          data['offset_minutes']!,
          _offsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_offsetMinutesMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    } else if (isInserting) {
      context.missing(_isEnabledMeta);
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
  ScheduleReminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleReminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      scheduleItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_item_id'],
      )!,
      offsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offset_minutes'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
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
  $ScheduleRemindersTable createAlias(String alias) {
    return $ScheduleRemindersTable(attachedDatabase, alias);
  }
}

class ScheduleReminder extends DataClass
    implements Insertable<ScheduleReminder> {
  final String id;
  final String scheduleItemId;
  final int offsetMinutes;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ScheduleReminder({
    required this.id,
    required this.scheduleItemId,
    required this.offsetMinutes,
    required this.isEnabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['schedule_item_id'] = Variable<String>(scheduleItemId);
    map['offset_minutes'] = Variable<int>(offsetMinutes);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ScheduleRemindersCompanion toCompanion(bool nullToAbsent) {
    return ScheduleRemindersCompanion(
      id: Value(id),
      scheduleItemId: Value(scheduleItemId),
      offsetMinutes: Value(offsetMinutes),
      isEnabled: Value(isEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScheduleReminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleReminder(
      id: serializer.fromJson<String>(json['id']),
      scheduleItemId: serializer.fromJson<String>(json['scheduleItemId']),
      offsetMinutes: serializer.fromJson<int>(json['offsetMinutes']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'scheduleItemId': serializer.toJson<String>(scheduleItemId),
      'offsetMinutes': serializer.toJson<int>(offsetMinutes),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ScheduleReminder copyWith({
    String? id,
    String? scheduleItemId,
    int? offsetMinutes,
    bool? isEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ScheduleReminder(
    id: id ?? this.id,
    scheduleItemId: scheduleItemId ?? this.scheduleItemId,
    offsetMinutes: offsetMinutes ?? this.offsetMinutes,
    isEnabled: isEnabled ?? this.isEnabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ScheduleReminder copyWithCompanion(ScheduleRemindersCompanion data) {
    return ScheduleReminder(
      id: data.id.present ? data.id.value : this.id,
      scheduleItemId: data.scheduleItemId.present
          ? data.scheduleItemId.value
          : this.scheduleItemId,
      offsetMinutes: data.offsetMinutes.present
          ? data.offsetMinutes.value
          : this.offsetMinutes,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleReminder(')
          ..write('id: $id, ')
          ..write('scheduleItemId: $scheduleItemId, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scheduleItemId,
    offsetMinutes,
    isEnabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleReminder &&
          other.id == this.id &&
          other.scheduleItemId == this.scheduleItemId &&
          other.offsetMinutes == this.offsetMinutes &&
          other.isEnabled == this.isEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScheduleRemindersCompanion extends UpdateCompanion<ScheduleReminder> {
  final Value<String> id;
  final Value<String> scheduleItemId;
  final Value<int> offsetMinutes;
  final Value<bool> isEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ScheduleRemindersCompanion({
    this.id = const Value.absent(),
    this.scheduleItemId = const Value.absent(),
    this.offsetMinutes = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleRemindersCompanion.insert({
    required String id,
    required String scheduleItemId,
    required int offsetMinutes,
    required bool isEnabled,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       scheduleItemId = Value(scheduleItemId),
       offsetMinutes = Value(offsetMinutes),
       isEnabled = Value(isEnabled),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScheduleReminder> custom({
    Expression<String>? id,
    Expression<String>? scheduleItemId,
    Expression<int>? offsetMinutes,
    Expression<bool>? isEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleItemId != null) 'schedule_item_id': scheduleItemId,
      if (offsetMinutes != null) 'offset_minutes': offsetMinutes,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleRemindersCompanion copyWith({
    Value<String>? id,
    Value<String>? scheduleItemId,
    Value<int>? offsetMinutes,
    Value<bool>? isEnabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ScheduleRemindersCompanion(
      id: id ?? this.id,
      scheduleItemId: scheduleItemId ?? this.scheduleItemId,
      offsetMinutes: offsetMinutes ?? this.offsetMinutes,
      isEnabled: isEnabled ?? this.isEnabled,
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
    if (scheduleItemId.present) {
      map['schedule_item_id'] = Variable<String>(scheduleItemId.value);
    }
    if (offsetMinutes.present) {
      map['offset_minutes'] = Variable<int>(offsetMinutes.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
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
    return (StringBuffer('ScheduleRemindersCompanion(')
          ..write('id: $id, ')
          ..write('scheduleItemId: $scheduleItemId, ')
          ..write('offsetMinutes: $offsetMinutes, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleNotificationOccurrencesTable
    extends ScheduleNotificationOccurrences
    with
        TableInfo<
          $ScheduleNotificationOccurrencesTable,
          ScheduleNotificationOccurrence
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleNotificationOccurrencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderIdMeta = const VerificationMeta(
    'reminderId',
  );
  @override
  late final GeneratedColumn<String> reminderId = GeneratedColumn<String>(
    'reminder_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES schedule_reminders (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _scheduleItemIdMeta = const VerificationMeta(
    'scheduleItemId',
  );
  @override
  late final GeneratedColumn<String> scheduleItemId = GeneratedColumn<String>(
    'schedule_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES schedule_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _occurrenceKeyMeta = const VerificationMeta(
    'occurrenceKey',
  );
  @override
  late final GeneratedColumn<String> occurrenceKey = GeneratedColumn<String>(
    'occurrence_key',
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
  static const VerificationMeta _scheduledAtUtcMeta = const VerificationMeta(
    'scheduledAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAtUtc =
      GeneratedColumn<DateTime>(
        'scheduled_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
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
    reminderId,
    scheduleItemId,
    occurrenceKey,
    platformNotificationId,
    scheduledAtUtc,
    syncStatus,
    lastError,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_notification_occurrences';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleNotificationOccurrence> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reminder_id')) {
      context.handle(
        _reminderIdMeta,
        reminderId.isAcceptableOrUnknown(data['reminder_id']!, _reminderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reminderIdMeta);
    }
    if (data.containsKey('schedule_item_id')) {
      context.handle(
        _scheduleItemIdMeta,
        scheduleItemId.isAcceptableOrUnknown(
          data['schedule_item_id']!,
          _scheduleItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleItemIdMeta);
    }
    if (data.containsKey('occurrence_key')) {
      context.handle(
        _occurrenceKeyMeta,
        occurrenceKey.isAcceptableOrUnknown(
          data['occurrence_key']!,
          _occurrenceKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_occurrenceKeyMeta);
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
    if (data.containsKey('scheduled_at_utc')) {
      context.handle(
        _scheduledAtUtcMeta,
        scheduledAtUtc.isAcceptableOrUnknown(
          data['scheduled_at_utc']!,
          _scheduledAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtUtcMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {reminderId, occurrenceKey},
  ];
  @override
  ScheduleNotificationOccurrence map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleNotificationOccurrence(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reminderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_id'],
      )!,
      scheduleItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_item_id'],
      )!,
      occurrenceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occurrence_key'],
      )!,
      platformNotificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}platform_notification_id'],
      )!,
      scheduledAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at_utc'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
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
  $ScheduleNotificationOccurrencesTable createAlias(String alias) {
    return $ScheduleNotificationOccurrencesTable(attachedDatabase, alias);
  }
}

class ScheduleNotificationOccurrence extends DataClass
    implements Insertable<ScheduleNotificationOccurrence> {
  final String id;
  final String reminderId;
  final String scheduleItemId;
  final String occurrenceKey;
  final int platformNotificationId;
  final DateTime scheduledAtUtc;
  final String syncStatus;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ScheduleNotificationOccurrence({
    required this.id,
    required this.reminderId,
    required this.scheduleItemId,
    required this.occurrenceKey,
    required this.platformNotificationId,
    required this.scheduledAtUtc,
    required this.syncStatus,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['reminder_id'] = Variable<String>(reminderId);
    map['schedule_item_id'] = Variable<String>(scheduleItemId);
    map['occurrence_key'] = Variable<String>(occurrenceKey);
    map['platform_notification_id'] = Variable<int>(platformNotificationId);
    map['scheduled_at_utc'] = Variable<DateTime>(scheduledAtUtc);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ScheduleNotificationOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return ScheduleNotificationOccurrencesCompanion(
      id: Value(id),
      reminderId: Value(reminderId),
      scheduleItemId: Value(scheduleItemId),
      occurrenceKey: Value(occurrenceKey),
      platformNotificationId: Value(platformNotificationId),
      scheduledAtUtc: Value(scheduledAtUtc),
      syncStatus: Value(syncStatus),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScheduleNotificationOccurrence.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleNotificationOccurrence(
      id: serializer.fromJson<String>(json['id']),
      reminderId: serializer.fromJson<String>(json['reminderId']),
      scheduleItemId: serializer.fromJson<String>(json['scheduleItemId']),
      occurrenceKey: serializer.fromJson<String>(json['occurrenceKey']),
      platformNotificationId: serializer.fromJson<int>(
        json['platformNotificationId'],
      ),
      scheduledAtUtc: serializer.fromJson<DateTime>(json['scheduledAtUtc']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reminderId': serializer.toJson<String>(reminderId),
      'scheduleItemId': serializer.toJson<String>(scheduleItemId),
      'occurrenceKey': serializer.toJson<String>(occurrenceKey),
      'platformNotificationId': serializer.toJson<int>(platformNotificationId),
      'scheduledAtUtc': serializer.toJson<DateTime>(scheduledAtUtc),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ScheduleNotificationOccurrence copyWith({
    String? id,
    String? reminderId,
    String? scheduleItemId,
    String? occurrenceKey,
    int? platformNotificationId,
    DateTime? scheduledAtUtc,
    String? syncStatus,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ScheduleNotificationOccurrence(
    id: id ?? this.id,
    reminderId: reminderId ?? this.reminderId,
    scheduleItemId: scheduleItemId ?? this.scheduleItemId,
    occurrenceKey: occurrenceKey ?? this.occurrenceKey,
    platformNotificationId:
        platformNotificationId ?? this.platformNotificationId,
    scheduledAtUtc: scheduledAtUtc ?? this.scheduledAtUtc,
    syncStatus: syncStatus ?? this.syncStatus,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ScheduleNotificationOccurrence copyWithCompanion(
    ScheduleNotificationOccurrencesCompanion data,
  ) {
    return ScheduleNotificationOccurrence(
      id: data.id.present ? data.id.value : this.id,
      reminderId: data.reminderId.present
          ? data.reminderId.value
          : this.reminderId,
      scheduleItemId: data.scheduleItemId.present
          ? data.scheduleItemId.value
          : this.scheduleItemId,
      occurrenceKey: data.occurrenceKey.present
          ? data.occurrenceKey.value
          : this.occurrenceKey,
      platformNotificationId: data.platformNotificationId.present
          ? data.platformNotificationId.value
          : this.platformNotificationId,
      scheduledAtUtc: data.scheduledAtUtc.present
          ? data.scheduledAtUtc.value
          : this.scheduledAtUtc,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleNotificationOccurrence(')
          ..write('id: $id, ')
          ..write('reminderId: $reminderId, ')
          ..write('scheduleItemId: $scheduleItemId, ')
          ..write('occurrenceKey: $occurrenceKey, ')
          ..write('platformNotificationId: $platformNotificationId, ')
          ..write('scheduledAtUtc: $scheduledAtUtc, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reminderId,
    scheduleItemId,
    occurrenceKey,
    platformNotificationId,
    scheduledAtUtc,
    syncStatus,
    lastError,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleNotificationOccurrence &&
          other.id == this.id &&
          other.reminderId == this.reminderId &&
          other.scheduleItemId == this.scheduleItemId &&
          other.occurrenceKey == this.occurrenceKey &&
          other.platformNotificationId == this.platformNotificationId &&
          other.scheduledAtUtc == this.scheduledAtUtc &&
          other.syncStatus == this.syncStatus &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScheduleNotificationOccurrencesCompanion
    extends UpdateCompanion<ScheduleNotificationOccurrence> {
  final Value<String> id;
  final Value<String> reminderId;
  final Value<String> scheduleItemId;
  final Value<String> occurrenceKey;
  final Value<int> platformNotificationId;
  final Value<DateTime> scheduledAtUtc;
  final Value<String> syncStatus;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ScheduleNotificationOccurrencesCompanion({
    this.id = const Value.absent(),
    this.reminderId = const Value.absent(),
    this.scheduleItemId = const Value.absent(),
    this.occurrenceKey = const Value.absent(),
    this.platformNotificationId = const Value.absent(),
    this.scheduledAtUtc = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleNotificationOccurrencesCompanion.insert({
    required String id,
    required String reminderId,
    required String scheduleItemId,
    required String occurrenceKey,
    required int platformNotificationId,
    required DateTime scheduledAtUtc,
    this.syncStatus = const Value.absent(),
    this.lastError = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reminderId = Value(reminderId),
       scheduleItemId = Value(scheduleItemId),
       occurrenceKey = Value(occurrenceKey),
       platformNotificationId = Value(platformNotificationId),
       scheduledAtUtc = Value(scheduledAtUtc),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScheduleNotificationOccurrence> custom({
    Expression<String>? id,
    Expression<String>? reminderId,
    Expression<String>? scheduleItemId,
    Expression<String>? occurrenceKey,
    Expression<int>? platformNotificationId,
    Expression<DateTime>? scheduledAtUtc,
    Expression<String>? syncStatus,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reminderId != null) 'reminder_id': reminderId,
      if (scheduleItemId != null) 'schedule_item_id': scheduleItemId,
      if (occurrenceKey != null) 'occurrence_key': occurrenceKey,
      if (platformNotificationId != null)
        'platform_notification_id': platformNotificationId,
      if (scheduledAtUtc != null) 'scheduled_at_utc': scheduledAtUtc,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleNotificationOccurrencesCompanion copyWith({
    Value<String>? id,
    Value<String>? reminderId,
    Value<String>? scheduleItemId,
    Value<String>? occurrenceKey,
    Value<int>? platformNotificationId,
    Value<DateTime>? scheduledAtUtc,
    Value<String>? syncStatus,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ScheduleNotificationOccurrencesCompanion(
      id: id ?? this.id,
      reminderId: reminderId ?? this.reminderId,
      scheduleItemId: scheduleItemId ?? this.scheduleItemId,
      occurrenceKey: occurrenceKey ?? this.occurrenceKey,
      platformNotificationId:
          platformNotificationId ?? this.platformNotificationId,
      scheduledAtUtc: scheduledAtUtc ?? this.scheduledAtUtc,
      syncStatus: syncStatus ?? this.syncStatus,
      lastError: lastError ?? this.lastError,
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
    if (reminderId.present) {
      map['reminder_id'] = Variable<String>(reminderId.value);
    }
    if (scheduleItemId.present) {
      map['schedule_item_id'] = Variable<String>(scheduleItemId.value);
    }
    if (occurrenceKey.present) {
      map['occurrence_key'] = Variable<String>(occurrenceKey.value);
    }
    if (platformNotificationId.present) {
      map['platform_notification_id'] = Variable<int>(
        platformNotificationId.value,
      );
    }
    if (scheduledAtUtc.present) {
      map['scheduled_at_utc'] = Variable<DateTime>(scheduledAtUtc.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
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
    return (StringBuffer('ScheduleNotificationOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('reminderId: $reminderId, ')
          ..write('scheduleItemId: $scheduleItemId, ')
          ..write('occurrenceKey: $occurrenceKey, ')
          ..write('platformNotificationId: $platformNotificationId, ')
          ..write('scheduledAtUtc: $scheduledAtUtc, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SchedulerSettingsTable extends SchedulerSettings
    with TableInfo<$SchedulerSettingsTable, SchedulerSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulerSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _defaultEventDurationMinutesMeta =
      const VerificationMeta('defaultEventDurationMinutes');
  @override
  late final GeneratedColumn<int> defaultEventDurationMinutes =
      GeneratedColumn<int>(
        'default_event_duration_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(60),
      );
  static const VerificationMeta _defaultReminderMinutesMeta =
      const VerificationMeta('defaultReminderMinutes');
  @override
  late final GeneratedColumn<int> defaultReminderMinutes = GeneratedColumn<int>(
    'default_reminder_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _defaultTaskReminderTimeMeta =
      const VerificationMeta('defaultTaskReminderTime');
  @override
  late final GeneratedColumn<String> defaultTaskReminderTime =
      GeneratedColumn<String>(
        'default_task_reminder_time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('09:00'),
      );
  static const VerificationMeta _weekStartsOnMeta = const VerificationMeta(
    'weekStartsOn',
  );
  @override
  late final GeneratedColumn<String> weekStartsOn = GeneratedColumn<String>(
    'week_starts_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('monday'),
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Asia/Jakarta'),
  );
  static const VerificationMeta _rollingHorizonDaysMeta =
      const VerificationMeta('rollingHorizonDays');
  @override
  late final GeneratedColumn<int> rollingHorizonDays = GeneratedColumn<int>(
    'rolling_horizon_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
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
    defaultEventDurationMinutes,
    defaultReminderMinutes,
    defaultTaskReminderTime,
    weekStartsOn,
    timezone,
    rollingHorizonDays,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduler_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SchedulerSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('default_event_duration_minutes')) {
      context.handle(
        _defaultEventDurationMinutesMeta,
        defaultEventDurationMinutes.isAcceptableOrUnknown(
          data['default_event_duration_minutes']!,
          _defaultEventDurationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('default_reminder_minutes')) {
      context.handle(
        _defaultReminderMinutesMeta,
        defaultReminderMinutes.isAcceptableOrUnknown(
          data['default_reminder_minutes']!,
          _defaultReminderMinutesMeta,
        ),
      );
    }
    if (data.containsKey('default_task_reminder_time')) {
      context.handle(
        _defaultTaskReminderTimeMeta,
        defaultTaskReminderTime.isAcceptableOrUnknown(
          data['default_task_reminder_time']!,
          _defaultTaskReminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('week_starts_on')) {
      context.handle(
        _weekStartsOnMeta,
        weekStartsOn.isAcceptableOrUnknown(
          data['week_starts_on']!,
          _weekStartsOnMeta,
        ),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('rolling_horizon_days')) {
      context.handle(
        _rollingHorizonDaysMeta,
        rollingHorizonDays.isAcceptableOrUnknown(
          data['rolling_horizon_days']!,
          _rollingHorizonDaysMeta,
        ),
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
  SchedulerSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchedulerSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      defaultEventDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_event_duration_minutes'],
      )!,
      defaultReminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_reminder_minutes'],
      )!,
      defaultTaskReminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_task_reminder_time'],
      )!,
      weekStartsOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}week_starts_on'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      rollingHorizonDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rolling_horizon_days'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SchedulerSettingsTable createAlias(String alias) {
    return $SchedulerSettingsTable(attachedDatabase, alias);
  }
}

class SchedulerSetting extends DataClass
    implements Insertable<SchedulerSetting> {
  final int id;
  final int defaultEventDurationMinutes;
  final int defaultReminderMinutes;
  final String defaultTaskReminderTime;
  final String weekStartsOn;
  final String timezone;
  final int rollingHorizonDays;
  final DateTime updatedAt;
  const SchedulerSetting({
    required this.id,
    required this.defaultEventDurationMinutes,
    required this.defaultReminderMinutes,
    required this.defaultTaskReminderTime,
    required this.weekStartsOn,
    required this.timezone,
    required this.rollingHorizonDays,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['default_event_duration_minutes'] = Variable<int>(
      defaultEventDurationMinutes,
    );
    map['default_reminder_minutes'] = Variable<int>(defaultReminderMinutes);
    map['default_task_reminder_time'] = Variable<String>(
      defaultTaskReminderTime,
    );
    map['week_starts_on'] = Variable<String>(weekStartsOn);
    map['timezone'] = Variable<String>(timezone);
    map['rolling_horizon_days'] = Variable<int>(rollingHorizonDays);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SchedulerSettingsCompanion toCompanion(bool nullToAbsent) {
    return SchedulerSettingsCompanion(
      id: Value(id),
      defaultEventDurationMinutes: Value(defaultEventDurationMinutes),
      defaultReminderMinutes: Value(defaultReminderMinutes),
      defaultTaskReminderTime: Value(defaultTaskReminderTime),
      weekStartsOn: Value(weekStartsOn),
      timezone: Value(timezone),
      rollingHorizonDays: Value(rollingHorizonDays),
      updatedAt: Value(updatedAt),
    );
  }

  factory SchedulerSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchedulerSetting(
      id: serializer.fromJson<int>(json['id']),
      defaultEventDurationMinutes: serializer.fromJson<int>(
        json['defaultEventDurationMinutes'],
      ),
      defaultReminderMinutes: serializer.fromJson<int>(
        json['defaultReminderMinutes'],
      ),
      defaultTaskReminderTime: serializer.fromJson<String>(
        json['defaultTaskReminderTime'],
      ),
      weekStartsOn: serializer.fromJson<String>(json['weekStartsOn']),
      timezone: serializer.fromJson<String>(json['timezone']),
      rollingHorizonDays: serializer.fromJson<int>(json['rollingHorizonDays']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'defaultEventDurationMinutes': serializer.toJson<int>(
        defaultEventDurationMinutes,
      ),
      'defaultReminderMinutes': serializer.toJson<int>(defaultReminderMinutes),
      'defaultTaskReminderTime': serializer.toJson<String>(
        defaultTaskReminderTime,
      ),
      'weekStartsOn': serializer.toJson<String>(weekStartsOn),
      'timezone': serializer.toJson<String>(timezone),
      'rollingHorizonDays': serializer.toJson<int>(rollingHorizonDays),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SchedulerSetting copyWith({
    int? id,
    int? defaultEventDurationMinutes,
    int? defaultReminderMinutes,
    String? defaultTaskReminderTime,
    String? weekStartsOn,
    String? timezone,
    int? rollingHorizonDays,
    DateTime? updatedAt,
  }) => SchedulerSetting(
    id: id ?? this.id,
    defaultEventDurationMinutes:
        defaultEventDurationMinutes ?? this.defaultEventDurationMinutes,
    defaultReminderMinutes:
        defaultReminderMinutes ?? this.defaultReminderMinutes,
    defaultTaskReminderTime:
        defaultTaskReminderTime ?? this.defaultTaskReminderTime,
    weekStartsOn: weekStartsOn ?? this.weekStartsOn,
    timezone: timezone ?? this.timezone,
    rollingHorizonDays: rollingHorizonDays ?? this.rollingHorizonDays,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SchedulerSetting copyWithCompanion(SchedulerSettingsCompanion data) {
    return SchedulerSetting(
      id: data.id.present ? data.id.value : this.id,
      defaultEventDurationMinutes: data.defaultEventDurationMinutes.present
          ? data.defaultEventDurationMinutes.value
          : this.defaultEventDurationMinutes,
      defaultReminderMinutes: data.defaultReminderMinutes.present
          ? data.defaultReminderMinutes.value
          : this.defaultReminderMinutes,
      defaultTaskReminderTime: data.defaultTaskReminderTime.present
          ? data.defaultTaskReminderTime.value
          : this.defaultTaskReminderTime,
      weekStartsOn: data.weekStartsOn.present
          ? data.weekStartsOn.value
          : this.weekStartsOn,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      rollingHorizonDays: data.rollingHorizonDays.present
          ? data.rollingHorizonDays.value
          : this.rollingHorizonDays,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SchedulerSetting(')
          ..write('id: $id, ')
          ..write('defaultEventDurationMinutes: $defaultEventDurationMinutes, ')
          ..write('defaultReminderMinutes: $defaultReminderMinutes, ')
          ..write('defaultTaskReminderTime: $defaultTaskReminderTime, ')
          ..write('weekStartsOn: $weekStartsOn, ')
          ..write('timezone: $timezone, ')
          ..write('rollingHorizonDays: $rollingHorizonDays, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    defaultEventDurationMinutes,
    defaultReminderMinutes,
    defaultTaskReminderTime,
    weekStartsOn,
    timezone,
    rollingHorizonDays,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchedulerSetting &&
          other.id == this.id &&
          other.defaultEventDurationMinutes ==
              this.defaultEventDurationMinutes &&
          other.defaultReminderMinutes == this.defaultReminderMinutes &&
          other.defaultTaskReminderTime == this.defaultTaskReminderTime &&
          other.weekStartsOn == this.weekStartsOn &&
          other.timezone == this.timezone &&
          other.rollingHorizonDays == this.rollingHorizonDays &&
          other.updatedAt == this.updatedAt);
}

class SchedulerSettingsCompanion extends UpdateCompanion<SchedulerSetting> {
  final Value<int> id;
  final Value<int> defaultEventDurationMinutes;
  final Value<int> defaultReminderMinutes;
  final Value<String> defaultTaskReminderTime;
  final Value<String> weekStartsOn;
  final Value<String> timezone;
  final Value<int> rollingHorizonDays;
  final Value<DateTime> updatedAt;
  const SchedulerSettingsCompanion({
    this.id = const Value.absent(),
    this.defaultEventDurationMinutes = const Value.absent(),
    this.defaultReminderMinutes = const Value.absent(),
    this.defaultTaskReminderTime = const Value.absent(),
    this.weekStartsOn = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rollingHorizonDays = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SchedulerSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.defaultEventDurationMinutes = const Value.absent(),
    this.defaultReminderMinutes = const Value.absent(),
    this.defaultTaskReminderTime = const Value.absent(),
    this.weekStartsOn = const Value.absent(),
    this.timezone = const Value.absent(),
    this.rollingHorizonDays = const Value.absent(),
    required DateTime updatedAt,
  }) : updatedAt = Value(updatedAt);
  static Insertable<SchedulerSetting> custom({
    Expression<int>? id,
    Expression<int>? defaultEventDurationMinutes,
    Expression<int>? defaultReminderMinutes,
    Expression<String>? defaultTaskReminderTime,
    Expression<String>? weekStartsOn,
    Expression<String>? timezone,
    Expression<int>? rollingHorizonDays,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (defaultEventDurationMinutes != null)
        'default_event_duration_minutes': defaultEventDurationMinutes,
      if (defaultReminderMinutes != null)
        'default_reminder_minutes': defaultReminderMinutes,
      if (defaultTaskReminderTime != null)
        'default_task_reminder_time': defaultTaskReminderTime,
      if (weekStartsOn != null) 'week_starts_on': weekStartsOn,
      if (timezone != null) 'timezone': timezone,
      if (rollingHorizonDays != null)
        'rolling_horizon_days': rollingHorizonDays,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SchedulerSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? defaultEventDurationMinutes,
    Value<int>? defaultReminderMinutes,
    Value<String>? defaultTaskReminderTime,
    Value<String>? weekStartsOn,
    Value<String>? timezone,
    Value<int>? rollingHorizonDays,
    Value<DateTime>? updatedAt,
  }) {
    return SchedulerSettingsCompanion(
      id: id ?? this.id,
      defaultEventDurationMinutes:
          defaultEventDurationMinutes ?? this.defaultEventDurationMinutes,
      defaultReminderMinutes:
          defaultReminderMinutes ?? this.defaultReminderMinutes,
      defaultTaskReminderTime:
          defaultTaskReminderTime ?? this.defaultTaskReminderTime,
      weekStartsOn: weekStartsOn ?? this.weekStartsOn,
      timezone: timezone ?? this.timezone,
      rollingHorizonDays: rollingHorizonDays ?? this.rollingHorizonDays,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (defaultEventDurationMinutes.present) {
      map['default_event_duration_minutes'] = Variable<int>(
        defaultEventDurationMinutes.value,
      );
    }
    if (defaultReminderMinutes.present) {
      map['default_reminder_minutes'] = Variable<int>(
        defaultReminderMinutes.value,
      );
    }
    if (defaultTaskReminderTime.present) {
      map['default_task_reminder_time'] = Variable<String>(
        defaultTaskReminderTime.value,
      );
    }
    if (weekStartsOn.present) {
      map['week_starts_on'] = Variable<String>(weekStartsOn.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (rollingHorizonDays.present) {
      map['rolling_horizon_days'] = Variable<int>(rollingHorizonDays.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulerSettingsCompanion(')
          ..write('id: $id, ')
          ..write('defaultEventDurationMinutes: $defaultEventDurationMinutes, ')
          ..write('defaultReminderMinutes: $defaultReminderMinutes, ')
          ..write('defaultTaskReminderTime: $defaultTaskReminderTime, ')
          ..write('weekStartsOn: $weekStartsOn, ')
          ..write('timezone: $timezone, ')
          ..write('rollingHorizonDays: $rollingHorizonDays, ')
          ..write('updatedAt: $updatedAt')
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
  late final $FinancialCategoriesTable financialCategories =
      $FinancialCategoriesTable(this);
  late final $FinancialPeriodsTable financialPeriods = $FinancialPeriodsTable(
    this,
  );
  late final $FinancialTransactionsTable financialTransactions =
      $FinancialTransactionsTable(this);
  late final $FinanceSettingsTable financeSettings = $FinanceSettingsTable(
    this,
  );
  late final $ChatDraftsTable chatDrafts = $ChatDraftsTable(this);
  late final $ScheduleCategoriesTable scheduleCategories =
      $ScheduleCategoriesTable(this);
  late final $ScheduleItemsTable scheduleItems = $ScheduleItemsTable(this);
  late final $ScheduleRemindersTable scheduleReminders =
      $ScheduleRemindersTable(this);
  late final $ScheduleNotificationOccurrencesTable
  scheduleNotificationOccurrences = $ScheduleNotificationOccurrencesTable(this);
  late final $SchedulerSettingsTable schedulerSettings =
      $SchedulerSettingsTable(this);
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
  late final Index idxFinancialCategoriesTypeActive = Index(
    'idx_financial_categories_type_active',
    'CREATE INDEX idx_financial_categories_type_active ON financial_categories (type, is_active)',
  );
  late final Index idxFinancialPeriodsDates = Index(
    'idx_financial_periods_dates',
    'CREATE INDEX idx_financial_periods_dates ON financial_periods (start_date, end_date)',
  );
  late final Index idxFinancialTransactionsPeriodTypeDate = Index(
    'idx_financial_transactions_period_type_date',
    'CREATE INDEX idx_financial_transactions_period_type_date ON financial_transactions (financial_period_id, type, transaction_date)',
  );
  late final Index idxFinancialTransactionsCategory = Index(
    'idx_financial_transactions_category',
    'CREATE INDEX idx_financial_transactions_category ON financial_transactions (category_id)',
  );
  late final Index idxFinancialTransactionsPeriodReimburse = Index(
    'idx_financial_transactions_period_reimburse',
    'CREATE INDEX idx_financial_transactions_period_reimburse ON financial_transactions (financial_period_id, is_reimburse)',
  );
  late final Index idxChatDraftsUpdated = Index(
    'idx_chat_drafts_updated',
    'CREATE INDEX idx_chat_drafts_updated ON chat_drafts (updated_at)',
  );
  late final Index idxScheduleCategoriesActive = Index(
    'idx_schedule_categories_active',
    'CREATE INDEX idx_schedule_categories_active ON schedule_categories (is_active, name)',
  );
  late final Index idxScheduleItemsTimeStatus = Index(
    'idx_schedule_items_time_status',
    'CREATE INDEX idx_schedule_items_time_status ON schedule_items (status, start_at_utc, end_at_utc)',
  );
  late final Index idxScheduleItemsDueStatus = Index(
    'idx_schedule_items_due_status',
    'CREATE INDEX idx_schedule_items_due_status ON schedule_items (status, due_date_local, due_at_utc)',
  );
  late final Index idxScheduleItemsCategory = Index(
    'idx_schedule_items_category',
    'CREATE INDEX idx_schedule_items_category ON schedule_items (category_id, status)',
  );
  late final Index idxScheduleRemindersItemEnabled = Index(
    'idx_schedule_reminders_item_enabled',
    'CREATE INDEX idx_schedule_reminders_item_enabled ON schedule_reminders (schedule_item_id, is_enabled)',
  );
  late final Index idxScheduleOccurrencesItemTime = Index(
    'idx_schedule_occurrences_item_time',
    'CREATE INDEX idx_schedule_occurrences_item_time ON schedule_notification_occurrences (schedule_item_id, scheduled_at_utc)',
  );
  late final Index idxScheduleOccurrencesSync = Index(
    'idx_schedule_occurrences_sync',
    'CREATE INDEX idx_schedule_occurrences_sync ON schedule_notification_occurrences (sync_status, scheduled_at_utc)',
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
    financialCategories,
    financialPeriods,
    financialTransactions,
    financeSettings,
    chatDrafts,
    scheduleCategories,
    scheduleItems,
    scheduleReminders,
    scheduleNotificationOccurrences,
    schedulerSettings,
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
    idxFinancialCategoriesTypeActive,
    idxFinancialPeriodsDates,
    idxFinancialTransactionsPeriodTypeDate,
    idxFinancialTransactionsCategory,
    idxFinancialTransactionsPeriodReimburse,
    idxChatDraftsUpdated,
    idxScheduleCategoriesActive,
    idxScheduleItemsTimeStatus,
    idxScheduleItemsDueStatus,
    idxScheduleItemsCategory,
    idxScheduleRemindersItemEnabled,
    idxScheduleOccurrencesItemTime,
    idxScheduleOccurrencesSync,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'schedule_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('schedule_reminders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'schedule_reminders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate(
          'schedule_notification_occurrences',
          kind: UpdateKind.delete,
        ),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'schedule_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate(
          'schedule_notification_occurrences',
          kind: UpdateKind.delete,
        ),
      ],
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
      Value<bool> voiceDisclosureAcknowledged,
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
      Value<bool> voiceDisclosureAcknowledged,
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

  ColumnFilters<bool> get voiceDisclosureAcknowledged => $composableBuilder(
    column: $table.voiceDisclosureAcknowledged,
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

  ColumnOrderings<bool> get voiceDisclosureAcknowledged => $composableBuilder(
    column: $table.voiceDisclosureAcknowledged,
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

  GeneratedColumn<bool> get voiceDisclosureAcknowledged => $composableBuilder(
    column: $table.voiceDisclosureAcknowledged,
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
                Value<bool> voiceDisclosureAcknowledged = const Value.absent(),
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
                voiceDisclosureAcknowledged: voiceDisclosureAcknowledged,
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
                Value<bool> voiceDisclosureAcknowledged = const Value.absent(),
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
                voiceDisclosureAcknowledged: voiceDisclosureAcknowledged,
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
typedef $$FinancialCategoriesTableCreateCompanionBuilder =
    FinancialCategoriesCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<String?> iconKey,
      Value<bool> isSystem,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FinancialCategoriesTableUpdateCompanionBuilder =
    FinancialCategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String?> iconKey,
      Value<bool> isSystem,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FinancialCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FinancialCategoriesTable,
          FinancialCategory
        > {
  $$FinancialCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $FinancialTransactionsTable,
    List<FinancialTransaction>
  >
  _financialTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financialTransactions,
        aliasName:
            'financial_categories__id__financial_transactions__category_id',
      );

  $$FinancialTransactionsTableProcessedTableManager
  get financialTransactionsRefs {
    final manager = $$FinancialTransactionsTableTableManager(
      $_db,
      $_db.financialTransactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _financialTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FinancialCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

  Expression<bool> financialTransactionsRefs(
    Expression<bool> Function($$FinancialTransactionsTableFilterComposer f) f,
  ) {
    final $$FinancialTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FinancialCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

class $$FinancialCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> financialTransactionsRefs<T extends Object>(
    Expression<T> Function($$FinancialTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FinancialTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FinancialCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialCategoriesTable,
          FinancialCategory,
          $$FinancialCategoriesTableFilterComposer,
          $$FinancialCategoriesTableOrderingComposer,
          $$FinancialCategoriesTableAnnotationComposer,
          $$FinancialCategoriesTableCreateCompanionBuilder,
          $$FinancialCategoriesTableUpdateCompanionBuilder,
          (FinancialCategory, $$FinancialCategoriesTableReferences),
          FinancialCategory,
          PrefetchHooks Function({bool financialTransactionsRefs})
        > {
  $$FinancialCategoriesTableTableManager(
    _$AppDatabase db,
    $FinancialCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialCategoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinancialCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialCategoriesCompanion(
                id: id,
                name: name,
                type: type,
                iconKey: iconKey,
                isSystem: isSystem,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<String?> iconKey = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FinancialCategoriesCompanion.insert(
                id: id,
                name: name,
                type: type,
                iconKey: iconKey,
                isSystem: isSystem,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FinancialCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({financialTransactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (financialTransactionsRefs) db.financialTransactions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (financialTransactionsRefs)
                    await $_getPrefetchedData<
                      FinancialCategory,
                      $FinancialCategoriesTable,
                      FinancialTransaction
                    >(
                      currentTable: table,
                      referencedTable: $$FinancialCategoriesTableReferences
                          ._financialTransactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FinancialCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).financialTransactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FinancialCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialCategoriesTable,
      FinancialCategory,
      $$FinancialCategoriesTableFilterComposer,
      $$FinancialCategoriesTableOrderingComposer,
      $$FinancialCategoriesTableAnnotationComposer,
      $$FinancialCategoriesTableCreateCompanionBuilder,
      $$FinancialCategoriesTableUpdateCompanionBuilder,
      (FinancialCategory, $$FinancialCategoriesTableReferences),
      FinancialCategory,
      PrefetchHooks Function({bool financialTransactionsRefs})
    >;
typedef $$FinancialPeriodsTableCreateCompanionBuilder =
    FinancialPeriodsCompanion Function({
      required String id,
      required String name,
      required DateTime startDate,
      required DateTime endDate,
      required int cycleStartDay,
      Value<int> budgetAmount,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FinancialPeriodsTableUpdateCompanionBuilder =
    FinancialPeriodsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<int> cycleStartDay,
      Value<int> budgetAmount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FinancialPeriodsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FinancialPeriodsTable, FinancialPeriod> {
  $$FinancialPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $FinancialTransactionsTable,
    List<FinancialTransaction>
  >
  _financialTransactionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.financialTransactions,
    aliasName:
        'financial_periods__id__financial_transactions__financial_period_id',
  );

  $$FinancialTransactionsTableProcessedTableManager
  get financialTransactionsRefs {
    final manager =
        $$FinancialTransactionsTableTableManager(
          $_db,
          $_db.financialTransactions,
        ).filter(
          (f) => f.financialPeriodId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _financialTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FinancialPeriodsTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialPeriodsTable> {
  $$FinancialPeriodsTableFilterComposer({
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

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get budgetAmount => $composableBuilder(
    column: $table.budgetAmount,
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

  Expression<bool> financialTransactionsRefs(
    Expression<bool> Function($$FinancialTransactionsTableFilterComposer f) f,
  ) {
    final $$FinancialTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.financialPeriodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FinancialPeriodsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialPeriodsTable> {
  $$FinancialPeriodsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get budgetAmount => $composableBuilder(
    column: $table.budgetAmount,
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

class $$FinancialPeriodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialPeriodsTable> {
  $$FinancialPeriodsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get budgetAmount => $composableBuilder(
    column: $table.budgetAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> financialTransactionsRefs<T extends Object>(
    Expression<T> Function($$FinancialTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FinancialTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactions,
          getReferencedColumn: (t) => t.financialPeriodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.financialTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FinancialPeriodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialPeriodsTable,
          FinancialPeriod,
          $$FinancialPeriodsTableFilterComposer,
          $$FinancialPeriodsTableOrderingComposer,
          $$FinancialPeriodsTableAnnotationComposer,
          $$FinancialPeriodsTableCreateCompanionBuilder,
          $$FinancialPeriodsTableUpdateCompanionBuilder,
          (FinancialPeriod, $$FinancialPeriodsTableReferences),
          FinancialPeriod,
          PrefetchHooks Function({bool financialTransactionsRefs})
        > {
  $$FinancialPeriodsTableTableManager(
    _$AppDatabase db,
    $FinancialPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialPeriodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<int> cycleStartDay = const Value.absent(),
                Value<int> budgetAmount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialPeriodsCompanion(
                id: id,
                name: name,
                startDate: startDate,
                endDate: endDate,
                cycleStartDay: cycleStartDay,
                budgetAmount: budgetAmount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required DateTime startDate,
                required DateTime endDate,
                required int cycleStartDay,
                Value<int> budgetAmount = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FinancialPeriodsCompanion.insert(
                id: id,
                name: name,
                startDate: startDate,
                endDate: endDate,
                cycleStartDay: cycleStartDay,
                budgetAmount: budgetAmount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FinancialPeriodsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({financialTransactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (financialTransactionsRefs) db.financialTransactions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (financialTransactionsRefs)
                    await $_getPrefetchedData<
                      FinancialPeriod,
                      $FinancialPeriodsTable,
                      FinancialTransaction
                    >(
                      currentTable: table,
                      referencedTable: $$FinancialPeriodsTableReferences
                          ._financialTransactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FinancialPeriodsTableReferences(
                            db,
                            table,
                            p0,
                          ).financialTransactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.financialPeriodId == item.id,
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

typedef $$FinancialPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialPeriodsTable,
      FinancialPeriod,
      $$FinancialPeriodsTableFilterComposer,
      $$FinancialPeriodsTableOrderingComposer,
      $$FinancialPeriodsTableAnnotationComposer,
      $$FinancialPeriodsTableCreateCompanionBuilder,
      $$FinancialPeriodsTableUpdateCompanionBuilder,
      (FinancialPeriod, $$FinancialPeriodsTableReferences),
      FinancialPeriod,
      PrefetchHooks Function({bool financialTransactionsRefs})
    >;
typedef $$FinancialTransactionsTableCreateCompanionBuilder =
    FinancialTransactionsCompanion Function({
      required String id,
      required String type,
      required String name,
      required int amount,
      Value<String> currencyCode,
      required DateTime transactionDate,
      required String categoryId,
      Value<String?> notes,
      Value<bool> isReimburse,
      required String financialPeriodId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FinancialTransactionsTableUpdateCompanionBuilder =
    FinancialTransactionsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> name,
      Value<int> amount,
      Value<String> currencyCode,
      Value<DateTime> transactionDate,
      Value<String> categoryId,
      Value<String?> notes,
      Value<bool> isReimburse,
      Value<String> financialPeriodId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FinancialTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FinancialTransactionsTable,
          FinancialTransaction
        > {
  $$FinancialTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FinancialCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.financialCategories.createAlias(
        'financial_transactions__category_id__financial_categories__id',
      );

  $$FinancialCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$FinancialCategoriesTableTableManager(
      $_db,
      $_db.financialCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FinancialPeriodsTable _financialPeriodIdTable(_$AppDatabase db) =>
      db.financialPeriods.createAlias(
        'financial_transactions__financial_period_id__financial_periods__id',
      );

  $$FinancialPeriodsTableProcessedTableManager get financialPeriodId {
    final $_column = $_itemColumn<String>('financial_period_id')!;

    final manager = $$FinancialPeriodsTableTableManager(
      $_db,
      $_db.financialPeriods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_financialPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FinancialTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isReimburse => $composableBuilder(
    column: $table.isReimburse,
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

  $$FinancialCategoriesTableFilterComposer get categoryId {
    final $$FinancialCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.financialCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.financialCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FinancialPeriodsTableFilterComposer get financialPeriodId {
    final $$FinancialPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.financialPeriodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isReimburse => $composableBuilder(
    column: $table.isReimburse,
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

  $$FinancialCategoriesTableOrderingComposer get categoryId {
    final $$FinancialCategoriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableOrderingComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$FinancialPeriodsTableOrderingComposer get financialPeriodId {
    final $$FinancialPeriodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.financialPeriodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableOrderingComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isReimburse => $composableBuilder(
    column: $table.isReimburse,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FinancialCategoriesTableAnnotationComposer get categoryId {
    final $$FinancialCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.financialCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.financialCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$FinancialPeriodsTableAnnotationComposer get financialPeriodId {
    final $$FinancialPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.financialPeriodId,
      referencedTable: $db.financialPeriods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancialPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.financialPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialTransactionsTable,
          FinancialTransaction,
          $$FinancialTransactionsTableFilterComposer,
          $$FinancialTransactionsTableOrderingComposer,
          $$FinancialTransactionsTableAnnotationComposer,
          $$FinancialTransactionsTableCreateCompanionBuilder,
          $$FinancialTransactionsTableUpdateCompanionBuilder,
          (FinancialTransaction, $$FinancialTransactionsTableReferences),
          FinancialTransaction,
          PrefetchHooks Function({bool categoryId, bool financialPeriodId})
        > {
  $$FinancialTransactionsTableTableManager(
    _$AppDatabase db,
    $FinancialTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FinancialTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinancialTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isReimburse = const Value.absent(),
                Value<String> financialPeriodId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialTransactionsCompanion(
                id: id,
                type: type,
                name: name,
                amount: amount,
                currencyCode: currencyCode,
                transactionDate: transactionDate,
                categoryId: categoryId,
                notes: notes,
                isReimburse: isReimburse,
                financialPeriodId: financialPeriodId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String name,
                required int amount,
                Value<String> currencyCode = const Value.absent(),
                required DateTime transactionDate,
                required String categoryId,
                Value<String?> notes = const Value.absent(),
                Value<bool> isReimburse = const Value.absent(),
                required String financialPeriodId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FinancialTransactionsCompanion.insert(
                id: id,
                type: type,
                name: name,
                amount: amount,
                currencyCode: currencyCode,
                transactionDate: transactionDate,
                categoryId: categoryId,
                notes: notes,
                isReimburse: isReimburse,
                financialPeriodId: financialPeriodId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FinancialTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoryId = false, financialPeriodId = false}) {
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
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$FinancialTransactionsTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$FinancialTransactionsTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (financialPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.financialPeriodId,
                                    referencedTable:
                                        $$FinancialTransactionsTableReferences
                                            ._financialPeriodIdTable(db),
                                    referencedColumn:
                                        $$FinancialTransactionsTableReferences
                                            ._financialPeriodIdTable(db)
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

typedef $$FinancialTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialTransactionsTable,
      FinancialTransaction,
      $$FinancialTransactionsTableFilterComposer,
      $$FinancialTransactionsTableOrderingComposer,
      $$FinancialTransactionsTableAnnotationComposer,
      $$FinancialTransactionsTableCreateCompanionBuilder,
      $$FinancialTransactionsTableUpdateCompanionBuilder,
      (FinancialTransaction, $$FinancialTransactionsTableReferences),
      FinancialTransaction,
      PrefetchHooks Function({bool categoryId, bool financialPeriodId})
    >;
typedef $$FinanceSettingsTableCreateCompanionBuilder =
    FinanceSettingsCompanion Function({
      Value<int> id,
      Value<int> cycleStartDay,
      Value<int> defaultBudgetAmount,
      Value<String> currencyCode,
      required DateTime updatedAt,
    });
typedef $$FinanceSettingsTableUpdateCompanionBuilder =
    FinanceSettingsCompanion Function({
      Value<int> id,
      Value<int> cycleStartDay,
      Value<int> defaultBudgetAmount,
      Value<String> currencyCode,
      Value<DateTime> updatedAt,
    });

class $$FinanceSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $FinanceSettingsTable> {
  $$FinanceSettingsTableFilterComposer({
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

  ColumnFilters<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultBudgetAmount => $composableBuilder(
    column: $table.defaultBudgetAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FinanceSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinanceSettingsTable> {
  $$FinanceSettingsTableOrderingComposer({
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

  ColumnOrderings<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultBudgetAmount => $composableBuilder(
    column: $table.defaultBudgetAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinanceSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinanceSettingsTable> {
  $$FinanceSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultBudgetAmount => $composableBuilder(
    column: $table.defaultBudgetAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FinanceSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinanceSettingsTable,
          FinanceSetting,
          $$FinanceSettingsTableFilterComposer,
          $$FinanceSettingsTableOrderingComposer,
          $$FinanceSettingsTableAnnotationComposer,
          $$FinanceSettingsTableCreateCompanionBuilder,
          $$FinanceSettingsTableUpdateCompanionBuilder,
          (
            FinanceSetting,
            BaseReferences<
              _$AppDatabase,
              $FinanceSettingsTable,
              FinanceSetting
            >,
          ),
          FinanceSetting,
          PrefetchHooks Function()
        > {
  $$FinanceSettingsTableTableManager(
    _$AppDatabase db,
    $FinanceSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinanceSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinanceSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinanceSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cycleStartDay = const Value.absent(),
                Value<int> defaultBudgetAmount = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FinanceSettingsCompanion(
                id: id,
                cycleStartDay: cycleStartDay,
                defaultBudgetAmount: defaultBudgetAmount,
                currencyCode: currencyCode,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> cycleStartDay = const Value.absent(),
                Value<int> defaultBudgetAmount = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                required DateTime updatedAt,
              }) => FinanceSettingsCompanion.insert(
                id: id,
                cycleStartDay: cycleStartDay,
                defaultBudgetAmount: defaultBudgetAmount,
                currencyCode: currencyCode,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FinanceSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinanceSettingsTable,
      FinanceSetting,
      $$FinanceSettingsTableFilterComposer,
      $$FinanceSettingsTableOrderingComposer,
      $$FinanceSettingsTableAnnotationComposer,
      $$FinanceSettingsTableCreateCompanionBuilder,
      $$FinanceSettingsTableUpdateCompanionBuilder,
      (
        FinanceSetting,
        BaseReferences<_$AppDatabase, $FinanceSettingsTable, FinanceSetting>,
      ),
      FinanceSetting,
      PrefetchHooks Function()
    >;
typedef $$ChatDraftsTableCreateCompanionBuilder =
    ChatDraftsCompanion Function({
      required String id,
      required String draftText,
      required String selectedMode,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ChatDraftsTableUpdateCompanionBuilder =
    ChatDraftsCompanion Function({
      Value<String> id,
      Value<String> draftText,
      Value<String> selectedMode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ChatDraftsTableFilterComposer
    extends Composer<_$AppDatabase, $ChatDraftsTable> {
  $$ChatDraftsTableFilterComposer({
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

  ColumnFilters<String> get draftText => $composableBuilder(
    column: $table.draftText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedMode => $composableBuilder(
    column: $table.selectedMode,
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

class $$ChatDraftsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatDraftsTable> {
  $$ChatDraftsTableOrderingComposer({
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

  ColumnOrderings<String> get draftText => $composableBuilder(
    column: $table.draftText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedMode => $composableBuilder(
    column: $table.selectedMode,
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

class $$ChatDraftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatDraftsTable> {
  $$ChatDraftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get draftText =>
      $composableBuilder(column: $table.draftText, builder: (column) => column);

  GeneratedColumn<String> get selectedMode => $composableBuilder(
    column: $table.selectedMode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChatDraftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatDraftsTable,
          ChatDraft,
          $$ChatDraftsTableFilterComposer,
          $$ChatDraftsTableOrderingComposer,
          $$ChatDraftsTableAnnotationComposer,
          $$ChatDraftsTableCreateCompanionBuilder,
          $$ChatDraftsTableUpdateCompanionBuilder,
          (
            ChatDraft,
            BaseReferences<_$AppDatabase, $ChatDraftsTable, ChatDraft>,
          ),
          ChatDraft,
          PrefetchHooks Function()
        > {
  $$ChatDraftsTableTableManager(_$AppDatabase db, $ChatDraftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatDraftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatDraftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatDraftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> draftText = const Value.absent(),
                Value<String> selectedMode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatDraftsCompanion(
                id: id,
                draftText: draftText,
                selectedMode: selectedMode,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String draftText,
                required String selectedMode,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ChatDraftsCompanion.insert(
                id: id,
                draftText: draftText,
                selectedMode: selectedMode,
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

typedef $$ChatDraftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatDraftsTable,
      ChatDraft,
      $$ChatDraftsTableFilterComposer,
      $$ChatDraftsTableOrderingComposer,
      $$ChatDraftsTableAnnotationComposer,
      $$ChatDraftsTableCreateCompanionBuilder,
      $$ChatDraftsTableUpdateCompanionBuilder,
      (ChatDraft, BaseReferences<_$AppDatabase, $ChatDraftsTable, ChatDraft>),
      ChatDraft,
      PrefetchHooks Function()
    >;
typedef $$ScheduleCategoriesTableCreateCompanionBuilder =
    ScheduleCategoriesCompanion Function({
      required String id,
      required String name,
      Value<String?> iconKey,
      required bool isSystem,
      required bool isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ScheduleCategoriesTableUpdateCompanionBuilder =
    ScheduleCategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> iconKey,
      Value<bool> isSystem,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ScheduleCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ScheduleCategoriesTable,
          ScheduleCategory
        > {
  $$ScheduleCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ScheduleItemsTable, List<ScheduleItem>>
  _scheduleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scheduleItems,
    aliasName: 'schedule_categories__id__schedule_items__category_id',
  );

  $$ScheduleItemsTableProcessedTableManager get scheduleItemsRefs {
    final manager = $$ScheduleItemsTableTableManager(
      $_db,
      $_db.scheduleItems,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_scheduleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScheduleCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleCategoriesTable> {
  $$ScheduleCategoriesTableFilterComposer({
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

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

  Expression<bool> scheduleItemsRefs(
    Expression<bool> Function($$ScheduleItemsTableFilterComposer f) f,
  ) {
    final $$ScheduleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableFilterComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScheduleCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleCategoriesTable> {
  $$ScheduleCategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

class $$ScheduleCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleCategoriesTable> {
  $$ScheduleCategoriesTableAnnotationComposer({
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

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> scheduleItemsRefs<T extends Object>(
    Expression<T> Function($$ScheduleItemsTableAnnotationComposer a) f,
  ) {
    final $$ScheduleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScheduleCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleCategoriesTable,
          ScheduleCategory,
          $$ScheduleCategoriesTableFilterComposer,
          $$ScheduleCategoriesTableOrderingComposer,
          $$ScheduleCategoriesTableAnnotationComposer,
          $$ScheduleCategoriesTableCreateCompanionBuilder,
          $$ScheduleCategoriesTableUpdateCompanionBuilder,
          (ScheduleCategory, $$ScheduleCategoriesTableReferences),
          ScheduleCategory,
          PrefetchHooks Function({bool scheduleItemsRefs})
        > {
  $$ScheduleCategoriesTableTableManager(
    _$AppDatabase db,
    $ScheduleCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleCategoriesCompanion(
                id: id,
                name: name,
                iconKey: iconKey,
                isSystem: isSystem,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> iconKey = const Value.absent(),
                required bool isSystem,
                required bool isActive,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScheduleCategoriesCompanion.insert(
                id: id,
                name: name,
                iconKey: iconKey,
                isSystem: isSystem,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScheduleCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scheduleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (scheduleItemsRefs) db.scheduleItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scheduleItemsRefs)
                    await $_getPrefetchedData<
                      ScheduleCategory,
                      $ScheduleCategoriesTable,
                      ScheduleItem
                    >(
                      currentTable: table,
                      referencedTable: $$ScheduleCategoriesTableReferences
                          ._scheduleItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ScheduleCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).scheduleItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ScheduleCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleCategoriesTable,
      ScheduleCategory,
      $$ScheduleCategoriesTableFilterComposer,
      $$ScheduleCategoriesTableOrderingComposer,
      $$ScheduleCategoriesTableAnnotationComposer,
      $$ScheduleCategoriesTableCreateCompanionBuilder,
      $$ScheduleCategoriesTableUpdateCompanionBuilder,
      (ScheduleCategory, $$ScheduleCategoriesTableReferences),
      ScheduleCategory,
      PrefetchHooks Function({bool scheduleItemsRefs})
    >;
typedef $$ScheduleItemsTableCreateCompanionBuilder =
    ScheduleItemsCompanion Function({
      required String id,
      required String itemType,
      required String title,
      Value<String?> description,
      Value<DateTime?> startAtUtc,
      Value<DateTime?> endAtUtc,
      Value<DateTime?> dueAtUtc,
      Value<String?> localStartDate,
      Value<String?> localStartTime,
      Value<String?> localEndTime,
      Value<String?> dueDateLocal,
      required bool allDay,
      required String categoryId,
      required String priority,
      required String status,
      required String timezone,
      required String recurrenceType,
      Value<int> recurrenceInterval,
      Value<String?> recurrenceWeekdaysJson,
      Value<String?> recurrenceEndDateLocal,
      Value<String> source,
      Value<String?> originalUserText,
      Value<DateTime?> completedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ScheduleItemsTableUpdateCompanionBuilder =
    ScheduleItemsCompanion Function({
      Value<String> id,
      Value<String> itemType,
      Value<String> title,
      Value<String?> description,
      Value<DateTime?> startAtUtc,
      Value<DateTime?> endAtUtc,
      Value<DateTime?> dueAtUtc,
      Value<String?> localStartDate,
      Value<String?> localStartTime,
      Value<String?> localEndTime,
      Value<String?> dueDateLocal,
      Value<bool> allDay,
      Value<String> categoryId,
      Value<String> priority,
      Value<String> status,
      Value<String> timezone,
      Value<String> recurrenceType,
      Value<int> recurrenceInterval,
      Value<String?> recurrenceWeekdaysJson,
      Value<String?> recurrenceEndDateLocal,
      Value<String> source,
      Value<String?> originalUserText,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ScheduleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ScheduleItemsTable, ScheduleItem> {
  $$ScheduleItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ScheduleCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .scheduleCategories
      .createAlias('schedule_items__category_id__schedule_categories__id');

  $$ScheduleCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$ScheduleCategoriesTableTableManager(
      $_db,
      $_db.scheduleCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ScheduleRemindersTable, List<ScheduleReminder>>
  _scheduleRemindersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scheduleReminders,
        aliasName: 'schedule_items__id__schedule_reminders__schedule_item_id',
      );

  $$ScheduleRemindersTableProcessedTableManager get scheduleRemindersRefs {
    final manager = $$ScheduleRemindersTableTableManager(
      $_db,
      $_db.scheduleReminders,
    ).filter((f) => f.scheduleItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduleRemindersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ScheduleNotificationOccurrencesTable,
    List<ScheduleNotificationOccurrence>
  >
  _scheduleNotificationOccurrencesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scheduleNotificationOccurrences,
    aliasName:
        'schedule_items__id__schedule_notification_occurrences__schedule_item_id',
  );

  $$ScheduleNotificationOccurrencesTableProcessedTableManager
  get scheduleNotificationOccurrencesRefs {
    final manager = $$ScheduleNotificationOccurrencesTableTableManager(
      $_db,
      $_db.scheduleNotificationOccurrences,
    ).filter((f) => f.scheduleItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduleNotificationOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScheduleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleItemsTable> {
  $$ScheduleItemsTableFilterComposer({
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

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAtUtc => $composableBuilder(
    column: $table.startAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAtUtc => $composableBuilder(
    column: $table.endAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAtUtc => $composableBuilder(
    column: $table.dueAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localStartDate => $composableBuilder(
    column: $table.localStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localStartTime => $composableBuilder(
    column: $table.localStartTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localEndTime => $composableBuilder(
    column: $table.localEndTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDateLocal => $composableBuilder(
    column: $table.dueDateLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recurrenceInterval => $composableBuilder(
    column: $table.recurrenceInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceWeekdaysJson => $composableBuilder(
    column: $table.recurrenceWeekdaysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceEndDateLocal => $composableBuilder(
    column: $table.recurrenceEndDateLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalUserText => $composableBuilder(
    column: $table.originalUserText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
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

  $$ScheduleCategoriesTableFilterComposer get categoryId {
    final $$ScheduleCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.scheduleCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.scheduleCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scheduleRemindersRefs(
    Expression<bool> Function($$ScheduleRemindersTableFilterComposer f) f,
  ) {
    final $$ScheduleRemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleReminders,
      getReferencedColumn: (t) => t.scheduleItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleRemindersTableFilterComposer(
            $db: $db,
            $table: $db.scheduleReminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scheduleNotificationOccurrencesRefs(
    Expression<bool> Function(
      $$ScheduleNotificationOccurrencesTableFilterComposer f,
    )
    f,
  ) {
    final $$ScheduleNotificationOccurrencesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scheduleNotificationOccurrences,
          getReferencedColumn: (t) => t.scheduleItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleNotificationOccurrencesTableFilterComposer(
                $db: $db,
                $table: $db.scheduleNotificationOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ScheduleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleItemsTable> {
  $$ScheduleItemsTableOrderingComposer({
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

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAtUtc => $composableBuilder(
    column: $table.startAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAtUtc => $composableBuilder(
    column: $table.endAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAtUtc => $composableBuilder(
    column: $table.dueAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localStartDate => $composableBuilder(
    column: $table.localStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localStartTime => $composableBuilder(
    column: $table.localStartTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localEndTime => $composableBuilder(
    column: $table.localEndTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDateLocal => $composableBuilder(
    column: $table.dueDateLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recurrenceInterval => $composableBuilder(
    column: $table.recurrenceInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceWeekdaysJson => $composableBuilder(
    column: $table.recurrenceWeekdaysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceEndDateLocal => $composableBuilder(
    column: $table.recurrenceEndDateLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalUserText => $composableBuilder(
    column: $table.originalUserText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
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

  $$ScheduleCategoriesTableOrderingComposer get categoryId {
    final $$ScheduleCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.scheduleCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.scheduleCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleItemsTable> {
  $$ScheduleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startAtUtc => $composableBuilder(
    column: $table.startAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endAtUtc =>
      $composableBuilder(column: $table.endAtUtc, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAtUtc =>
      $composableBuilder(column: $table.dueAtUtc, builder: (column) => column);

  GeneratedColumn<String> get localStartDate => $composableBuilder(
    column: $table.localStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localStartTime => $composableBuilder(
    column: $table.localStartTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localEndTime => $composableBuilder(
    column: $table.localEndTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueDateLocal => $composableBuilder(
    column: $table.dueDateLocal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recurrenceInterval => $composableBuilder(
    column: $table.recurrenceInterval,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceWeekdaysJson => $composableBuilder(
    column: $table.recurrenceWeekdaysJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceEndDateLocal => $composableBuilder(
    column: $table.recurrenceEndDateLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get originalUserText => $composableBuilder(
    column: $table.originalUserText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ScheduleCategoriesTableAnnotationComposer get categoryId {
    final $$ScheduleCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.scheduleCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.scheduleCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> scheduleRemindersRefs<T extends Object>(
    Expression<T> Function($$ScheduleRemindersTableAnnotationComposer a) f,
  ) {
    final $$ScheduleRemindersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scheduleReminders,
          getReferencedColumn: (t) => t.scheduleItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleRemindersTableAnnotationComposer(
                $db: $db,
                $table: $db.scheduleReminders,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> scheduleNotificationOccurrencesRefs<T extends Object>(
    Expression<T> Function(
      $$ScheduleNotificationOccurrencesTableAnnotationComposer a,
    )
    f,
  ) {
    final $$ScheduleNotificationOccurrencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scheduleNotificationOccurrences,
          getReferencedColumn: (t) => t.scheduleItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleNotificationOccurrencesTableAnnotationComposer(
                $db: $db,
                $table: $db.scheduleNotificationOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ScheduleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleItemsTable,
          ScheduleItem,
          $$ScheduleItemsTableFilterComposer,
          $$ScheduleItemsTableOrderingComposer,
          $$ScheduleItemsTableAnnotationComposer,
          $$ScheduleItemsTableCreateCompanionBuilder,
          $$ScheduleItemsTableUpdateCompanionBuilder,
          (ScheduleItem, $$ScheduleItemsTableReferences),
          ScheduleItem,
          PrefetchHooks Function({
            bool categoryId,
            bool scheduleRemindersRefs,
            bool scheduleNotificationOccurrencesRefs,
          })
        > {
  $$ScheduleItemsTableTableManager(_$AppDatabase db, $ScheduleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> startAtUtc = const Value.absent(),
                Value<DateTime?> endAtUtc = const Value.absent(),
                Value<DateTime?> dueAtUtc = const Value.absent(),
                Value<String?> localStartDate = const Value.absent(),
                Value<String?> localStartTime = const Value.absent(),
                Value<String?> localEndTime = const Value.absent(),
                Value<String?> dueDateLocal = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<String> recurrenceType = const Value.absent(),
                Value<int> recurrenceInterval = const Value.absent(),
                Value<String?> recurrenceWeekdaysJson = const Value.absent(),
                Value<String?> recurrenceEndDateLocal = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> originalUserText = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleItemsCompanion(
                id: id,
                itemType: itemType,
                title: title,
                description: description,
                startAtUtc: startAtUtc,
                endAtUtc: endAtUtc,
                dueAtUtc: dueAtUtc,
                localStartDate: localStartDate,
                localStartTime: localStartTime,
                localEndTime: localEndTime,
                dueDateLocal: dueDateLocal,
                allDay: allDay,
                categoryId: categoryId,
                priority: priority,
                status: status,
                timezone: timezone,
                recurrenceType: recurrenceType,
                recurrenceInterval: recurrenceInterval,
                recurrenceWeekdaysJson: recurrenceWeekdaysJson,
                recurrenceEndDateLocal: recurrenceEndDateLocal,
                source: source,
                originalUserText: originalUserText,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemType,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime?> startAtUtc = const Value.absent(),
                Value<DateTime?> endAtUtc = const Value.absent(),
                Value<DateTime?> dueAtUtc = const Value.absent(),
                Value<String?> localStartDate = const Value.absent(),
                Value<String?> localStartTime = const Value.absent(),
                Value<String?> localEndTime = const Value.absent(),
                Value<String?> dueDateLocal = const Value.absent(),
                required bool allDay,
                required String categoryId,
                required String priority,
                required String status,
                required String timezone,
                required String recurrenceType,
                Value<int> recurrenceInterval = const Value.absent(),
                Value<String?> recurrenceWeekdaysJson = const Value.absent(),
                Value<String?> recurrenceEndDateLocal = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> originalUserText = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScheduleItemsCompanion.insert(
                id: id,
                itemType: itemType,
                title: title,
                description: description,
                startAtUtc: startAtUtc,
                endAtUtc: endAtUtc,
                dueAtUtc: dueAtUtc,
                localStartDate: localStartDate,
                localStartTime: localStartTime,
                localEndTime: localEndTime,
                dueDateLocal: dueDateLocal,
                allDay: allDay,
                categoryId: categoryId,
                priority: priority,
                status: status,
                timezone: timezone,
                recurrenceType: recurrenceType,
                recurrenceInterval: recurrenceInterval,
                recurrenceWeekdaysJson: recurrenceWeekdaysJson,
                recurrenceEndDateLocal: recurrenceEndDateLocal,
                source: source,
                originalUserText: originalUserText,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScheduleItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                scheduleRemindersRefs = false,
                scheduleNotificationOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scheduleRemindersRefs) db.scheduleReminders,
                    if (scheduleNotificationOccurrencesRefs)
                      db.scheduleNotificationOccurrences,
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
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$ScheduleItemsTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$ScheduleItemsTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scheduleRemindersRefs)
                        await $_getPrefetchedData<
                          ScheduleItem,
                          $ScheduleItemsTable,
                          ScheduleReminder
                        >(
                          currentTable: table,
                          referencedTable: $$ScheduleItemsTableReferences
                              ._scheduleRemindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScheduleItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).scheduleRemindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scheduleItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scheduleNotificationOccurrencesRefs)
                        await $_getPrefetchedData<
                          ScheduleItem,
                          $ScheduleItemsTable,
                          ScheduleNotificationOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $$ScheduleItemsTableReferences
                              ._scheduleNotificationOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScheduleItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).scheduleNotificationOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scheduleItemId == item.id,
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

typedef $$ScheduleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleItemsTable,
      ScheduleItem,
      $$ScheduleItemsTableFilterComposer,
      $$ScheduleItemsTableOrderingComposer,
      $$ScheduleItemsTableAnnotationComposer,
      $$ScheduleItemsTableCreateCompanionBuilder,
      $$ScheduleItemsTableUpdateCompanionBuilder,
      (ScheduleItem, $$ScheduleItemsTableReferences),
      ScheduleItem,
      PrefetchHooks Function({
        bool categoryId,
        bool scheduleRemindersRefs,
        bool scheduleNotificationOccurrencesRefs,
      })
    >;
typedef $$ScheduleRemindersTableCreateCompanionBuilder =
    ScheduleRemindersCompanion Function({
      required String id,
      required String scheduleItemId,
      required int offsetMinutes,
      required bool isEnabled,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ScheduleRemindersTableUpdateCompanionBuilder =
    ScheduleRemindersCompanion Function({
      Value<String> id,
      Value<String> scheduleItemId,
      Value<int> offsetMinutes,
      Value<bool> isEnabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ScheduleRemindersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ScheduleRemindersTable,
          ScheduleReminder
        > {
  $$ScheduleRemindersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ScheduleItemsTable _scheduleItemIdTable(_$AppDatabase db) => db
      .scheduleItems
      .createAlias('schedule_reminders__schedule_item_id__schedule_items__id');

  $$ScheduleItemsTableProcessedTableManager get scheduleItemId {
    final $_column = $_itemColumn<String>('schedule_item_id')!;

    final manager = $$ScheduleItemsTableTableManager(
      $_db,
      $_db.scheduleItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scheduleItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ScheduleNotificationOccurrencesTable,
    List<ScheduleNotificationOccurrence>
  >
  _scheduleNotificationOccurrencesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scheduleNotificationOccurrences,
    aliasName:
        'schedule_reminders__id__schedule_notification_occurrences__reminder_id',
  );

  $$ScheduleNotificationOccurrencesTableProcessedTableManager
  get scheduleNotificationOccurrencesRefs {
    final manager = $$ScheduleNotificationOccurrencesTableTableManager(
      $_db,
      $_db.scheduleNotificationOccurrences,
    ).filter((f) => f.reminderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduleNotificationOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScheduleRemindersTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleRemindersTable> {
  $$ScheduleRemindersTableFilterComposer({
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

  ColumnFilters<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
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

  $$ScheduleItemsTableFilterComposer get scheduleItemId {
    final $$ScheduleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleItemId,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableFilterComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scheduleNotificationOccurrencesRefs(
    Expression<bool> Function(
      $$ScheduleNotificationOccurrencesTableFilterComposer f,
    )
    f,
  ) {
    final $$ScheduleNotificationOccurrencesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scheduleNotificationOccurrences,
          getReferencedColumn: (t) => t.reminderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleNotificationOccurrencesTableFilterComposer(
                $db: $db,
                $table: $db.scheduleNotificationOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ScheduleRemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleRemindersTable> {
  $$ScheduleRemindersTableOrderingComposer({
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

  ColumnOrderings<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
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

  $$ScheduleItemsTableOrderingComposer get scheduleItemId {
    final $$ScheduleItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleItemId,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableOrderingComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleRemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleRemindersTable> {
  $$ScheduleRemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get offsetMinutes => $composableBuilder(
    column: $table.offsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ScheduleItemsTableAnnotationComposer get scheduleItemId {
    final $$ScheduleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleItemId,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> scheduleNotificationOccurrencesRefs<T extends Object>(
    Expression<T> Function(
      $$ScheduleNotificationOccurrencesTableAnnotationComposer a,
    )
    f,
  ) {
    final $$ScheduleNotificationOccurrencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scheduleNotificationOccurrences,
          getReferencedColumn: (t) => t.reminderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleNotificationOccurrencesTableAnnotationComposer(
                $db: $db,
                $table: $db.scheduleNotificationOccurrences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ScheduleRemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleRemindersTable,
          ScheduleReminder,
          $$ScheduleRemindersTableFilterComposer,
          $$ScheduleRemindersTableOrderingComposer,
          $$ScheduleRemindersTableAnnotationComposer,
          $$ScheduleRemindersTableCreateCompanionBuilder,
          $$ScheduleRemindersTableUpdateCompanionBuilder,
          (ScheduleReminder, $$ScheduleRemindersTableReferences),
          ScheduleReminder,
          PrefetchHooks Function({
            bool scheduleItemId,
            bool scheduleNotificationOccurrencesRefs,
          })
        > {
  $$ScheduleRemindersTableTableManager(
    _$AppDatabase db,
    $ScheduleRemindersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleRemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleRemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleRemindersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> scheduleItemId = const Value.absent(),
                Value<int> offsetMinutes = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleRemindersCompanion(
                id: id,
                scheduleItemId: scheduleItemId,
                offsetMinutes: offsetMinutes,
                isEnabled: isEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String scheduleItemId,
                required int offsetMinutes,
                required bool isEnabled,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScheduleRemindersCompanion.insert(
                id: id,
                scheduleItemId: scheduleItemId,
                offsetMinutes: offsetMinutes,
                isEnabled: isEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScheduleRemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                scheduleItemId = false,
                scheduleNotificationOccurrencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scheduleNotificationOccurrencesRefs)
                      db.scheduleNotificationOccurrences,
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
                        if (scheduleItemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.scheduleItemId,
                                    referencedTable:
                                        $$ScheduleRemindersTableReferences
                                            ._scheduleItemIdTable(db),
                                    referencedColumn:
                                        $$ScheduleRemindersTableReferences
                                            ._scheduleItemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scheduleNotificationOccurrencesRefs)
                        await $_getPrefetchedData<
                          ScheduleReminder,
                          $ScheduleRemindersTable,
                          ScheduleNotificationOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $$ScheduleRemindersTableReferences
                              ._scheduleNotificationOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScheduleRemindersTableReferences(
                                db,
                                table,
                                p0,
                              ).scheduleNotificationOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.reminderId == item.id,
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

typedef $$ScheduleRemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleRemindersTable,
      ScheduleReminder,
      $$ScheduleRemindersTableFilterComposer,
      $$ScheduleRemindersTableOrderingComposer,
      $$ScheduleRemindersTableAnnotationComposer,
      $$ScheduleRemindersTableCreateCompanionBuilder,
      $$ScheduleRemindersTableUpdateCompanionBuilder,
      (ScheduleReminder, $$ScheduleRemindersTableReferences),
      ScheduleReminder,
      PrefetchHooks Function({
        bool scheduleItemId,
        bool scheduleNotificationOccurrencesRefs,
      })
    >;
typedef $$ScheduleNotificationOccurrencesTableCreateCompanionBuilder =
    ScheduleNotificationOccurrencesCompanion Function({
      required String id,
      required String reminderId,
      required String scheduleItemId,
      required String occurrenceKey,
      required int platformNotificationId,
      required DateTime scheduledAtUtc,
      Value<String> syncStatus,
      Value<String?> lastError,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ScheduleNotificationOccurrencesTableUpdateCompanionBuilder =
    ScheduleNotificationOccurrencesCompanion Function({
      Value<String> id,
      Value<String> reminderId,
      Value<String> scheduleItemId,
      Value<String> occurrenceKey,
      Value<int> platformNotificationId,
      Value<DateTime> scheduledAtUtc,
      Value<String> syncStatus,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ScheduleNotificationOccurrencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ScheduleNotificationOccurrencesTable,
          ScheduleNotificationOccurrence
        > {
  $$ScheduleNotificationOccurrencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ScheduleRemindersTable _reminderIdTable(
    _$AppDatabase db,
  ) => db.scheduleReminders.createAlias(
    'schedule_notification_occurrences__reminder_id__schedule_reminders__id',
  );

  $$ScheduleRemindersTableProcessedTableManager get reminderId {
    final $_column = $_itemColumn<String>('reminder_id')!;

    final manager = $$ScheduleRemindersTableTableManager(
      $_db,
      $_db.scheduleReminders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reminderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ScheduleItemsTable _scheduleItemIdTable(
    _$AppDatabase db,
  ) => db.scheduleItems.createAlias(
    'schedule_notification_occurrences__schedule_item_id__schedule_items__id',
  );

  $$ScheduleItemsTableProcessedTableManager get scheduleItemId {
    final $_column = $_itemColumn<String>('schedule_item_id')!;

    final manager = $$ScheduleItemsTableTableManager(
      $_db,
      $_db.scheduleItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scheduleItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScheduleNotificationOccurrencesTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleNotificationOccurrencesTable> {
  $$ScheduleNotificationOccurrencesTableFilterComposer({
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

  ColumnFilters<String> get occurrenceKey => $composableBuilder(
    column: $table.occurrenceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAtUtc => $composableBuilder(
    column: $table.scheduledAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
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

  $$ScheduleRemindersTableFilterComposer get reminderId {
    final $$ScheduleRemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.scheduleReminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleRemindersTableFilterComposer(
            $db: $db,
            $table: $db.scheduleReminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ScheduleItemsTableFilterComposer get scheduleItemId {
    final $$ScheduleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleItemId,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableFilterComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleNotificationOccurrencesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleNotificationOccurrencesTable> {
  $$ScheduleNotificationOccurrencesTableOrderingComposer({
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

  ColumnOrderings<String> get occurrenceKey => $composableBuilder(
    column: $table.occurrenceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAtUtc => $composableBuilder(
    column: $table.scheduledAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
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

  $$ScheduleRemindersTableOrderingComposer get reminderId {
    final $$ScheduleRemindersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reminderId,
      referencedTable: $db.scheduleReminders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleRemindersTableOrderingComposer(
            $db: $db,
            $table: $db.scheduleReminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ScheduleItemsTableOrderingComposer get scheduleItemId {
    final $$ScheduleItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleItemId,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableOrderingComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleNotificationOccurrencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleNotificationOccurrencesTable> {
  $$ScheduleNotificationOccurrencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get occurrenceKey => $composableBuilder(
    column: $table.occurrenceKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get platformNotificationId => $composableBuilder(
    column: $table.platformNotificationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAtUtc => $composableBuilder(
    column: $table.scheduledAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ScheduleRemindersTableAnnotationComposer get reminderId {
    final $$ScheduleRemindersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.reminderId,
          referencedTable: $db.scheduleReminders,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleRemindersTableAnnotationComposer(
                $db: $db,
                $table: $db.scheduleReminders,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ScheduleItemsTableAnnotationComposer get scheduleItemId {
    final $$ScheduleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scheduleItemId,
      referencedTable: $db.scheduleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.scheduleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleNotificationOccurrencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleNotificationOccurrencesTable,
          ScheduleNotificationOccurrence,
          $$ScheduleNotificationOccurrencesTableFilterComposer,
          $$ScheduleNotificationOccurrencesTableOrderingComposer,
          $$ScheduleNotificationOccurrencesTableAnnotationComposer,
          $$ScheduleNotificationOccurrencesTableCreateCompanionBuilder,
          $$ScheduleNotificationOccurrencesTableUpdateCompanionBuilder,
          (
            ScheduleNotificationOccurrence,
            $$ScheduleNotificationOccurrencesTableReferences,
          ),
          ScheduleNotificationOccurrence,
          PrefetchHooks Function({bool reminderId, bool scheduleItemId})
        > {
  $$ScheduleNotificationOccurrencesTableTableManager(
    _$AppDatabase db,
    $ScheduleNotificationOccurrencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleNotificationOccurrencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ScheduleNotificationOccurrencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ScheduleNotificationOccurrencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reminderId = const Value.absent(),
                Value<String> scheduleItemId = const Value.absent(),
                Value<String> occurrenceKey = const Value.absent(),
                Value<int> platformNotificationId = const Value.absent(),
                Value<DateTime> scheduledAtUtc = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleNotificationOccurrencesCompanion(
                id: id,
                reminderId: reminderId,
                scheduleItemId: scheduleItemId,
                occurrenceKey: occurrenceKey,
                platformNotificationId: platformNotificationId,
                scheduledAtUtc: scheduledAtUtc,
                syncStatus: syncStatus,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reminderId,
                required String scheduleItemId,
                required String occurrenceKey,
                required int platformNotificationId,
                required DateTime scheduledAtUtc,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScheduleNotificationOccurrencesCompanion.insert(
                id: id,
                reminderId: reminderId,
                scheduleItemId: scheduleItemId,
                occurrenceKey: occurrenceKey,
                platformNotificationId: platformNotificationId,
                scheduledAtUtc: scheduledAtUtc,
                syncStatus: syncStatus,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScheduleNotificationOccurrencesTableReferences(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reminderId = false, scheduleItemId = false}) {
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
                    if (reminderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reminderId,
                                referencedTable:
                                    $$ScheduleNotificationOccurrencesTableReferences
                                        ._reminderIdTable(db),
                                referencedColumn:
                                    $$ScheduleNotificationOccurrencesTableReferences
                                        ._reminderIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (scheduleItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.scheduleItemId,
                                referencedTable:
                                    $$ScheduleNotificationOccurrencesTableReferences
                                        ._scheduleItemIdTable(db),
                                referencedColumn:
                                    $$ScheduleNotificationOccurrencesTableReferences
                                        ._scheduleItemIdTable(db)
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

typedef $$ScheduleNotificationOccurrencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleNotificationOccurrencesTable,
      ScheduleNotificationOccurrence,
      $$ScheduleNotificationOccurrencesTableFilterComposer,
      $$ScheduleNotificationOccurrencesTableOrderingComposer,
      $$ScheduleNotificationOccurrencesTableAnnotationComposer,
      $$ScheduleNotificationOccurrencesTableCreateCompanionBuilder,
      $$ScheduleNotificationOccurrencesTableUpdateCompanionBuilder,
      (
        ScheduleNotificationOccurrence,
        $$ScheduleNotificationOccurrencesTableReferences,
      ),
      ScheduleNotificationOccurrence,
      PrefetchHooks Function({bool reminderId, bool scheduleItemId})
    >;
typedef $$SchedulerSettingsTableCreateCompanionBuilder =
    SchedulerSettingsCompanion Function({
      Value<int> id,
      Value<int> defaultEventDurationMinutes,
      Value<int> defaultReminderMinutes,
      Value<String> defaultTaskReminderTime,
      Value<String> weekStartsOn,
      Value<String> timezone,
      Value<int> rollingHorizonDays,
      required DateTime updatedAt,
    });
typedef $$SchedulerSettingsTableUpdateCompanionBuilder =
    SchedulerSettingsCompanion Function({
      Value<int> id,
      Value<int> defaultEventDurationMinutes,
      Value<int> defaultReminderMinutes,
      Value<String> defaultTaskReminderTime,
      Value<String> weekStartsOn,
      Value<String> timezone,
      Value<int> rollingHorizonDays,
      Value<DateTime> updatedAt,
    });

class $$SchedulerSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SchedulerSettingsTable> {
  $$SchedulerSettingsTableFilterComposer({
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

  ColumnFilters<int> get defaultEventDurationMinutes => $composableBuilder(
    column: $table.defaultEventDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultReminderMinutes => $composableBuilder(
    column: $table.defaultReminderMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultTaskReminderTime => $composableBuilder(
    column: $table.defaultTaskReminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekStartsOn => $composableBuilder(
    column: $table.weekStartsOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollingHorizonDays => $composableBuilder(
    column: $table.rollingHorizonDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SchedulerSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SchedulerSettingsTable> {
  $$SchedulerSettingsTableOrderingComposer({
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

  ColumnOrderings<int> get defaultEventDurationMinutes => $composableBuilder(
    column: $table.defaultEventDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultReminderMinutes => $composableBuilder(
    column: $table.defaultReminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultTaskReminderTime => $composableBuilder(
    column: $table.defaultTaskReminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekStartsOn => $composableBuilder(
    column: $table.weekStartsOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollingHorizonDays => $composableBuilder(
    column: $table.rollingHorizonDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchedulerSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchedulerSettingsTable> {
  $$SchedulerSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get defaultEventDurationMinutes => $composableBuilder(
    column: $table.defaultEventDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultReminderMinutes => $composableBuilder(
    column: $table.defaultReminderMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultTaskReminderTime => $composableBuilder(
    column: $table.defaultTaskReminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weekStartsOn => $composableBuilder(
    column: $table.weekStartsOn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<int> get rollingHorizonDays => $composableBuilder(
    column: $table.rollingHorizonDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SchedulerSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchedulerSettingsTable,
          SchedulerSetting,
          $$SchedulerSettingsTableFilterComposer,
          $$SchedulerSettingsTableOrderingComposer,
          $$SchedulerSettingsTableAnnotationComposer,
          $$SchedulerSettingsTableCreateCompanionBuilder,
          $$SchedulerSettingsTableUpdateCompanionBuilder,
          (
            SchedulerSetting,
            BaseReferences<
              _$AppDatabase,
              $SchedulerSettingsTable,
              SchedulerSetting
            >,
          ),
          SchedulerSetting,
          PrefetchHooks Function()
        > {
  $$SchedulerSettingsTableTableManager(
    _$AppDatabase db,
    $SchedulerSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchedulerSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchedulerSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchedulerSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> defaultEventDurationMinutes = const Value.absent(),
                Value<int> defaultReminderMinutes = const Value.absent(),
                Value<String> defaultTaskReminderTime = const Value.absent(),
                Value<String> weekStartsOn = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<int> rollingHorizonDays = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SchedulerSettingsCompanion(
                id: id,
                defaultEventDurationMinutes: defaultEventDurationMinutes,
                defaultReminderMinutes: defaultReminderMinutes,
                defaultTaskReminderTime: defaultTaskReminderTime,
                weekStartsOn: weekStartsOn,
                timezone: timezone,
                rollingHorizonDays: rollingHorizonDays,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> defaultEventDurationMinutes = const Value.absent(),
                Value<int> defaultReminderMinutes = const Value.absent(),
                Value<String> defaultTaskReminderTime = const Value.absent(),
                Value<String> weekStartsOn = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<int> rollingHorizonDays = const Value.absent(),
                required DateTime updatedAt,
              }) => SchedulerSettingsCompanion.insert(
                id: id,
                defaultEventDurationMinutes: defaultEventDurationMinutes,
                defaultReminderMinutes: defaultReminderMinutes,
                defaultTaskReminderTime: defaultTaskReminderTime,
                weekStartsOn: weekStartsOn,
                timezone: timezone,
                rollingHorizonDays: rollingHorizonDays,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SchedulerSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchedulerSettingsTable,
      SchedulerSetting,
      $$SchedulerSettingsTableFilterComposer,
      $$SchedulerSettingsTableOrderingComposer,
      $$SchedulerSettingsTableAnnotationComposer,
      $$SchedulerSettingsTableCreateCompanionBuilder,
      $$SchedulerSettingsTableUpdateCompanionBuilder,
      (
        SchedulerSetting,
        BaseReferences<
          _$AppDatabase,
          $SchedulerSettingsTable,
          SchedulerSetting
        >,
      ),
      SchedulerSetting,
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
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(_db, _db.financialCategories);
  $$FinancialPeriodsTableTableManager get financialPeriods =>
      $$FinancialPeriodsTableTableManager(_db, _db.financialPeriods);
  $$FinancialTransactionsTableTableManager get financialTransactions =>
      $$FinancialTransactionsTableTableManager(_db, _db.financialTransactions);
  $$FinanceSettingsTableTableManager get financeSettings =>
      $$FinanceSettingsTableTableManager(_db, _db.financeSettings);
  $$ChatDraftsTableTableManager get chatDrafts =>
      $$ChatDraftsTableTableManager(_db, _db.chatDrafts);
  $$ScheduleCategoriesTableTableManager get scheduleCategories =>
      $$ScheduleCategoriesTableTableManager(_db, _db.scheduleCategories);
  $$ScheduleItemsTableTableManager get scheduleItems =>
      $$ScheduleItemsTableTableManager(_db, _db.scheduleItems);
  $$ScheduleRemindersTableTableManager get scheduleReminders =>
      $$ScheduleRemindersTableTableManager(_db, _db.scheduleReminders);
  $$ScheduleNotificationOccurrencesTableTableManager
  get scheduleNotificationOccurrences =>
      $$ScheduleNotificationOccurrencesTableTableManager(
        _db,
        _db.scheduleNotificationOccurrences,
      );
  $$SchedulerSettingsTableTableManager get schedulerSettings =>
      $$SchedulerSettingsTableTableManager(_db, _db.schedulerSettings);
}
