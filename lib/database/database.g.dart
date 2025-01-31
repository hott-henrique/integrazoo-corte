// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BovinesTable extends Bovines with TableInfo<$BovinesTable, Bovine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BovinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _earringMeta =
      const VerificationMeta('earring');
  @override
  late final GeneratedColumn<int> earring = GeneratedColumn<int>(
      'earring', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumnWithTypeConverter<Sex, int> sex =
      GeneratedColumn<int>('sex', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Sex>($BovinesTable.$convertersex);
  static const VerificationMeta _hasBeenWeanedMeta =
      const VerificationMeta('hasBeenWeaned');
  @override
  late final GeneratedColumn<bool> hasBeenWeaned = GeneratedColumn<bool>(
      'has_been_weaned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_been_weaned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isReproducingMeta =
      const VerificationMeta('isReproducing');
  @override
  late final GeneratedColumn<bool> isReproducing = GeneratedColumn<bool>(
      'is_reproducing', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_reproducing" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isPregnantMeta =
      const VerificationMeta('isPregnant');
  @override
  late final GeneratedColumn<bool> isPregnant = GeneratedColumn<bool>(
      'is_pregnant', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pregnant" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _wasDiscardedMeta =
      const VerificationMeta('wasDiscarded');
  @override
  late final GeneratedColumn<bool> wasDiscarded = GeneratedColumn<bool>(
      'was_discarded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("was_discarded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isBreederMeta =
      const VerificationMeta('isBreeder');
  @override
  late final GeneratedColumn<bool> isBreeder = GeneratedColumn<bool>(
      'is_breeder', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_breeder" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _weight540Meta =
      const VerificationMeta('weight540');
  @override
  late final GeneratedColumn<double> weight540 = GeneratedColumn<double>(
      'weight540', aliasedName, true,
      check: () => ComparableExpr(weight540).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        earring,
        name,
        sex,
        hasBeenWeaned,
        isReproducing,
        isPregnant,
        wasDiscarded,
        isBreeder,
        weight540
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bovines';
  @override
  VerificationContext validateIntegrity(Insertable<Bovine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('earring')) {
      context.handle(_earringMeta,
          earring.isAcceptableOrUnknown(data['earring']!, _earringMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    context.handle(_sexMeta, const VerificationResult.success());
    if (data.containsKey('has_been_weaned')) {
      context.handle(
          _hasBeenWeanedMeta,
          hasBeenWeaned.isAcceptableOrUnknown(
              data['has_been_weaned']!, _hasBeenWeanedMeta));
    }
    if (data.containsKey('is_reproducing')) {
      context.handle(
          _isReproducingMeta,
          isReproducing.isAcceptableOrUnknown(
              data['is_reproducing']!, _isReproducingMeta));
    }
    if (data.containsKey('is_pregnant')) {
      context.handle(
          _isPregnantMeta,
          isPregnant.isAcceptableOrUnknown(
              data['is_pregnant']!, _isPregnantMeta));
    }
    if (data.containsKey('was_discarded')) {
      context.handle(
          _wasDiscardedMeta,
          wasDiscarded.isAcceptableOrUnknown(
              data['was_discarded']!, _wasDiscardedMeta));
    }
    if (data.containsKey('is_breeder')) {
      context.handle(_isBreederMeta,
          isBreeder.isAcceptableOrUnknown(data['is_breeder']!, _isBreederMeta));
    }
    if (data.containsKey('weight540')) {
      context.handle(_weight540Meta,
          weight540.isAcceptableOrUnknown(data['weight540']!, _weight540Meta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {earring};
  @override
  Bovine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bovine(
      earring: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}earring'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      sex: $BovinesTable.$convertersex.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sex'])!),
      hasBeenWeaned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_been_weaned'])!,
      isReproducing: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_reproducing'])!,
      isPregnant: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pregnant'])!,
      wasDiscarded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}was_discarded'])!,
      isBreeder: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_breeder'])!,
      weight540: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight540']),
    );
  }

  @override
  $BovinesTable createAlias(String alias) {
    return $BovinesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Sex, int, int> $convertersex =
      const EnumIndexConverter<Sex>(Sex.values);
}

class Bovine extends DataClass implements Insertable<Bovine> {
  final int earring;
  final String? name;
  final Sex sex;
  final bool hasBeenWeaned;
  final bool isReproducing;
  final bool isPregnant;
  final bool wasDiscarded;
  final bool isBreeder;
  final double? weight540;
  const Bovine(
      {required this.earring,
      this.name,
      required this.sex,
      required this.hasBeenWeaned,
      required this.isReproducing,
      required this.isPregnant,
      required this.wasDiscarded,
      required this.isBreeder,
      this.weight540});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['earring'] = Variable<int>(earring);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    {
      map['sex'] = Variable<int>($BovinesTable.$convertersex.toSql(sex));
    }
    map['has_been_weaned'] = Variable<bool>(hasBeenWeaned);
    map['is_reproducing'] = Variable<bool>(isReproducing);
    map['is_pregnant'] = Variable<bool>(isPregnant);
    map['was_discarded'] = Variable<bool>(wasDiscarded);
    map['is_breeder'] = Variable<bool>(isBreeder);
    if (!nullToAbsent || weight540 != null) {
      map['weight540'] = Variable<double>(weight540);
    }
    return map;
  }

  BovinesCompanion toCompanion(bool nullToAbsent) {
    return BovinesCompanion(
      earring: Value(earring),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      sex: Value(sex),
      hasBeenWeaned: Value(hasBeenWeaned),
      isReproducing: Value(isReproducing),
      isPregnant: Value(isPregnant),
      wasDiscarded: Value(wasDiscarded),
      isBreeder: Value(isBreeder),
      weight540: weight540 == null && nullToAbsent
          ? const Value.absent()
          : Value(weight540),
    );
  }

  factory Bovine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bovine(
      earring: serializer.fromJson<int>(json['earring']),
      name: serializer.fromJson<String?>(json['name']),
      sex: $BovinesTable.$convertersex
          .fromJson(serializer.fromJson<int>(json['sex'])),
      hasBeenWeaned: serializer.fromJson<bool>(json['hasBeenWeaned']),
      isReproducing: serializer.fromJson<bool>(json['isReproducing']),
      isPregnant: serializer.fromJson<bool>(json['isPregnant']),
      wasDiscarded: serializer.fromJson<bool>(json['wasDiscarded']),
      isBreeder: serializer.fromJson<bool>(json['isBreeder']),
      weight540: serializer.fromJson<double?>(json['weight540']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'earring': serializer.toJson<int>(earring),
      'name': serializer.toJson<String?>(name),
      'sex': serializer.toJson<int>($BovinesTable.$convertersex.toJson(sex)),
      'hasBeenWeaned': serializer.toJson<bool>(hasBeenWeaned),
      'isReproducing': serializer.toJson<bool>(isReproducing),
      'isPregnant': serializer.toJson<bool>(isPregnant),
      'wasDiscarded': serializer.toJson<bool>(wasDiscarded),
      'isBreeder': serializer.toJson<bool>(isBreeder),
      'weight540': serializer.toJson<double?>(weight540),
    };
  }

  Bovine copyWith(
          {int? earring,
          Value<String?> name = const Value.absent(),
          Sex? sex,
          bool? hasBeenWeaned,
          bool? isReproducing,
          bool? isPregnant,
          bool? wasDiscarded,
          bool? isBreeder,
          Value<double?> weight540 = const Value.absent()}) =>
      Bovine(
        earring: earring ?? this.earring,
        name: name.present ? name.value : this.name,
        sex: sex ?? this.sex,
        hasBeenWeaned: hasBeenWeaned ?? this.hasBeenWeaned,
        isReproducing: isReproducing ?? this.isReproducing,
        isPregnant: isPregnant ?? this.isPregnant,
        wasDiscarded: wasDiscarded ?? this.wasDiscarded,
        isBreeder: isBreeder ?? this.isBreeder,
        weight540: weight540.present ? weight540.value : this.weight540,
      );
  Bovine copyWithCompanion(BovinesCompanion data) {
    return Bovine(
      earring: data.earring.present ? data.earring.value : this.earring,
      name: data.name.present ? data.name.value : this.name,
      sex: data.sex.present ? data.sex.value : this.sex,
      hasBeenWeaned: data.hasBeenWeaned.present
          ? data.hasBeenWeaned.value
          : this.hasBeenWeaned,
      isReproducing: data.isReproducing.present
          ? data.isReproducing.value
          : this.isReproducing,
      isPregnant:
          data.isPregnant.present ? data.isPregnant.value : this.isPregnant,
      wasDiscarded: data.wasDiscarded.present
          ? data.wasDiscarded.value
          : this.wasDiscarded,
      isBreeder: data.isBreeder.present ? data.isBreeder.value : this.isBreeder,
      weight540: data.weight540.present ? data.weight540.value : this.weight540,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bovine(')
          ..write('earring: $earring, ')
          ..write('name: $name, ')
          ..write('sex: $sex, ')
          ..write('hasBeenWeaned: $hasBeenWeaned, ')
          ..write('isReproducing: $isReproducing, ')
          ..write('isPregnant: $isPregnant, ')
          ..write('wasDiscarded: $wasDiscarded, ')
          ..write('isBreeder: $isBreeder, ')
          ..write('weight540: $weight540')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(earring, name, sex, hasBeenWeaned,
      isReproducing, isPregnant, wasDiscarded, isBreeder, weight540);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bovine &&
          other.earring == this.earring &&
          other.name == this.name &&
          other.sex == this.sex &&
          other.hasBeenWeaned == this.hasBeenWeaned &&
          other.isReproducing == this.isReproducing &&
          other.isPregnant == this.isPregnant &&
          other.wasDiscarded == this.wasDiscarded &&
          other.isBreeder == this.isBreeder &&
          other.weight540 == this.weight540);
}

class BovinesCompanion extends UpdateCompanion<Bovine> {
  final Value<int> earring;
  final Value<String?> name;
  final Value<Sex> sex;
  final Value<bool> hasBeenWeaned;
  final Value<bool> isReproducing;
  final Value<bool> isPregnant;
  final Value<bool> wasDiscarded;
  final Value<bool> isBreeder;
  final Value<double?> weight540;
  const BovinesCompanion({
    this.earring = const Value.absent(),
    this.name = const Value.absent(),
    this.sex = const Value.absent(),
    this.hasBeenWeaned = const Value.absent(),
    this.isReproducing = const Value.absent(),
    this.isPregnant = const Value.absent(),
    this.wasDiscarded = const Value.absent(),
    this.isBreeder = const Value.absent(),
    this.weight540 = const Value.absent(),
  });
  BovinesCompanion.insert({
    this.earring = const Value.absent(),
    this.name = const Value.absent(),
    required Sex sex,
    this.hasBeenWeaned = const Value.absent(),
    this.isReproducing = const Value.absent(),
    this.isPregnant = const Value.absent(),
    this.wasDiscarded = const Value.absent(),
    this.isBreeder = const Value.absent(),
    this.weight540 = const Value.absent(),
  }) : sex = Value(sex);
  static Insertable<Bovine> custom({
    Expression<int>? earring,
    Expression<String>? name,
    Expression<int>? sex,
    Expression<bool>? hasBeenWeaned,
    Expression<bool>? isReproducing,
    Expression<bool>? isPregnant,
    Expression<bool>? wasDiscarded,
    Expression<bool>? isBreeder,
    Expression<double>? weight540,
  }) {
    return RawValuesInsertable({
      if (earring != null) 'earring': earring,
      if (name != null) 'name': name,
      if (sex != null) 'sex': sex,
      if (hasBeenWeaned != null) 'has_been_weaned': hasBeenWeaned,
      if (isReproducing != null) 'is_reproducing': isReproducing,
      if (isPregnant != null) 'is_pregnant': isPregnant,
      if (wasDiscarded != null) 'was_discarded': wasDiscarded,
      if (isBreeder != null) 'is_breeder': isBreeder,
      if (weight540 != null) 'weight540': weight540,
    });
  }

  BovinesCompanion copyWith(
      {Value<int>? earring,
      Value<String?>? name,
      Value<Sex>? sex,
      Value<bool>? hasBeenWeaned,
      Value<bool>? isReproducing,
      Value<bool>? isPregnant,
      Value<bool>? wasDiscarded,
      Value<bool>? isBreeder,
      Value<double?>? weight540}) {
    return BovinesCompanion(
      earring: earring ?? this.earring,
      name: name ?? this.name,
      sex: sex ?? this.sex,
      hasBeenWeaned: hasBeenWeaned ?? this.hasBeenWeaned,
      isReproducing: isReproducing ?? this.isReproducing,
      isPregnant: isPregnant ?? this.isPregnant,
      wasDiscarded: wasDiscarded ?? this.wasDiscarded,
      isBreeder: isBreeder ?? this.isBreeder,
      weight540: weight540 ?? this.weight540,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (earring.present) {
      map['earring'] = Variable<int>(earring.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sex.present) {
      map['sex'] = Variable<int>($BovinesTable.$convertersex.toSql(sex.value));
    }
    if (hasBeenWeaned.present) {
      map['has_been_weaned'] = Variable<bool>(hasBeenWeaned.value);
    }
    if (isReproducing.present) {
      map['is_reproducing'] = Variable<bool>(isReproducing.value);
    }
    if (isPregnant.present) {
      map['is_pregnant'] = Variable<bool>(isPregnant.value);
    }
    if (wasDiscarded.present) {
      map['was_discarded'] = Variable<bool>(wasDiscarded.value);
    }
    if (isBreeder.present) {
      map['is_breeder'] = Variable<bool>(isBreeder.value);
    }
    if (weight540.present) {
      map['weight540'] = Variable<double>(weight540.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BovinesCompanion(')
          ..write('earring: $earring, ')
          ..write('name: $name, ')
          ..write('sex: $sex, ')
          ..write('hasBeenWeaned: $hasBeenWeaned, ')
          ..write('isReproducing: $isReproducing, ')
          ..write('isPregnant: $isPregnant, ')
          ..write('wasDiscarded: $wasDiscarded, ')
          ..write('isBreeder: $isBreeder, ')
          ..write('weight540: $weight540')
          ..write(')'))
        .toString();
  }
}

class $BovinesEntryTable extends BovinesEntry
    with TableInfo<$BovinesEntryTable, BovineEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BovinesEntryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      check: () => ComparableExpr(weight).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [bovine, weight, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bovines_entry';
  @override
  VerificationContext validateIntegrity(Insertable<BovineEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bovine};
  @override
  BovineEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BovineEntry(
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date']),
    );
  }

  @override
  $BovinesEntryTable createAlias(String alias) {
    return $BovinesEntryTable(attachedDatabase, alias);
  }
}

class BovineEntry extends DataClass implements Insertable<BovineEntry> {
  final int bovine;
  final double? weight;
  final DateTime? date;
  const BovineEntry({required this.bovine, this.weight, this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bovine'] = Variable<int>(bovine);
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  BovinesEntryCompanion toCompanion(bool nullToAbsent) {
    return BovinesEntryCompanion(
      bovine: Value(bovine),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory BovineEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BovineEntry(
      bovine: serializer.fromJson<int>(json['bovine']),
      weight: serializer.fromJson<double?>(json['weight']),
      date: serializer.fromJson<DateTime?>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bovine': serializer.toJson<int>(bovine),
      'weight': serializer.toJson<double?>(weight),
      'date': serializer.toJson<DateTime?>(date),
    };
  }

  BovineEntry copyWith(
          {int? bovine,
          Value<double?> weight = const Value.absent(),
          Value<DateTime?> date = const Value.absent()}) =>
      BovineEntry(
        bovine: bovine ?? this.bovine,
        weight: weight.present ? weight.value : this.weight,
        date: date.present ? date.value : this.date,
      );
  BovineEntry copyWithCompanion(BovinesEntryCompanion data) {
    return BovineEntry(
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
      weight: data.weight.present ? data.weight.value : this.weight,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BovineEntry(')
          ..write('bovine: $bovine, ')
          ..write('weight: $weight, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bovine, weight, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BovineEntry &&
          other.bovine == this.bovine &&
          other.weight == this.weight &&
          other.date == this.date);
}

class BovinesEntryCompanion extends UpdateCompanion<BovineEntry> {
  final Value<int> bovine;
  final Value<double?> weight;
  final Value<DateTime?> date;
  const BovinesEntryCompanion({
    this.bovine = const Value.absent(),
    this.weight = const Value.absent(),
    this.date = const Value.absent(),
  });
  BovinesEntryCompanion.insert({
    this.bovine = const Value.absent(),
    this.weight = const Value.absent(),
    this.date = const Value.absent(),
  });
  static Insertable<BovineEntry> custom({
    Expression<int>? bovine,
    Expression<double>? weight,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (bovine != null) 'bovine': bovine,
      if (weight != null) 'weight': weight,
      if (date != null) 'date': date,
    });
  }

  BovinesEntryCompanion copyWith(
      {Value<int>? bovine, Value<double?>? weight, Value<DateTime?>? date}) {
    return BovinesEntryCompanion(
      bovine: bovine ?? this.bovine,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BovinesEntryCompanion(')
          ..write('bovine: $bovine, ')
          ..write('weight: $weight, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $BreedersTable extends Breeders with TableInfo<$BreedersTable, Breeder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BreedersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fatherMeta = const VerificationMeta('father');
  @override
  late final GeneratedColumn<String> father = GeneratedColumn<String>(
      'father', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _motherMeta = const VerificationMeta('mother');
  @override
  late final GeneratedColumn<String> mother = GeneratedColumn<String>(
      'mother', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paternalGrandmotherMeta =
      const VerificationMeta('paternalGrandmother');
  @override
  late final GeneratedColumn<String> paternalGrandmother =
      GeneratedColumn<String>('paternal_grandmother', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paternalGrandfatherMeta =
      const VerificationMeta('paternalGrandfather');
  @override
  late final GeneratedColumn<String> paternalGrandfather =
      GeneratedColumn<String>('paternal_grandfather', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maternalGrandmotherMeta =
      const VerificationMeta('maternalGrandmother');
  @override
  late final GeneratedColumn<String> maternalGrandmother =
      GeneratedColumn<String>('maternal_grandmother', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maternalGrandfatherMeta =
      const VerificationMeta('maternalGrandfather');
  @override
  late final GeneratedColumn<String> maternalGrandfather =
      GeneratedColumn<String>('maternal_grandfather', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _epdBirthWeightMeta =
      const VerificationMeta('epdBirthWeight');
  @override
  late final GeneratedColumn<double> epdBirthWeight = GeneratedColumn<double>(
      'epd_birth_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _epdWeaningWeightMeta =
      const VerificationMeta('epdWeaningWeight');
  @override
  late final GeneratedColumn<double> epdWeaningWeight = GeneratedColumn<double>(
      'epd_weaning_weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _epdYearlingWeightMeta =
      const VerificationMeta('epdYearlingWeight');
  @override
  late final GeneratedColumn<double> epdYearlingWeight =
      GeneratedColumn<double>('epd_yearling_weight', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        father,
        mother,
        paternalGrandmother,
        paternalGrandfather,
        maternalGrandmother,
        maternalGrandfather,
        epdBirthWeight,
        epdWeaningWeight,
        epdYearlingWeight
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'breeders';
  @override
  VerificationContext validateIntegrity(Insertable<Breeder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('father')) {
      context.handle(_fatherMeta,
          father.isAcceptableOrUnknown(data['father']!, _fatherMeta));
    }
    if (data.containsKey('mother')) {
      context.handle(_motherMeta,
          mother.isAcceptableOrUnknown(data['mother']!, _motherMeta));
    }
    if (data.containsKey('paternal_grandmother')) {
      context.handle(
          _paternalGrandmotherMeta,
          paternalGrandmother.isAcceptableOrUnknown(
              data['paternal_grandmother']!, _paternalGrandmotherMeta));
    }
    if (data.containsKey('paternal_grandfather')) {
      context.handle(
          _paternalGrandfatherMeta,
          paternalGrandfather.isAcceptableOrUnknown(
              data['paternal_grandfather']!, _paternalGrandfatherMeta));
    }
    if (data.containsKey('maternal_grandmother')) {
      context.handle(
          _maternalGrandmotherMeta,
          maternalGrandmother.isAcceptableOrUnknown(
              data['maternal_grandmother']!, _maternalGrandmotherMeta));
    }
    if (data.containsKey('maternal_grandfather')) {
      context.handle(
          _maternalGrandfatherMeta,
          maternalGrandfather.isAcceptableOrUnknown(
              data['maternal_grandfather']!, _maternalGrandfatherMeta));
    }
    if (data.containsKey('epd_birth_weight')) {
      context.handle(
          _epdBirthWeightMeta,
          epdBirthWeight.isAcceptableOrUnknown(
              data['epd_birth_weight']!, _epdBirthWeightMeta));
    }
    if (data.containsKey('epd_weaning_weight')) {
      context.handle(
          _epdWeaningWeightMeta,
          epdWeaningWeight.isAcceptableOrUnknown(
              data['epd_weaning_weight']!, _epdWeaningWeightMeta));
    }
    if (data.containsKey('epd_yearling_weight')) {
      context.handle(
          _epdYearlingWeightMeta,
          epdYearlingWeight.isAcceptableOrUnknown(
              data['epd_yearling_weight']!, _epdYearlingWeightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Breeder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Breeder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      father: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}father']),
      mother: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mother']),
      paternalGrandmother: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}paternal_grandmother']),
      paternalGrandfather: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}paternal_grandfather']),
      maternalGrandmother: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}maternal_grandmother']),
      maternalGrandfather: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}maternal_grandfather']),
      epdBirthWeight: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}epd_birth_weight']),
      epdWeaningWeight: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}epd_weaning_weight']),
      epdYearlingWeight: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}epd_yearling_weight']),
    );
  }

  @override
  $BreedersTable createAlias(String alias) {
    return $BreedersTable(attachedDatabase, alias);
  }
}

class Breeder extends DataClass implements Insertable<Breeder> {
  final int id;
  final String name;
  final String? father;
  final String? mother;
  final String? paternalGrandmother;
  final String? paternalGrandfather;
  final String? maternalGrandmother;
  final String? maternalGrandfather;
  final double? epdBirthWeight;
  final double? epdWeaningWeight;
  final double? epdYearlingWeight;
  const Breeder(
      {required this.id,
      required this.name,
      this.father,
      this.mother,
      this.paternalGrandmother,
      this.paternalGrandfather,
      this.maternalGrandmother,
      this.maternalGrandfather,
      this.epdBirthWeight,
      this.epdWeaningWeight,
      this.epdYearlingWeight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || father != null) {
      map['father'] = Variable<String>(father);
    }
    if (!nullToAbsent || mother != null) {
      map['mother'] = Variable<String>(mother);
    }
    if (!nullToAbsent || paternalGrandmother != null) {
      map['paternal_grandmother'] = Variable<String>(paternalGrandmother);
    }
    if (!nullToAbsent || paternalGrandfather != null) {
      map['paternal_grandfather'] = Variable<String>(paternalGrandfather);
    }
    if (!nullToAbsent || maternalGrandmother != null) {
      map['maternal_grandmother'] = Variable<String>(maternalGrandmother);
    }
    if (!nullToAbsent || maternalGrandfather != null) {
      map['maternal_grandfather'] = Variable<String>(maternalGrandfather);
    }
    if (!nullToAbsent || epdBirthWeight != null) {
      map['epd_birth_weight'] = Variable<double>(epdBirthWeight);
    }
    if (!nullToAbsent || epdWeaningWeight != null) {
      map['epd_weaning_weight'] = Variable<double>(epdWeaningWeight);
    }
    if (!nullToAbsent || epdYearlingWeight != null) {
      map['epd_yearling_weight'] = Variable<double>(epdYearlingWeight);
    }
    return map;
  }

  BreedersCompanion toCompanion(bool nullToAbsent) {
    return BreedersCompanion(
      id: Value(id),
      name: Value(name),
      father:
          father == null && nullToAbsent ? const Value.absent() : Value(father),
      mother:
          mother == null && nullToAbsent ? const Value.absent() : Value(mother),
      paternalGrandmother: paternalGrandmother == null && nullToAbsent
          ? const Value.absent()
          : Value(paternalGrandmother),
      paternalGrandfather: paternalGrandfather == null && nullToAbsent
          ? const Value.absent()
          : Value(paternalGrandfather),
      maternalGrandmother: maternalGrandmother == null && nullToAbsent
          ? const Value.absent()
          : Value(maternalGrandmother),
      maternalGrandfather: maternalGrandfather == null && nullToAbsent
          ? const Value.absent()
          : Value(maternalGrandfather),
      epdBirthWeight: epdBirthWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(epdBirthWeight),
      epdWeaningWeight: epdWeaningWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(epdWeaningWeight),
      epdYearlingWeight: epdYearlingWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(epdYearlingWeight),
    );
  }

  factory Breeder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Breeder(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      father: serializer.fromJson<String?>(json['father']),
      mother: serializer.fromJson<String?>(json['mother']),
      paternalGrandmother:
          serializer.fromJson<String?>(json['paternalGrandmother']),
      paternalGrandfather:
          serializer.fromJson<String?>(json['paternalGrandfather']),
      maternalGrandmother:
          serializer.fromJson<String?>(json['maternalGrandmother']),
      maternalGrandfather:
          serializer.fromJson<String?>(json['maternalGrandfather']),
      epdBirthWeight: serializer.fromJson<double?>(json['epdBirthWeight']),
      epdWeaningWeight: serializer.fromJson<double?>(json['epdWeaningWeight']),
      epdYearlingWeight:
          serializer.fromJson<double?>(json['epdYearlingWeight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'father': serializer.toJson<String?>(father),
      'mother': serializer.toJson<String?>(mother),
      'paternalGrandmother': serializer.toJson<String?>(paternalGrandmother),
      'paternalGrandfather': serializer.toJson<String?>(paternalGrandfather),
      'maternalGrandmother': serializer.toJson<String?>(maternalGrandmother),
      'maternalGrandfather': serializer.toJson<String?>(maternalGrandfather),
      'epdBirthWeight': serializer.toJson<double?>(epdBirthWeight),
      'epdWeaningWeight': serializer.toJson<double?>(epdWeaningWeight),
      'epdYearlingWeight': serializer.toJson<double?>(epdYearlingWeight),
    };
  }

  Breeder copyWith(
          {int? id,
          String? name,
          Value<String?> father = const Value.absent(),
          Value<String?> mother = const Value.absent(),
          Value<String?> paternalGrandmother = const Value.absent(),
          Value<String?> paternalGrandfather = const Value.absent(),
          Value<String?> maternalGrandmother = const Value.absent(),
          Value<String?> maternalGrandfather = const Value.absent(),
          Value<double?> epdBirthWeight = const Value.absent(),
          Value<double?> epdWeaningWeight = const Value.absent(),
          Value<double?> epdYearlingWeight = const Value.absent()}) =>
      Breeder(
        id: id ?? this.id,
        name: name ?? this.name,
        father: father.present ? father.value : this.father,
        mother: mother.present ? mother.value : this.mother,
        paternalGrandmother: paternalGrandmother.present
            ? paternalGrandmother.value
            : this.paternalGrandmother,
        paternalGrandfather: paternalGrandfather.present
            ? paternalGrandfather.value
            : this.paternalGrandfather,
        maternalGrandmother: maternalGrandmother.present
            ? maternalGrandmother.value
            : this.maternalGrandmother,
        maternalGrandfather: maternalGrandfather.present
            ? maternalGrandfather.value
            : this.maternalGrandfather,
        epdBirthWeight:
            epdBirthWeight.present ? epdBirthWeight.value : this.epdBirthWeight,
        epdWeaningWeight: epdWeaningWeight.present
            ? epdWeaningWeight.value
            : this.epdWeaningWeight,
        epdYearlingWeight: epdYearlingWeight.present
            ? epdYearlingWeight.value
            : this.epdYearlingWeight,
      );
  Breeder copyWithCompanion(BreedersCompanion data) {
    return Breeder(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      father: data.father.present ? data.father.value : this.father,
      mother: data.mother.present ? data.mother.value : this.mother,
      paternalGrandmother: data.paternalGrandmother.present
          ? data.paternalGrandmother.value
          : this.paternalGrandmother,
      paternalGrandfather: data.paternalGrandfather.present
          ? data.paternalGrandfather.value
          : this.paternalGrandfather,
      maternalGrandmother: data.maternalGrandmother.present
          ? data.maternalGrandmother.value
          : this.maternalGrandmother,
      maternalGrandfather: data.maternalGrandfather.present
          ? data.maternalGrandfather.value
          : this.maternalGrandfather,
      epdBirthWeight: data.epdBirthWeight.present
          ? data.epdBirthWeight.value
          : this.epdBirthWeight,
      epdWeaningWeight: data.epdWeaningWeight.present
          ? data.epdWeaningWeight.value
          : this.epdWeaningWeight,
      epdYearlingWeight: data.epdYearlingWeight.present
          ? data.epdYearlingWeight.value
          : this.epdYearlingWeight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Breeder(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('father: $father, ')
          ..write('mother: $mother, ')
          ..write('paternalGrandmother: $paternalGrandmother, ')
          ..write('paternalGrandfather: $paternalGrandfather, ')
          ..write('maternalGrandmother: $maternalGrandmother, ')
          ..write('maternalGrandfather: $maternalGrandfather, ')
          ..write('epdBirthWeight: $epdBirthWeight, ')
          ..write('epdWeaningWeight: $epdWeaningWeight, ')
          ..write('epdYearlingWeight: $epdYearlingWeight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      father,
      mother,
      paternalGrandmother,
      paternalGrandfather,
      maternalGrandmother,
      maternalGrandfather,
      epdBirthWeight,
      epdWeaningWeight,
      epdYearlingWeight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Breeder &&
          other.id == this.id &&
          other.name == this.name &&
          other.father == this.father &&
          other.mother == this.mother &&
          other.paternalGrandmother == this.paternalGrandmother &&
          other.paternalGrandfather == this.paternalGrandfather &&
          other.maternalGrandmother == this.maternalGrandmother &&
          other.maternalGrandfather == this.maternalGrandfather &&
          other.epdBirthWeight == this.epdBirthWeight &&
          other.epdWeaningWeight == this.epdWeaningWeight &&
          other.epdYearlingWeight == this.epdYearlingWeight);
}

class BreedersCompanion extends UpdateCompanion<Breeder> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> father;
  final Value<String?> mother;
  final Value<String?> paternalGrandmother;
  final Value<String?> paternalGrandfather;
  final Value<String?> maternalGrandmother;
  final Value<String?> maternalGrandfather;
  final Value<double?> epdBirthWeight;
  final Value<double?> epdWeaningWeight;
  final Value<double?> epdYearlingWeight;
  const BreedersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.father = const Value.absent(),
    this.mother = const Value.absent(),
    this.paternalGrandmother = const Value.absent(),
    this.paternalGrandfather = const Value.absent(),
    this.maternalGrandmother = const Value.absent(),
    this.maternalGrandfather = const Value.absent(),
    this.epdBirthWeight = const Value.absent(),
    this.epdWeaningWeight = const Value.absent(),
    this.epdYearlingWeight = const Value.absent(),
  });
  BreedersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.father = const Value.absent(),
    this.mother = const Value.absent(),
    this.paternalGrandmother = const Value.absent(),
    this.paternalGrandfather = const Value.absent(),
    this.maternalGrandmother = const Value.absent(),
    this.maternalGrandfather = const Value.absent(),
    this.epdBirthWeight = const Value.absent(),
    this.epdWeaningWeight = const Value.absent(),
    this.epdYearlingWeight = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Breeder> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? father,
    Expression<String>? mother,
    Expression<String>? paternalGrandmother,
    Expression<String>? paternalGrandfather,
    Expression<String>? maternalGrandmother,
    Expression<String>? maternalGrandfather,
    Expression<double>? epdBirthWeight,
    Expression<double>? epdWeaningWeight,
    Expression<double>? epdYearlingWeight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (father != null) 'father': father,
      if (mother != null) 'mother': mother,
      if (paternalGrandmother != null)
        'paternal_grandmother': paternalGrandmother,
      if (paternalGrandfather != null)
        'paternal_grandfather': paternalGrandfather,
      if (maternalGrandmother != null)
        'maternal_grandmother': maternalGrandmother,
      if (maternalGrandfather != null)
        'maternal_grandfather': maternalGrandfather,
      if (epdBirthWeight != null) 'epd_birth_weight': epdBirthWeight,
      if (epdWeaningWeight != null) 'epd_weaning_weight': epdWeaningWeight,
      if (epdYearlingWeight != null) 'epd_yearling_weight': epdYearlingWeight,
    });
  }

  BreedersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? father,
      Value<String?>? mother,
      Value<String?>? paternalGrandmother,
      Value<String?>? paternalGrandfather,
      Value<String?>? maternalGrandmother,
      Value<String?>? maternalGrandfather,
      Value<double?>? epdBirthWeight,
      Value<double?>? epdWeaningWeight,
      Value<double?>? epdYearlingWeight}) {
    return BreedersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      father: father ?? this.father,
      mother: mother ?? this.mother,
      paternalGrandmother: paternalGrandmother ?? this.paternalGrandmother,
      paternalGrandfather: paternalGrandfather ?? this.paternalGrandfather,
      maternalGrandmother: maternalGrandmother ?? this.maternalGrandmother,
      maternalGrandfather: maternalGrandfather ?? this.maternalGrandfather,
      epdBirthWeight: epdBirthWeight ?? this.epdBirthWeight,
      epdWeaningWeight: epdWeaningWeight ?? this.epdWeaningWeight,
      epdYearlingWeight: epdYearlingWeight ?? this.epdYearlingWeight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (father.present) {
      map['father'] = Variable<String>(father.value);
    }
    if (mother.present) {
      map['mother'] = Variable<String>(mother.value);
    }
    if (paternalGrandmother.present) {
      map['paternal_grandmother'] = Variable<String>(paternalGrandmother.value);
    }
    if (paternalGrandfather.present) {
      map['paternal_grandfather'] = Variable<String>(paternalGrandfather.value);
    }
    if (maternalGrandmother.present) {
      map['maternal_grandmother'] = Variable<String>(maternalGrandmother.value);
    }
    if (maternalGrandfather.present) {
      map['maternal_grandfather'] = Variable<String>(maternalGrandfather.value);
    }
    if (epdBirthWeight.present) {
      map['epd_birth_weight'] = Variable<double>(epdBirthWeight.value);
    }
    if (epdWeaningWeight.present) {
      map['epd_weaning_weight'] = Variable<double>(epdWeaningWeight.value);
    }
    if (epdYearlingWeight.present) {
      map['epd_yearling_weight'] = Variable<double>(epdYearlingWeight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BreedersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('father: $father, ')
          ..write('mother: $mother, ')
          ..write('paternalGrandmother: $paternalGrandmother, ')
          ..write('paternalGrandfather: $paternalGrandfather, ')
          ..write('maternalGrandmother: $maternalGrandmother, ')
          ..write('maternalGrandfather: $maternalGrandfather, ')
          ..write('epdBirthWeight: $epdBirthWeight, ')
          ..write('epdWeaningWeight: $epdWeaningWeight, ')
          ..write('epdYearlingWeight: $epdYearlingWeight')
          ..write(')'))
        .toString();
  }
}

class $DiscardsTable extends Discards with TableInfo<$DiscardsTable, Discard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumnWithTypeConverter<DiscardReason, int> reason =
      GeneratedColumn<int>('reason', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<DiscardReason>($DiscardsTable.$converterreason);
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      check: () => ComparableExpr(weight).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [bovine, date, reason, observation, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discards';
  @override
  VerificationContext validateIntegrity(Insertable<Discard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    context.handle(_reasonMeta, const VerificationResult.success());
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bovine};
  @override
  Discard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Discard(
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      reason: $DiscardsTable.$converterreason.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reason'])!),
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
    );
  }

  @override
  $DiscardsTable createAlias(String alias) {
    return $DiscardsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DiscardReason, int, int> $converterreason =
      const EnumIndexConverter<DiscardReason>(DiscardReason.values);
}

class Discard extends DataClass implements Insertable<Discard> {
  final int bovine;
  final DateTime date;
  final DiscardReason reason;
  final String? observation;
  final double? weight;
  const Discard(
      {required this.bovine,
      required this.date,
      required this.reason,
      this.observation,
      this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bovine'] = Variable<int>(bovine);
    map['date'] = Variable<DateTime>(date);
    {
      map['reason'] =
          Variable<int>($DiscardsTable.$converterreason.toSql(reason));
    }
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    return map;
  }

  DiscardsCompanion toCompanion(bool nullToAbsent) {
    return DiscardsCompanion(
      bovine: Value(bovine),
      date: Value(date),
      reason: Value(reason),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
    );
  }

  factory Discard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Discard(
      bovine: serializer.fromJson<int>(json['bovine']),
      date: serializer.fromJson<DateTime>(json['date']),
      reason: $DiscardsTable.$converterreason
          .fromJson(serializer.fromJson<int>(json['reason'])),
      observation: serializer.fromJson<String?>(json['observation']),
      weight: serializer.fromJson<double?>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bovine': serializer.toJson<int>(bovine),
      'date': serializer.toJson<DateTime>(date),
      'reason': serializer
          .toJson<int>($DiscardsTable.$converterreason.toJson(reason)),
      'observation': serializer.toJson<String?>(observation),
      'weight': serializer.toJson<double?>(weight),
    };
  }

  Discard copyWith(
          {int? bovine,
          DateTime? date,
          DiscardReason? reason,
          Value<String?> observation = const Value.absent(),
          Value<double?> weight = const Value.absent()}) =>
      Discard(
        bovine: bovine ?? this.bovine,
        date: date ?? this.date,
        reason: reason ?? this.reason,
        observation: observation.present ? observation.value : this.observation,
        weight: weight.present ? weight.value : this.weight,
      );
  Discard copyWithCompanion(DiscardsCompanion data) {
    return Discard(
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
      date: data.date.present ? data.date.value : this.date,
      reason: data.reason.present ? data.reason.value : this.reason,
      observation:
          data.observation.present ? data.observation.value : this.observation,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Discard(')
          ..write('bovine: $bovine, ')
          ..write('date: $date, ')
          ..write('reason: $reason, ')
          ..write('observation: $observation, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bovine, date, reason, observation, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Discard &&
          other.bovine == this.bovine &&
          other.date == this.date &&
          other.reason == this.reason &&
          other.observation == this.observation &&
          other.weight == this.weight);
}

class DiscardsCompanion extends UpdateCompanion<Discard> {
  final Value<int> bovine;
  final Value<DateTime> date;
  final Value<DiscardReason> reason;
  final Value<String?> observation;
  final Value<double?> weight;
  const DiscardsCompanion({
    this.bovine = const Value.absent(),
    this.date = const Value.absent(),
    this.reason = const Value.absent(),
    this.observation = const Value.absent(),
    this.weight = const Value.absent(),
  });
  DiscardsCompanion.insert({
    this.bovine = const Value.absent(),
    required DateTime date,
    required DiscardReason reason,
    this.observation = const Value.absent(),
    this.weight = const Value.absent(),
  })  : date = Value(date),
        reason = Value(reason);
  static Insertable<Discard> custom({
    Expression<int>? bovine,
    Expression<DateTime>? date,
    Expression<int>? reason,
    Expression<String>? observation,
    Expression<double>? weight,
  }) {
    return RawValuesInsertable({
      if (bovine != null) 'bovine': bovine,
      if (date != null) 'date': date,
      if (reason != null) 'reason': reason,
      if (observation != null) 'observation': observation,
      if (weight != null) 'weight': weight,
    });
  }

  DiscardsCompanion copyWith(
      {Value<int>? bovine,
      Value<DateTime>? date,
      Value<DiscardReason>? reason,
      Value<String?>? observation,
      Value<double?>? weight}) {
    return DiscardsCompanion(
      bovine: bovine ?? this.bovine,
      date: date ?? this.date,
      reason: reason ?? this.reason,
      observation: observation ?? this.observation,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (reason.present) {
      map['reason'] =
          Variable<int>($DiscardsTable.$converterreason.toSql(reason.value));
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscardsCompanion(')
          ..write('bovine: $bovine, ')
          ..write('date: $date, ')
          ..write('reason: $reason, ')
          ..write('observation: $observation, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

class $ReproductionsTable extends Reproductions
    with TableInfo<$ReproductionsTable, Reproduction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReproductionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumnWithTypeConverter<ReproductionKind, int> kind =
      GeneratedColumn<int>('kind', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ReproductionKind>($ReproductionsTable.$converterkind);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _diagnosticMeta =
      const VerificationMeta('diagnostic');
  @override
  late final GeneratedColumnWithTypeConverter<ReproductionDiagonostic, int>
      diagnostic = GeneratedColumn<int>('diagnostic', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: Constant(ReproductionDiagonostic.waiting.index))
          .withConverter<ReproductionDiagonostic>(
              $ReproductionsTable.$converterdiagnostic);
  static const VerificationMeta _cowMeta = const VerificationMeta('cow');
  @override
  late final GeneratedColumn<int> cow = GeneratedColumn<int>(
      'cow', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  static const VerificationMeta _bullMeta = const VerificationMeta('bull');
  @override
  late final GeneratedColumn<int> bull = GeneratedColumn<int>(
      'bull', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE SET NULL'));
  static const VerificationMeta _breederMeta =
      const VerificationMeta('breeder');
  @override
  late final GeneratedColumn<String> breeder = GeneratedColumn<String>(
      'breeder', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES breeders (name) ON DELETE SET NULL'));
  static const VerificationMeta _strawNumberMeta =
      const VerificationMeta('strawNumber');
  @override
  late final GeneratedColumn<int> strawNumber = GeneratedColumn<int>(
      'straw_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, kind, date, diagnostic, cow, bull, breeder, strawNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reproductions';
  @override
  VerificationContext validateIntegrity(Insertable<Reproduction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_kindMeta, const VerificationResult.success());
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    context.handle(_diagnosticMeta, const VerificationResult.success());
    if (data.containsKey('cow')) {
      context.handle(
          _cowMeta, cow.isAcceptableOrUnknown(data['cow']!, _cowMeta));
    } else if (isInserting) {
      context.missing(_cowMeta);
    }
    if (data.containsKey('bull')) {
      context.handle(
          _bullMeta, bull.isAcceptableOrUnknown(data['bull']!, _bullMeta));
    }
    if (data.containsKey('breeder')) {
      context.handle(_breederMeta,
          breeder.isAcceptableOrUnknown(data['breeder']!, _breederMeta));
    }
    if (data.containsKey('straw_number')) {
      context.handle(
          _strawNumberMeta,
          strawNumber.isAcceptableOrUnknown(
              data['straw_number']!, _strawNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reproduction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reproduction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kind: $ReproductionsTable.$converterkind.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kind'])!),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      diagnostic: $ReproductionsTable.$converterdiagnostic.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}diagnostic'])!),
      cow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cow'])!,
      bull: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bull']),
      breeder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}breeder']),
      strawNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}straw_number']),
    );
  }

  @override
  $ReproductionsTable createAlias(String alias) {
    return $ReproductionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReproductionKind, int, int> $converterkind =
      const EnumIndexConverter<ReproductionKind>(ReproductionKind.values);
  static JsonTypeConverter2<ReproductionDiagonostic, int, int>
      $converterdiagnostic = const EnumIndexConverter<ReproductionDiagonostic>(
          ReproductionDiagonostic.values);
}

class Reproduction extends DataClass implements Insertable<Reproduction> {
  final int id;
  final ReproductionKind kind;
  final DateTime date;
  final ReproductionDiagonostic diagnostic;
  final int cow;
  final int? bull;
  final String? breeder;
  final int? strawNumber;
  const Reproduction(
      {required this.id,
      required this.kind,
      required this.date,
      required this.diagnostic,
      required this.cow,
      this.bull,
      this.breeder,
      this.strawNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['kind'] =
          Variable<int>($ReproductionsTable.$converterkind.toSql(kind));
    }
    map['date'] = Variable<DateTime>(date);
    {
      map['diagnostic'] = Variable<int>(
          $ReproductionsTable.$converterdiagnostic.toSql(diagnostic));
    }
    map['cow'] = Variable<int>(cow);
    if (!nullToAbsent || bull != null) {
      map['bull'] = Variable<int>(bull);
    }
    if (!nullToAbsent || breeder != null) {
      map['breeder'] = Variable<String>(breeder);
    }
    if (!nullToAbsent || strawNumber != null) {
      map['straw_number'] = Variable<int>(strawNumber);
    }
    return map;
  }

  ReproductionsCompanion toCompanion(bool nullToAbsent) {
    return ReproductionsCompanion(
      id: Value(id),
      kind: Value(kind),
      date: Value(date),
      diagnostic: Value(diagnostic),
      cow: Value(cow),
      bull: bull == null && nullToAbsent ? const Value.absent() : Value(bull),
      breeder: breeder == null && nullToAbsent
          ? const Value.absent()
          : Value(breeder),
      strawNumber: strawNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(strawNumber),
    );
  }

  factory Reproduction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reproduction(
      id: serializer.fromJson<int>(json['id']),
      kind: $ReproductionsTable.$converterkind
          .fromJson(serializer.fromJson<int>(json['kind'])),
      date: serializer.fromJson<DateTime>(json['date']),
      diagnostic: $ReproductionsTable.$converterdiagnostic
          .fromJson(serializer.fromJson<int>(json['diagnostic'])),
      cow: serializer.fromJson<int>(json['cow']),
      bull: serializer.fromJson<int?>(json['bull']),
      breeder: serializer.fromJson<String?>(json['breeder']),
      strawNumber: serializer.fromJson<int?>(json['strawNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer
          .toJson<int>($ReproductionsTable.$converterkind.toJson(kind)),
      'date': serializer.toJson<DateTime>(date),
      'diagnostic': serializer.toJson<int>(
          $ReproductionsTable.$converterdiagnostic.toJson(diagnostic)),
      'cow': serializer.toJson<int>(cow),
      'bull': serializer.toJson<int?>(bull),
      'breeder': serializer.toJson<String?>(breeder),
      'strawNumber': serializer.toJson<int?>(strawNumber),
    };
  }

  Reproduction copyWith(
          {int? id,
          ReproductionKind? kind,
          DateTime? date,
          ReproductionDiagonostic? diagnostic,
          int? cow,
          Value<int?> bull = const Value.absent(),
          Value<String?> breeder = const Value.absent(),
          Value<int?> strawNumber = const Value.absent()}) =>
      Reproduction(
        id: id ?? this.id,
        kind: kind ?? this.kind,
        date: date ?? this.date,
        diagnostic: diagnostic ?? this.diagnostic,
        cow: cow ?? this.cow,
        bull: bull.present ? bull.value : this.bull,
        breeder: breeder.present ? breeder.value : this.breeder,
        strawNumber: strawNumber.present ? strawNumber.value : this.strawNumber,
      );
  Reproduction copyWithCompanion(ReproductionsCompanion data) {
    return Reproduction(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      date: data.date.present ? data.date.value : this.date,
      diagnostic:
          data.diagnostic.present ? data.diagnostic.value : this.diagnostic,
      cow: data.cow.present ? data.cow.value : this.cow,
      bull: data.bull.present ? data.bull.value : this.bull,
      breeder: data.breeder.present ? data.breeder.value : this.breeder,
      strawNumber:
          data.strawNumber.present ? data.strawNumber.value : this.strawNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reproduction(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('date: $date, ')
          ..write('diagnostic: $diagnostic, ')
          ..write('cow: $cow, ')
          ..write('bull: $bull, ')
          ..write('breeder: $breeder, ')
          ..write('strawNumber: $strawNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, kind, date, diagnostic, cow, bull, breeder, strawNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reproduction &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.date == this.date &&
          other.diagnostic == this.diagnostic &&
          other.cow == this.cow &&
          other.bull == this.bull &&
          other.breeder == this.breeder &&
          other.strawNumber == this.strawNumber);
}

class ReproductionsCompanion extends UpdateCompanion<Reproduction> {
  final Value<int> id;
  final Value<ReproductionKind> kind;
  final Value<DateTime> date;
  final Value<ReproductionDiagonostic> diagnostic;
  final Value<int> cow;
  final Value<int?> bull;
  final Value<String?> breeder;
  final Value<int?> strawNumber;
  const ReproductionsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.date = const Value.absent(),
    this.diagnostic = const Value.absent(),
    this.cow = const Value.absent(),
    this.bull = const Value.absent(),
    this.breeder = const Value.absent(),
    this.strawNumber = const Value.absent(),
  });
  ReproductionsCompanion.insert({
    this.id = const Value.absent(),
    required ReproductionKind kind,
    required DateTime date,
    this.diagnostic = const Value.absent(),
    required int cow,
    this.bull = const Value.absent(),
    this.breeder = const Value.absent(),
    this.strawNumber = const Value.absent(),
  })  : kind = Value(kind),
        date = Value(date),
        cow = Value(cow);
  static Insertable<Reproduction> custom({
    Expression<int>? id,
    Expression<int>? kind,
    Expression<DateTime>? date,
    Expression<int>? diagnostic,
    Expression<int>? cow,
    Expression<int>? bull,
    Expression<String>? breeder,
    Expression<int>? strawNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (date != null) 'date': date,
      if (diagnostic != null) 'diagnostic': diagnostic,
      if (cow != null) 'cow': cow,
      if (bull != null) 'bull': bull,
      if (breeder != null) 'breeder': breeder,
      if (strawNumber != null) 'straw_number': strawNumber,
    });
  }

  ReproductionsCompanion copyWith(
      {Value<int>? id,
      Value<ReproductionKind>? kind,
      Value<DateTime>? date,
      Value<ReproductionDiagonostic>? diagnostic,
      Value<int>? cow,
      Value<int?>? bull,
      Value<String?>? breeder,
      Value<int?>? strawNumber}) {
    return ReproductionsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      date: date ?? this.date,
      diagnostic: diagnostic ?? this.diagnostic,
      cow: cow ?? this.cow,
      bull: bull ?? this.bull,
      breeder: breeder ?? this.breeder,
      strawNumber: strawNumber ?? this.strawNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] =
          Variable<int>($ReproductionsTable.$converterkind.toSql(kind.value));
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (diagnostic.present) {
      map['diagnostic'] = Variable<int>(
          $ReproductionsTable.$converterdiagnostic.toSql(diagnostic.value));
    }
    if (cow.present) {
      map['cow'] = Variable<int>(cow.value);
    }
    if (bull.present) {
      map['bull'] = Variable<int>(bull.value);
    }
    if (breeder.present) {
      map['breeder'] = Variable<String>(breeder.value);
    }
    if (strawNumber.present) {
      map['straw_number'] = Variable<int>(strawNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReproductionsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('date: $date, ')
          ..write('diagnostic: $diagnostic, ')
          ..write('cow: $cow, ')
          ..write('bull: $bull, ')
          ..write('breeder: $breeder, ')
          ..write('strawNumber: $strawNumber')
          ..write(')'))
        .toString();
  }
}

class $PregnanciesTable extends Pregnancies
    with TableInfo<$PregnanciesTable, Pregnancy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PregnanciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cowMeta = const VerificationMeta('cow');
  @override
  late final GeneratedColumn<int> cow = GeneratedColumn<int>(
      'cow', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _birthForecastMeta =
      const VerificationMeta('birthForecast');
  @override
  late final GeneratedColumn<DateTime> birthForecast =
      GeneratedColumn<DateTime>('birth_forecast', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _reproductionMeta =
      const VerificationMeta('reproduction');
  @override
  late final GeneratedColumn<int> reproduction = GeneratedColumn<int>(
      'reproduction', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES reproductions (id)'));
  static const VerificationMeta _hasEndedMeta =
      const VerificationMeta('hasEnded');
  @override
  late final GeneratedColumn<bool> hasEnded = GeneratedColumn<bool>(
      'has_ended', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_ended" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cow, date, birthForecast, reproduction, hasEnded, observation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pregnancies';
  @override
  VerificationContext validateIntegrity(Insertable<Pregnancy> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cow')) {
      context.handle(
          _cowMeta, cow.isAcceptableOrUnknown(data['cow']!, _cowMeta));
    } else if (isInserting) {
      context.missing(_cowMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('birth_forecast')) {
      context.handle(
          _birthForecastMeta,
          birthForecast.isAcceptableOrUnknown(
              data['birth_forecast']!, _birthForecastMeta));
    } else if (isInserting) {
      context.missing(_birthForecastMeta);
    }
    if (data.containsKey('reproduction')) {
      context.handle(
          _reproductionMeta,
          reproduction.isAcceptableOrUnknown(
              data['reproduction']!, _reproductionMeta));
    }
    if (data.containsKey('has_ended')) {
      context.handle(_hasEndedMeta,
          hasEnded.isAcceptableOrUnknown(data['has_ended']!, _hasEndedMeta));
    }
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pregnancy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pregnancy(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cow'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      birthForecast: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}birth_forecast'])!,
      reproduction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reproduction']),
      hasEnded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_ended'])!,
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
    );
  }

  @override
  $PregnanciesTable createAlias(String alias) {
    return $PregnanciesTable(attachedDatabase, alias);
  }
}

class Pregnancy extends DataClass implements Insertable<Pregnancy> {
  final int id;
  final int cow;
  final DateTime date;
  final DateTime birthForecast;
  final int? reproduction;
  final bool hasEnded;
  final String? observation;
  const Pregnancy(
      {required this.id,
      required this.cow,
      required this.date,
      required this.birthForecast,
      this.reproduction,
      required this.hasEnded,
      this.observation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cow'] = Variable<int>(cow);
    map['date'] = Variable<DateTime>(date);
    map['birth_forecast'] = Variable<DateTime>(birthForecast);
    if (!nullToAbsent || reproduction != null) {
      map['reproduction'] = Variable<int>(reproduction);
    }
    map['has_ended'] = Variable<bool>(hasEnded);
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    return map;
  }

  PregnanciesCompanion toCompanion(bool nullToAbsent) {
    return PregnanciesCompanion(
      id: Value(id),
      cow: Value(cow),
      date: Value(date),
      birthForecast: Value(birthForecast),
      reproduction: reproduction == null && nullToAbsent
          ? const Value.absent()
          : Value(reproduction),
      hasEnded: Value(hasEnded),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
    );
  }

  factory Pregnancy.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pregnancy(
      id: serializer.fromJson<int>(json['id']),
      cow: serializer.fromJson<int>(json['cow']),
      date: serializer.fromJson<DateTime>(json['date']),
      birthForecast: serializer.fromJson<DateTime>(json['birthForecast']),
      reproduction: serializer.fromJson<int?>(json['reproduction']),
      hasEnded: serializer.fromJson<bool>(json['hasEnded']),
      observation: serializer.fromJson<String?>(json['observation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cow': serializer.toJson<int>(cow),
      'date': serializer.toJson<DateTime>(date),
      'birthForecast': serializer.toJson<DateTime>(birthForecast),
      'reproduction': serializer.toJson<int?>(reproduction),
      'hasEnded': serializer.toJson<bool>(hasEnded),
      'observation': serializer.toJson<String?>(observation),
    };
  }

  Pregnancy copyWith(
          {int? id,
          int? cow,
          DateTime? date,
          DateTime? birthForecast,
          Value<int?> reproduction = const Value.absent(),
          bool? hasEnded,
          Value<String?> observation = const Value.absent()}) =>
      Pregnancy(
        id: id ?? this.id,
        cow: cow ?? this.cow,
        date: date ?? this.date,
        birthForecast: birthForecast ?? this.birthForecast,
        reproduction:
            reproduction.present ? reproduction.value : this.reproduction,
        hasEnded: hasEnded ?? this.hasEnded,
        observation: observation.present ? observation.value : this.observation,
      );
  Pregnancy copyWithCompanion(PregnanciesCompanion data) {
    return Pregnancy(
      id: data.id.present ? data.id.value : this.id,
      cow: data.cow.present ? data.cow.value : this.cow,
      date: data.date.present ? data.date.value : this.date,
      birthForecast: data.birthForecast.present
          ? data.birthForecast.value
          : this.birthForecast,
      reproduction: data.reproduction.present
          ? data.reproduction.value
          : this.reproduction,
      hasEnded: data.hasEnded.present ? data.hasEnded.value : this.hasEnded,
      observation:
          data.observation.present ? data.observation.value : this.observation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pregnancy(')
          ..write('id: $id, ')
          ..write('cow: $cow, ')
          ..write('date: $date, ')
          ..write('birthForecast: $birthForecast, ')
          ..write('reproduction: $reproduction, ')
          ..write('hasEnded: $hasEnded, ')
          ..write('observation: $observation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, cow, date, birthForecast, reproduction, hasEnded, observation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pregnancy &&
          other.id == this.id &&
          other.cow == this.cow &&
          other.date == this.date &&
          other.birthForecast == this.birthForecast &&
          other.reproduction == this.reproduction &&
          other.hasEnded == this.hasEnded &&
          other.observation == this.observation);
}

class PregnanciesCompanion extends UpdateCompanion<Pregnancy> {
  final Value<int> id;
  final Value<int> cow;
  final Value<DateTime> date;
  final Value<DateTime> birthForecast;
  final Value<int?> reproduction;
  final Value<bool> hasEnded;
  final Value<String?> observation;
  const PregnanciesCompanion({
    this.id = const Value.absent(),
    this.cow = const Value.absent(),
    this.date = const Value.absent(),
    this.birthForecast = const Value.absent(),
    this.reproduction = const Value.absent(),
    this.hasEnded = const Value.absent(),
    this.observation = const Value.absent(),
  });
  PregnanciesCompanion.insert({
    this.id = const Value.absent(),
    required int cow,
    required DateTime date,
    required DateTime birthForecast,
    this.reproduction = const Value.absent(),
    this.hasEnded = const Value.absent(),
    this.observation = const Value.absent(),
  })  : cow = Value(cow),
        date = Value(date),
        birthForecast = Value(birthForecast);
  static Insertable<Pregnancy> custom({
    Expression<int>? id,
    Expression<int>? cow,
    Expression<DateTime>? date,
    Expression<DateTime>? birthForecast,
    Expression<int>? reproduction,
    Expression<bool>? hasEnded,
    Expression<String>? observation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cow != null) 'cow': cow,
      if (date != null) 'date': date,
      if (birthForecast != null) 'birth_forecast': birthForecast,
      if (reproduction != null) 'reproduction': reproduction,
      if (hasEnded != null) 'has_ended': hasEnded,
      if (observation != null) 'observation': observation,
    });
  }

  PregnanciesCompanion copyWith(
      {Value<int>? id,
      Value<int>? cow,
      Value<DateTime>? date,
      Value<DateTime>? birthForecast,
      Value<int?>? reproduction,
      Value<bool>? hasEnded,
      Value<String?>? observation}) {
    return PregnanciesCompanion(
      id: id ?? this.id,
      cow: cow ?? this.cow,
      date: date ?? this.date,
      birthForecast: birthForecast ?? this.birthForecast,
      reproduction: reproduction ?? this.reproduction,
      hasEnded: hasEnded ?? this.hasEnded,
      observation: observation ?? this.observation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cow.present) {
      map['cow'] = Variable<int>(cow.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (birthForecast.present) {
      map['birth_forecast'] = Variable<DateTime>(birthForecast.value);
    }
    if (reproduction.present) {
      map['reproduction'] = Variable<int>(reproduction.value);
    }
    if (hasEnded.present) {
      map['has_ended'] = Variable<bool>(hasEnded.value);
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PregnanciesCompanion(')
          ..write('id: $id, ')
          ..write('cow: $cow, ')
          ..write('date: $date, ')
          ..write('birthForecast: $birthForecast, ')
          ..write('reproduction: $reproduction, ')
          ..write('hasEnded: $hasEnded, ')
          ..write('observation: $observation')
          ..write(')'))
        .toString();
  }
}

class $BirthsTable extends Births with TableInfo<$BirthsTable, Birth> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BirthsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      check: () => ComparableExpr(weight).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _bcsMeta = const VerificationMeta('bcs');
  @override
  late final GeneratedColumnWithTypeConverter<BodyConditionScore, int> bcs =
      GeneratedColumn<int>('bcs', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<BodyConditionScore>($BirthsTable.$converterbcs);
  static const VerificationMeta _pregnancyMeta =
      const VerificationMeta('pregnancy');
  @override
  late final GeneratedColumn<int> pregnancy = GeneratedColumn<int>(
      'pregnancy', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES pregnancies (id)'));
  @override
  List<GeneratedColumn> get $columns => [bovine, date, weight, bcs, pregnancy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'births';
  @override
  VerificationContext validateIntegrity(Insertable<Birth> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    context.handle(_bcsMeta, const VerificationResult.success());
    if (data.containsKey('pregnancy')) {
      context.handle(_pregnancyMeta,
          pregnancy.isAcceptableOrUnknown(data['pregnancy']!, _pregnancyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bovine};
  @override
  Birth map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Birth(
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      bcs: $BirthsTable.$converterbcs.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bcs'])!),
      pregnancy: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pregnancy']),
    );
  }

  @override
  $BirthsTable createAlias(String alias) {
    return $BirthsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BodyConditionScore, int, int> $converterbcs =
      const EnumIndexConverter<BodyConditionScore>(BodyConditionScore.values);
}

class Birth extends DataClass implements Insertable<Birth> {
  final int bovine;
  final DateTime date;
  final double weight;
  final BodyConditionScore bcs;
  final int? pregnancy;
  const Birth(
      {required this.bovine,
      required this.date,
      required this.weight,
      required this.bcs,
      this.pregnancy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bovine'] = Variable<int>(bovine);
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    {
      map['bcs'] = Variable<int>($BirthsTable.$converterbcs.toSql(bcs));
    }
    if (!nullToAbsent || pregnancy != null) {
      map['pregnancy'] = Variable<int>(pregnancy);
    }
    return map;
  }

  BirthsCompanion toCompanion(bool nullToAbsent) {
    return BirthsCompanion(
      bovine: Value(bovine),
      date: Value(date),
      weight: Value(weight),
      bcs: Value(bcs),
      pregnancy: pregnancy == null && nullToAbsent
          ? const Value.absent()
          : Value(pregnancy),
    );
  }

  factory Birth.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Birth(
      bovine: serializer.fromJson<int>(json['bovine']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
      bcs: $BirthsTable.$converterbcs
          .fromJson(serializer.fromJson<int>(json['bcs'])),
      pregnancy: serializer.fromJson<int?>(json['pregnancy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bovine': serializer.toJson<int>(bovine),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
      'bcs': serializer.toJson<int>($BirthsTable.$converterbcs.toJson(bcs)),
      'pregnancy': serializer.toJson<int?>(pregnancy),
    };
  }

  Birth copyWith(
          {int? bovine,
          DateTime? date,
          double? weight,
          BodyConditionScore? bcs,
          Value<int?> pregnancy = const Value.absent()}) =>
      Birth(
        bovine: bovine ?? this.bovine,
        date: date ?? this.date,
        weight: weight ?? this.weight,
        bcs: bcs ?? this.bcs,
        pregnancy: pregnancy.present ? pregnancy.value : this.pregnancy,
      );
  Birth copyWithCompanion(BirthsCompanion data) {
    return Birth(
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      bcs: data.bcs.present ? data.bcs.value : this.bcs,
      pregnancy: data.pregnancy.present ? data.pregnancy.value : this.pregnancy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Birth(')
          ..write('bovine: $bovine, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bcs: $bcs, ')
          ..write('pregnancy: $pregnancy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bovine, date, weight, bcs, pregnancy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Birth &&
          other.bovine == this.bovine &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.bcs == this.bcs &&
          other.pregnancy == this.pregnancy);
}

class BirthsCompanion extends UpdateCompanion<Birth> {
  final Value<int> bovine;
  final Value<DateTime> date;
  final Value<double> weight;
  final Value<BodyConditionScore> bcs;
  final Value<int?> pregnancy;
  const BirthsCompanion({
    this.bovine = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.bcs = const Value.absent(),
    this.pregnancy = const Value.absent(),
  });
  BirthsCompanion.insert({
    this.bovine = const Value.absent(),
    required DateTime date,
    required double weight,
    required BodyConditionScore bcs,
    this.pregnancy = const Value.absent(),
  })  : date = Value(date),
        weight = Value(weight),
        bcs = Value(bcs);
  static Insertable<Birth> custom({
    Expression<int>? bovine,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<int>? bcs,
    Expression<int>? pregnancy,
  }) {
    return RawValuesInsertable({
      if (bovine != null) 'bovine': bovine,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (bcs != null) 'bcs': bcs,
      if (pregnancy != null) 'pregnancy': pregnancy,
    });
  }

  BirthsCompanion copyWith(
      {Value<int>? bovine,
      Value<DateTime>? date,
      Value<double>? weight,
      Value<BodyConditionScore>? bcs,
      Value<int?>? pregnancy}) {
    return BirthsCompanion(
      bovine: bovine ?? this.bovine,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      bcs: bcs ?? this.bcs,
      pregnancy: pregnancy ?? this.pregnancy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (bcs.present) {
      map['bcs'] = Variable<int>($BirthsTable.$converterbcs.toSql(bcs.value));
    }
    if (pregnancy.present) {
      map['pregnancy'] = Variable<int>(pregnancy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BirthsCompanion(')
          ..write('bovine: $bovine, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('bcs: $bcs, ')
          ..write('pregnancy: $pregnancy')
          ..write(')'))
        .toString();
  }
}

class $ParentingTable extends Parenting
    with TableInfo<$ParentingTable, Parents> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParentingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  static const VerificationMeta _cowMeta = const VerificationMeta('cow');
  @override
  late final GeneratedColumn<int> cow = GeneratedColumn<int>(
      'cow', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE SET NULL'));
  static const VerificationMeta _bullMeta = const VerificationMeta('bull');
  @override
  late final GeneratedColumn<int> bull = GeneratedColumn<int>(
      'bull', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE SET NULL'));
  static const VerificationMeta _breederMeta =
      const VerificationMeta('breeder');
  @override
  late final GeneratedColumn<String> breeder = GeneratedColumn<String>(
      'breeder', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES breeders (name) ON DELETE SET NULL'));
  @override
  List<GeneratedColumn> get $columns => [bovine, cow, bull, breeder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parenting';
  @override
  VerificationContext validateIntegrity(Insertable<Parents> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    }
    if (data.containsKey('cow')) {
      context.handle(
          _cowMeta, cow.isAcceptableOrUnknown(data['cow']!, _cowMeta));
    }
    if (data.containsKey('bull')) {
      context.handle(
          _bullMeta, bull.isAcceptableOrUnknown(data['bull']!, _bullMeta));
    }
    if (data.containsKey('breeder')) {
      context.handle(_breederMeta,
          breeder.isAcceptableOrUnknown(data['breeder']!, _breederMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bovine};
  @override
  Parents map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Parents(
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
      cow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cow']),
      bull: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bull']),
      breeder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}breeder']),
    );
  }

  @override
  $ParentingTable createAlias(String alias) {
    return $ParentingTable(attachedDatabase, alias);
  }
}

class Parents extends DataClass implements Insertable<Parents> {
  final int bovine;
  final int? cow;
  final int? bull;
  final String? breeder;
  const Parents({required this.bovine, this.cow, this.bull, this.breeder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bovine'] = Variable<int>(bovine);
    if (!nullToAbsent || cow != null) {
      map['cow'] = Variable<int>(cow);
    }
    if (!nullToAbsent || bull != null) {
      map['bull'] = Variable<int>(bull);
    }
    if (!nullToAbsent || breeder != null) {
      map['breeder'] = Variable<String>(breeder);
    }
    return map;
  }

  ParentingCompanion toCompanion(bool nullToAbsent) {
    return ParentingCompanion(
      bovine: Value(bovine),
      cow: cow == null && nullToAbsent ? const Value.absent() : Value(cow),
      bull: bull == null && nullToAbsent ? const Value.absent() : Value(bull),
      breeder: breeder == null && nullToAbsent
          ? const Value.absent()
          : Value(breeder),
    );
  }

  factory Parents.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Parents(
      bovine: serializer.fromJson<int>(json['bovine']),
      cow: serializer.fromJson<int?>(json['cow']),
      bull: serializer.fromJson<int?>(json['bull']),
      breeder: serializer.fromJson<String?>(json['breeder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bovine': serializer.toJson<int>(bovine),
      'cow': serializer.toJson<int?>(cow),
      'bull': serializer.toJson<int?>(bull),
      'breeder': serializer.toJson<String?>(breeder),
    };
  }

  Parents copyWith(
          {int? bovine,
          Value<int?> cow = const Value.absent(),
          Value<int?> bull = const Value.absent(),
          Value<String?> breeder = const Value.absent()}) =>
      Parents(
        bovine: bovine ?? this.bovine,
        cow: cow.present ? cow.value : this.cow,
        bull: bull.present ? bull.value : this.bull,
        breeder: breeder.present ? breeder.value : this.breeder,
      );
  Parents copyWithCompanion(ParentingCompanion data) {
    return Parents(
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
      cow: data.cow.present ? data.cow.value : this.cow,
      bull: data.bull.present ? data.bull.value : this.bull,
      breeder: data.breeder.present ? data.breeder.value : this.breeder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Parents(')
          ..write('bovine: $bovine, ')
          ..write('cow: $cow, ')
          ..write('bull: $bull, ')
          ..write('breeder: $breeder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bovine, cow, bull, breeder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Parents &&
          other.bovine == this.bovine &&
          other.cow == this.cow &&
          other.bull == this.bull &&
          other.breeder == this.breeder);
}

class ParentingCompanion extends UpdateCompanion<Parents> {
  final Value<int> bovine;
  final Value<int?> cow;
  final Value<int?> bull;
  final Value<String?> breeder;
  const ParentingCompanion({
    this.bovine = const Value.absent(),
    this.cow = const Value.absent(),
    this.bull = const Value.absent(),
    this.breeder = const Value.absent(),
  });
  ParentingCompanion.insert({
    this.bovine = const Value.absent(),
    this.cow = const Value.absent(),
    this.bull = const Value.absent(),
    this.breeder = const Value.absent(),
  });
  static Insertable<Parents> custom({
    Expression<int>? bovine,
    Expression<int>? cow,
    Expression<int>? bull,
    Expression<String>? breeder,
  }) {
    return RawValuesInsertable({
      if (bovine != null) 'bovine': bovine,
      if (cow != null) 'cow': cow,
      if (bull != null) 'bull': bull,
      if (breeder != null) 'breeder': breeder,
    });
  }

  ParentingCompanion copyWith(
      {Value<int>? bovine,
      Value<int?>? cow,
      Value<int?>? bull,
      Value<String?>? breeder}) {
    return ParentingCompanion(
      bovine: bovine ?? this.bovine,
      cow: cow ?? this.cow,
      bull: bull ?? this.bull,
      breeder: breeder ?? this.breeder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    if (cow.present) {
      map['cow'] = Variable<int>(cow.value);
    }
    if (bull.present) {
      map['bull'] = Variable<int>(bull.value);
    }
    if (breeder.present) {
      map['breeder'] = Variable<String>(breeder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParentingCompanion(')
          ..write('bovine: $bovine, ')
          ..write('cow: $cow, ')
          ..write('bull: $bull, ')
          ..write('breeder: $breeder')
          ..write(')'))
        .toString();
  }
}

class $WeaningsTable extends Weanings with TableInfo<$WeaningsTable, Weaning> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeaningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      check: () => ComparableExpr(weight).isBiggerThan(const Constant(0.0)),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [bovine, date, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weanings';
  @override
  VerificationContext validateIntegrity(Insertable<Weaning> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bovine};
  @override
  Weaning map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weaning(
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
    );
  }

  @override
  $WeaningsTable createAlias(String alias) {
    return $WeaningsTable(attachedDatabase, alias);
  }
}

class Weaning extends DataClass implements Insertable<Weaning> {
  final int bovine;
  final DateTime date;
  final double weight;
  const Weaning(
      {required this.bovine, required this.date, required this.weight});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bovine'] = Variable<int>(bovine);
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    return map;
  }

  WeaningsCompanion toCompanion(bool nullToAbsent) {
    return WeaningsCompanion(
      bovine: Value(bovine),
      date: Value(date),
      weight: Value(weight),
    );
  }

  factory Weaning.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weaning(
      bovine: serializer.fromJson<int>(json['bovine']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bovine': serializer.toJson<int>(bovine),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
    };
  }

  Weaning copyWith({int? bovine, DateTime? date, double? weight}) => Weaning(
        bovine: bovine ?? this.bovine,
        date: date ?? this.date,
        weight: weight ?? this.weight,
      );
  Weaning copyWithCompanion(WeaningsCompanion data) {
    return Weaning(
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Weaning(')
          ..write('bovine: $bovine, ')
          ..write('date: $date, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bovine, date, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weaning &&
          other.bovine == this.bovine &&
          other.date == this.date &&
          other.weight == this.weight);
}

class WeaningsCompanion extends UpdateCompanion<Weaning> {
  final Value<int> bovine;
  final Value<DateTime> date;
  final Value<double> weight;
  const WeaningsCompanion({
    this.bovine = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
  });
  WeaningsCompanion.insert({
    this.bovine = const Value.absent(),
    required DateTime date,
    required double weight,
  })  : date = Value(date),
        weight = Value(weight);
  static Insertable<Weaning> custom({
    Expression<int>? bovine,
    Expression<DateTime>? date,
    Expression<double>? weight,
  }) {
    return RawValuesInsertable({
      if (bovine != null) 'bovine': bovine,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
    });
  }

  WeaningsCompanion copyWith(
      {Value<int>? bovine, Value<DateTime>? date, Value<double>? weight}) {
    return WeaningsCompanion(
      bovine: bovine ?? this.bovine,
      date: date ?? this.date,
      weight: weight ?? this.weight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeaningsCompanion(')
          ..write('bovine: $bovine, ')
          ..write('date: $date, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }
}

class $TreatmentsTable extends Treatments
    with TableInfo<$TreatmentsTable, Treatment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _medicineMeta =
      const VerificationMeta('medicine');
  @override
  late final GeneratedColumn<String> medicine = GeneratedColumn<String>(
      'medicine', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startingDateMeta =
      const VerificationMeta('startingDate');
  @override
  late final GeneratedColumn<DateTime> startingDate = GeneratedColumn<DateTime>(
      'starting_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endingDateMeta =
      const VerificationMeta('endingDate');
  @override
  late final GeneratedColumn<DateTime> endingDate = GeneratedColumn<DateTime>(
      'ending_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _bovineMeta = const VerificationMeta('bovine');
  @override
  late final GeneratedColumn<int> bovine = GeneratedColumn<int>(
      'bovine', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bovines (earring) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, medicine, reason, startingDate, endingDate, bovine];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatments';
  @override
  VerificationContext validateIntegrity(Insertable<Treatment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('medicine')) {
      context.handle(_medicineMeta,
          medicine.isAcceptableOrUnknown(data['medicine']!, _medicineMeta));
    } else if (isInserting) {
      context.missing(_medicineMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('starting_date')) {
      context.handle(
          _startingDateMeta,
          startingDate.isAcceptableOrUnknown(
              data['starting_date']!, _startingDateMeta));
    } else if (isInserting) {
      context.missing(_startingDateMeta);
    }
    if (data.containsKey('ending_date')) {
      context.handle(
          _endingDateMeta,
          endingDate.isAcceptableOrUnknown(
              data['ending_date']!, _endingDateMeta));
    } else if (isInserting) {
      context.missing(_endingDateMeta);
    }
    if (data.containsKey('bovine')) {
      context.handle(_bovineMeta,
          bovine.isAcceptableOrUnknown(data['bovine']!, _bovineMeta));
    } else if (isInserting) {
      context.missing(_bovineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Treatment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Treatment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      medicine: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      startingDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}starting_date'])!,
      endingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ending_date'])!,
      bovine: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bovine'])!,
    );
  }

  @override
  $TreatmentsTable createAlias(String alias) {
    return $TreatmentsTable(attachedDatabase, alias);
  }
}

class Treatment extends DataClass implements Insertable<Treatment> {
  final int id;
  final String medicine;
  final String reason;
  final DateTime startingDate;
  final DateTime endingDate;
  final int bovine;
  const Treatment(
      {required this.id,
      required this.medicine,
      required this.reason,
      required this.startingDate,
      required this.endingDate,
      required this.bovine});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['medicine'] = Variable<String>(medicine);
    map['reason'] = Variable<String>(reason);
    map['starting_date'] = Variable<DateTime>(startingDate);
    map['ending_date'] = Variable<DateTime>(endingDate);
    map['bovine'] = Variable<int>(bovine);
    return map;
  }

  TreatmentsCompanion toCompanion(bool nullToAbsent) {
    return TreatmentsCompanion(
      id: Value(id),
      medicine: Value(medicine),
      reason: Value(reason),
      startingDate: Value(startingDate),
      endingDate: Value(endingDate),
      bovine: Value(bovine),
    );
  }

  factory Treatment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Treatment(
      id: serializer.fromJson<int>(json['id']),
      medicine: serializer.fromJson<String>(json['medicine']),
      reason: serializer.fromJson<String>(json['reason']),
      startingDate: serializer.fromJson<DateTime>(json['startingDate']),
      endingDate: serializer.fromJson<DateTime>(json['endingDate']),
      bovine: serializer.fromJson<int>(json['bovine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'medicine': serializer.toJson<String>(medicine),
      'reason': serializer.toJson<String>(reason),
      'startingDate': serializer.toJson<DateTime>(startingDate),
      'endingDate': serializer.toJson<DateTime>(endingDate),
      'bovine': serializer.toJson<int>(bovine),
    };
  }

  Treatment copyWith(
          {int? id,
          String? medicine,
          String? reason,
          DateTime? startingDate,
          DateTime? endingDate,
          int? bovine}) =>
      Treatment(
        id: id ?? this.id,
        medicine: medicine ?? this.medicine,
        reason: reason ?? this.reason,
        startingDate: startingDate ?? this.startingDate,
        endingDate: endingDate ?? this.endingDate,
        bovine: bovine ?? this.bovine,
      );
  Treatment copyWithCompanion(TreatmentsCompanion data) {
    return Treatment(
      id: data.id.present ? data.id.value : this.id,
      medicine: data.medicine.present ? data.medicine.value : this.medicine,
      reason: data.reason.present ? data.reason.value : this.reason,
      startingDate: data.startingDate.present
          ? data.startingDate.value
          : this.startingDate,
      endingDate:
          data.endingDate.present ? data.endingDate.value : this.endingDate,
      bovine: data.bovine.present ? data.bovine.value : this.bovine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Treatment(')
          ..write('id: $id, ')
          ..write('medicine: $medicine, ')
          ..write('reason: $reason, ')
          ..write('startingDate: $startingDate, ')
          ..write('endingDate: $endingDate, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, medicine, reason, startingDate, endingDate, bovine);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Treatment &&
          other.id == this.id &&
          other.medicine == this.medicine &&
          other.reason == this.reason &&
          other.startingDate == this.startingDate &&
          other.endingDate == this.endingDate &&
          other.bovine == this.bovine);
}

class TreatmentsCompanion extends UpdateCompanion<Treatment> {
  final Value<int> id;
  final Value<String> medicine;
  final Value<String> reason;
  final Value<DateTime> startingDate;
  final Value<DateTime> endingDate;
  final Value<int> bovine;
  const TreatmentsCompanion({
    this.id = const Value.absent(),
    this.medicine = const Value.absent(),
    this.reason = const Value.absent(),
    this.startingDate = const Value.absent(),
    this.endingDate = const Value.absent(),
    this.bovine = const Value.absent(),
  });
  TreatmentsCompanion.insert({
    this.id = const Value.absent(),
    required String medicine,
    required String reason,
    required DateTime startingDate,
    required DateTime endingDate,
    required int bovine,
  })  : medicine = Value(medicine),
        reason = Value(reason),
        startingDate = Value(startingDate),
        endingDate = Value(endingDate),
        bovine = Value(bovine);
  static Insertable<Treatment> custom({
    Expression<int>? id,
    Expression<String>? medicine,
    Expression<String>? reason,
    Expression<DateTime>? startingDate,
    Expression<DateTime>? endingDate,
    Expression<int>? bovine,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicine != null) 'medicine': medicine,
      if (reason != null) 'reason': reason,
      if (startingDate != null) 'starting_date': startingDate,
      if (endingDate != null) 'ending_date': endingDate,
      if (bovine != null) 'bovine': bovine,
    });
  }

  TreatmentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? medicine,
      Value<String>? reason,
      Value<DateTime>? startingDate,
      Value<DateTime>? endingDate,
      Value<int>? bovine}) {
    return TreatmentsCompanion(
      id: id ?? this.id,
      medicine: medicine ?? this.medicine,
      reason: reason ?? this.reason,
      startingDate: startingDate ?? this.startingDate,
      endingDate: endingDate ?? this.endingDate,
      bovine: bovine ?? this.bovine,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (medicine.present) {
      map['medicine'] = Variable<String>(medicine.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (startingDate.present) {
      map['starting_date'] = Variable<DateTime>(startingDate.value);
    }
    if (endingDate.present) {
      map['ending_date'] = Variable<DateTime>(endingDate.value);
    }
    if (bovine.present) {
      map['bovine'] = Variable<int>(bovine.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentsCompanion(')
          ..write('id: $id, ')
          ..write('medicine: $medicine, ')
          ..write('reason: $reason, ')
          ..write('startingDate: $startingDate, ')
          ..write('endingDate: $endingDate, ')
          ..write('bovine: $bovine')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BovinesTable bovines = $BovinesTable(this);
  late final $BovinesEntryTable bovinesEntry = $BovinesEntryTable(this);
  late final $BreedersTable breeders = $BreedersTable(this);
  late final $DiscardsTable discards = $DiscardsTable(this);
  late final $ReproductionsTable reproductions = $ReproductionsTable(this);
  late final $PregnanciesTable pregnancies = $PregnanciesTable(this);
  late final $BirthsTable births = $BirthsTable(this);
  late final $ParentingTable parenting = $ParentingTable(this);
  late final $WeaningsTable weanings = $WeaningsTable(this);
  late final $TreatmentsTable treatments = $TreatmentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        bovines,
        bovinesEntry,
        breeders,
        discards,
        reproductions,
        pregnancies,
        births,
        parenting,
        weanings,
        treatments
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('bovines_entry', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('discards', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('reproductions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('reproductions', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('breeders',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('reproductions', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('pregnancies', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('births', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('parenting', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('parenting', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('parenting', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('breeders',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('parenting', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('weanings', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bovines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('treatments', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$BovinesTableCreateCompanionBuilder = BovinesCompanion Function({
  Value<int> earring,
  Value<String?> name,
  required Sex sex,
  Value<bool> hasBeenWeaned,
  Value<bool> isReproducing,
  Value<bool> isPregnant,
  Value<bool> wasDiscarded,
  Value<bool> isBreeder,
  Value<double?> weight540,
});
typedef $$BovinesTableUpdateCompanionBuilder = BovinesCompanion Function({
  Value<int> earring,
  Value<String?> name,
  Value<Sex> sex,
  Value<bool> hasBeenWeaned,
  Value<bool> isReproducing,
  Value<bool> isPregnant,
  Value<bool> wasDiscarded,
  Value<bool> isBreeder,
  Value<double?> weight540,
});

final class $$BovinesTableReferences
    extends BaseReferences<_$AppDatabase, $BovinesTable, Bovine> {
  $$BovinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BovinesEntryTable, List<BovineEntry>>
      _bovinesEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.bovinesEntry,
          aliasName:
              $_aliasNameGenerator(db.bovines.earring, db.bovinesEntry.bovine));

  $$BovinesEntryTableProcessedTableManager get bovinesEntryRefs {
    final manager = $$BovinesEntryTableTableManager($_db, $_db.bovinesEntry)
        .filter((f) => f.bovine.earring($_item.earring));

    final cache = $_typedResult.readTableOrNull(_bovinesEntryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DiscardsTable, List<Discard>> _discardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.discards,
          aliasName:
              $_aliasNameGenerator(db.bovines.earring, db.discards.bovine));

  $$DiscardsTableProcessedTableManager get discardsRefs {
    final manager = $$DiscardsTableTableManager($_db, $_db.discards)
        .filter((f) => f.bovine.earring($_item.earring));

    final cache = $_typedResult.readTableOrNull(_discardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PregnanciesTable, List<Pregnancy>>
      _pregnanciesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pregnancies,
              aliasName:
                  $_aliasNameGenerator(db.bovines.earring, db.pregnancies.cow));

  $$PregnanciesTableProcessedTableManager get pregnanciesRefs {
    final manager = $$PregnanciesTableTableManager($_db, $_db.pregnancies)
        .filter((f) => f.cow.earring($_item.earring));

    final cache = $_typedResult.readTableOrNull(_pregnanciesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BirthsTable, List<Birth>> _birthsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.births,
          aliasName:
              $_aliasNameGenerator(db.bovines.earring, db.births.bovine));

  $$BirthsTableProcessedTableManager get birthsRefs {
    final manager = $$BirthsTableTableManager($_db, $_db.births)
        .filter((f) => f.bovine.earring($_item.earring));

    final cache = $_typedResult.readTableOrNull(_birthsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WeaningsTable, List<Weaning>> _weaningsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.weanings,
          aliasName:
              $_aliasNameGenerator(db.bovines.earring, db.weanings.bovine));

  $$WeaningsTableProcessedTableManager get weaningsRefs {
    final manager = $$WeaningsTableTableManager($_db, $_db.weanings)
        .filter((f) => f.bovine.earring($_item.earring));

    final cache = $_typedResult.readTableOrNull(_weaningsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TreatmentsTable, List<Treatment>>
      _treatmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.treatments,
          aliasName:
              $_aliasNameGenerator(db.bovines.earring, db.treatments.bovine));

  $$TreatmentsTableProcessedTableManager get treatmentsRefs {
    final manager = $$TreatmentsTableTableManager($_db, $_db.treatments)
        .filter((f) => f.bovine.earring($_item.earring));

    final cache = $_typedResult.readTableOrNull(_treatmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BovinesTableFilterComposer
    extends Composer<_$AppDatabase, $BovinesTable> {
  $$BovinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get earring => $composableBuilder(
      column: $table.earring, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Sex, Sex, int> get sex => $composableBuilder(
      column: $table.sex,
      builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get hasBeenWeaned => $composableBuilder(
      column: $table.hasBeenWeaned, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isReproducing => $composableBuilder(
      column: $table.isReproducing, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPregnant => $composableBuilder(
      column: $table.isPregnant, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get wasDiscarded => $composableBuilder(
      column: $table.wasDiscarded, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBreeder => $composableBuilder(
      column: $table.isBreeder, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight540 => $composableBuilder(
      column: $table.weight540, builder: (column) => ColumnFilters(column));

  Expression<bool> bovinesEntryRefs(
      Expression<bool> Function($$BovinesEntryTableFilterComposer f) f) {
    final $$BovinesEntryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.bovinesEntry,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesEntryTableFilterComposer(
              $db: $db,
              $table: $db.bovinesEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> discardsRefs(
      Expression<bool> Function($$DiscardsTableFilterComposer f) f) {
    final $$DiscardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.discards,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DiscardsTableFilterComposer(
              $db: $db,
              $table: $db.discards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> pregnanciesRefs(
      Expression<bool> Function($$PregnanciesTableFilterComposer f) f) {
    final $$PregnanciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.cow,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableFilterComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> birthsRefs(
      Expression<bool> Function($$BirthsTableFilterComposer f) f) {
    final $$BirthsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.births,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BirthsTableFilterComposer(
              $db: $db,
              $table: $db.births,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> weaningsRefs(
      Expression<bool> Function($$WeaningsTableFilterComposer f) f) {
    final $$WeaningsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.weanings,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeaningsTableFilterComposer(
              $db: $db,
              $table: $db.weanings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> treatmentsRefs(
      Expression<bool> Function($$TreatmentsTableFilterComposer f) f) {
    final $$TreatmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableFilterComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BovinesTableOrderingComposer
    extends Composer<_$AppDatabase, $BovinesTable> {
  $$BovinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get earring => $composableBuilder(
      column: $table.earring, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sex => $composableBuilder(
      column: $table.sex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasBeenWeaned => $composableBuilder(
      column: $table.hasBeenWeaned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isReproducing => $composableBuilder(
      column: $table.isReproducing,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPregnant => $composableBuilder(
      column: $table.isPregnant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get wasDiscarded => $composableBuilder(
      column: $table.wasDiscarded,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBreeder => $composableBuilder(
      column: $table.isBreeder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight540 => $composableBuilder(
      column: $table.weight540, builder: (column) => ColumnOrderings(column));
}

class $$BovinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BovinesTable> {
  $$BovinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get earring =>
      $composableBuilder(column: $table.earring, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Sex, int> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<bool> get hasBeenWeaned => $composableBuilder(
      column: $table.hasBeenWeaned, builder: (column) => column);

  GeneratedColumn<bool> get isReproducing => $composableBuilder(
      column: $table.isReproducing, builder: (column) => column);

  GeneratedColumn<bool> get isPregnant => $composableBuilder(
      column: $table.isPregnant, builder: (column) => column);

  GeneratedColumn<bool> get wasDiscarded => $composableBuilder(
      column: $table.wasDiscarded, builder: (column) => column);

  GeneratedColumn<bool> get isBreeder =>
      $composableBuilder(column: $table.isBreeder, builder: (column) => column);

  GeneratedColumn<double> get weight540 =>
      $composableBuilder(column: $table.weight540, builder: (column) => column);

  Expression<T> bovinesEntryRefs<T extends Object>(
      Expression<T> Function($$BovinesEntryTableAnnotationComposer a) f) {
    final $$BovinesEntryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.bovinesEntry,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesEntryTableAnnotationComposer(
              $db: $db,
              $table: $db.bovinesEntry,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> discardsRefs<T extends Object>(
      Expression<T> Function($$DiscardsTableAnnotationComposer a) f) {
    final $$DiscardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.discards,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DiscardsTableAnnotationComposer(
              $db: $db,
              $table: $db.discards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> pregnanciesRefs<T extends Object>(
      Expression<T> Function($$PregnanciesTableAnnotationComposer a) f) {
    final $$PregnanciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.cow,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableAnnotationComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> birthsRefs<T extends Object>(
      Expression<T> Function($$BirthsTableAnnotationComposer a) f) {
    final $$BirthsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.births,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BirthsTableAnnotationComposer(
              $db: $db,
              $table: $db.births,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> weaningsRefs<T extends Object>(
      Expression<T> Function($$WeaningsTableAnnotationComposer a) f) {
    final $$WeaningsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.weanings,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeaningsTableAnnotationComposer(
              $db: $db,
              $table: $db.weanings,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> treatmentsRefs<T extends Object>(
      Expression<T> Function($$TreatmentsTableAnnotationComposer a) f) {
    final $$TreatmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.earring,
        referencedTable: $db.treatments,
        getReferencedColumn: (t) => t.bovine,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TreatmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.treatments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BovinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BovinesTable,
    Bovine,
    $$BovinesTableFilterComposer,
    $$BovinesTableOrderingComposer,
    $$BovinesTableAnnotationComposer,
    $$BovinesTableCreateCompanionBuilder,
    $$BovinesTableUpdateCompanionBuilder,
    (Bovine, $$BovinesTableReferences),
    Bovine,
    PrefetchHooks Function(
        {bool bovinesEntryRefs,
        bool discardsRefs,
        bool pregnanciesRefs,
        bool birthsRefs,
        bool weaningsRefs,
        bool treatmentsRefs})> {
  $$BovinesTableTableManager(_$AppDatabase db, $BovinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BovinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BovinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BovinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> earring = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<Sex> sex = const Value.absent(),
            Value<bool> hasBeenWeaned = const Value.absent(),
            Value<bool> isReproducing = const Value.absent(),
            Value<bool> isPregnant = const Value.absent(),
            Value<bool> wasDiscarded = const Value.absent(),
            Value<bool> isBreeder = const Value.absent(),
            Value<double?> weight540 = const Value.absent(),
          }) =>
              BovinesCompanion(
            earring: earring,
            name: name,
            sex: sex,
            hasBeenWeaned: hasBeenWeaned,
            isReproducing: isReproducing,
            isPregnant: isPregnant,
            wasDiscarded: wasDiscarded,
            isBreeder: isBreeder,
            weight540: weight540,
          ),
          createCompanionCallback: ({
            Value<int> earring = const Value.absent(),
            Value<String?> name = const Value.absent(),
            required Sex sex,
            Value<bool> hasBeenWeaned = const Value.absent(),
            Value<bool> isReproducing = const Value.absent(),
            Value<bool> isPregnant = const Value.absent(),
            Value<bool> wasDiscarded = const Value.absent(),
            Value<bool> isBreeder = const Value.absent(),
            Value<double?> weight540 = const Value.absent(),
          }) =>
              BovinesCompanion.insert(
            earring: earring,
            name: name,
            sex: sex,
            hasBeenWeaned: hasBeenWeaned,
            isReproducing: isReproducing,
            isPregnant: isPregnant,
            wasDiscarded: wasDiscarded,
            isBreeder: isBreeder,
            weight540: weight540,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BovinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {bovinesEntryRefs = false,
              discardsRefs = false,
              pregnanciesRefs = false,
              birthsRefs = false,
              weaningsRefs = false,
              treatmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bovinesEntryRefs) db.bovinesEntry,
                if (discardsRefs) db.discards,
                if (pregnanciesRefs) db.pregnancies,
                if (birthsRefs) db.births,
                if (weaningsRefs) db.weanings,
                if (treatmentsRefs) db.treatments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bovinesEntryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._bovinesEntryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .bovinesEntryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bovine == item.earring),
                        typedResults: items),
                  if (discardsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._discardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .discardsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bovine == item.earring),
                        typedResults: items),
                  if (pregnanciesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._pregnanciesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .pregnanciesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cow == item.earring),
                        typedResults: items),
                  if (birthsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._birthsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0).birthsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bovine == item.earring),
                        typedResults: items),
                  if (weaningsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._weaningsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .weaningsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bovine == item.earring),
                        typedResults: items),
                  if (treatmentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BovinesTableReferences._treatmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BovinesTableReferences(db, table, p0)
                                .treatmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.bovine == item.earring),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BovinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BovinesTable,
    Bovine,
    $$BovinesTableFilterComposer,
    $$BovinesTableOrderingComposer,
    $$BovinesTableAnnotationComposer,
    $$BovinesTableCreateCompanionBuilder,
    $$BovinesTableUpdateCompanionBuilder,
    (Bovine, $$BovinesTableReferences),
    Bovine,
    PrefetchHooks Function(
        {bool bovinesEntryRefs,
        bool discardsRefs,
        bool pregnanciesRefs,
        bool birthsRefs,
        bool weaningsRefs,
        bool treatmentsRefs})>;
typedef $$BovinesEntryTableCreateCompanionBuilder = BovinesEntryCompanion
    Function({
  Value<int> bovine,
  Value<double?> weight,
  Value<DateTime?> date,
});
typedef $$BovinesEntryTableUpdateCompanionBuilder = BovinesEntryCompanion
    Function({
  Value<int> bovine,
  Value<double?> weight,
  Value<DateTime?> date,
});

final class $$BovinesEntryTableReferences
    extends BaseReferences<_$AppDatabase, $BovinesEntryTable, BovineEntry> {
  $$BovinesEntryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.bovinesEntry.bovine, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BovinesEntryTableFilterComposer
    extends Composer<_$AppDatabase, $BovinesEntryTable> {
  $$BovinesEntryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BovinesEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $BovinesEntryTable> {
  $$BovinesEntryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BovinesEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $BovinesEntryTable> {
  $$BovinesEntryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BovinesEntryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BovinesEntryTable,
    BovineEntry,
    $$BovinesEntryTableFilterComposer,
    $$BovinesEntryTableOrderingComposer,
    $$BovinesEntryTableAnnotationComposer,
    $$BovinesEntryTableCreateCompanionBuilder,
    $$BovinesEntryTableUpdateCompanionBuilder,
    (BovineEntry, $$BovinesEntryTableReferences),
    BovineEntry,
    PrefetchHooks Function({bool bovine})> {
  $$BovinesEntryTableTableManager(_$AppDatabase db, $BovinesEntryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BovinesEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BovinesEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BovinesEntryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
          }) =>
              BovinesEntryCompanion(
            bovine: bovine,
            weight: weight,
            date: date,
          ),
          createCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<DateTime?> date = const Value.absent(),
          }) =>
              BovinesEntryCompanion.insert(
            bovine: bovine,
            weight: weight,
            date: date,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BovinesEntryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable:
                        $$BovinesEntryTableReferences._bovineTable(db),
                    referencedColumn:
                        $$BovinesEntryTableReferences._bovineTable(db).earring,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BovinesEntryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BovinesEntryTable,
    BovineEntry,
    $$BovinesEntryTableFilterComposer,
    $$BovinesEntryTableOrderingComposer,
    $$BovinesEntryTableAnnotationComposer,
    $$BovinesEntryTableCreateCompanionBuilder,
    $$BovinesEntryTableUpdateCompanionBuilder,
    (BovineEntry, $$BovinesEntryTableReferences),
    BovineEntry,
    PrefetchHooks Function({bool bovine})>;
typedef $$BreedersTableCreateCompanionBuilder = BreedersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> father,
  Value<String?> mother,
  Value<String?> paternalGrandmother,
  Value<String?> paternalGrandfather,
  Value<String?> maternalGrandmother,
  Value<String?> maternalGrandfather,
  Value<double?> epdBirthWeight,
  Value<double?> epdWeaningWeight,
  Value<double?> epdYearlingWeight,
});
typedef $$BreedersTableUpdateCompanionBuilder = BreedersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> father,
  Value<String?> mother,
  Value<String?> paternalGrandmother,
  Value<String?> paternalGrandfather,
  Value<String?> maternalGrandmother,
  Value<String?> maternalGrandfather,
  Value<double?> epdBirthWeight,
  Value<double?> epdWeaningWeight,
  Value<double?> epdYearlingWeight,
});

final class $$BreedersTableReferences
    extends BaseReferences<_$AppDatabase, $BreedersTable, Breeder> {
  $$BreedersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReproductionsTable, List<Reproduction>>
      _reproductionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.reproductions,
              aliasName: $_aliasNameGenerator(
                  db.breeders.name, db.reproductions.breeder));

  $$ReproductionsTableProcessedTableManager get reproductionsRefs {
    final manager = $$ReproductionsTableTableManager($_db, $_db.reproductions)
        .filter((f) => f.breeder.name($_item.name));

    final cache = $_typedResult.readTableOrNull(_reproductionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ParentingTable, List<Parents>>
      _parentingRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.parenting,
              aliasName:
                  $_aliasNameGenerator(db.breeders.name, db.parenting.breeder));

  $$ParentingTableProcessedTableManager get parentingRefs {
    final manager = $$ParentingTableTableManager($_db, $_db.parenting)
        .filter((f) => f.breeder.name($_item.name));

    final cache = $_typedResult.readTableOrNull(_parentingRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BreedersTableFilterComposer
    extends Composer<_$AppDatabase, $BreedersTable> {
  $$BreedersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get father => $composableBuilder(
      column: $table.father, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mother => $composableBuilder(
      column: $table.mother, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paternalGrandmother => $composableBuilder(
      column: $table.paternalGrandmother,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paternalGrandfather => $composableBuilder(
      column: $table.paternalGrandfather,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get maternalGrandmother => $composableBuilder(
      column: $table.maternalGrandmother,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get maternalGrandfather => $composableBuilder(
      column: $table.maternalGrandfather,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get epdBirthWeight => $composableBuilder(
      column: $table.epdBirthWeight,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get epdWeaningWeight => $composableBuilder(
      column: $table.epdWeaningWeight,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get epdYearlingWeight => $composableBuilder(
      column: $table.epdYearlingWeight,
      builder: (column) => ColumnFilters(column));

  Expression<bool> reproductionsRefs(
      Expression<bool> Function($$ReproductionsTableFilterComposer f) f) {
    final $$ReproductionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.breeder,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableFilterComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> parentingRefs(
      Expression<bool> Function($$ParentingTableFilterComposer f) f) {
    final $$ParentingTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.parenting,
        getReferencedColumn: (t) => t.breeder,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParentingTableFilterComposer(
              $db: $db,
              $table: $db.parenting,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BreedersTableOrderingComposer
    extends Composer<_$AppDatabase, $BreedersTable> {
  $$BreedersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get father => $composableBuilder(
      column: $table.father, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mother => $composableBuilder(
      column: $table.mother, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paternalGrandmother => $composableBuilder(
      column: $table.paternalGrandmother,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paternalGrandfather => $composableBuilder(
      column: $table.paternalGrandfather,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get maternalGrandmother => $composableBuilder(
      column: $table.maternalGrandmother,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get maternalGrandfather => $composableBuilder(
      column: $table.maternalGrandfather,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get epdBirthWeight => $composableBuilder(
      column: $table.epdBirthWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get epdWeaningWeight => $composableBuilder(
      column: $table.epdWeaningWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get epdYearlingWeight => $composableBuilder(
      column: $table.epdYearlingWeight,
      builder: (column) => ColumnOrderings(column));
}

class $$BreedersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BreedersTable> {
  $$BreedersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get father =>
      $composableBuilder(column: $table.father, builder: (column) => column);

  GeneratedColumn<String> get mother =>
      $composableBuilder(column: $table.mother, builder: (column) => column);

  GeneratedColumn<String> get paternalGrandmother => $composableBuilder(
      column: $table.paternalGrandmother, builder: (column) => column);

  GeneratedColumn<String> get paternalGrandfather => $composableBuilder(
      column: $table.paternalGrandfather, builder: (column) => column);

  GeneratedColumn<String> get maternalGrandmother => $composableBuilder(
      column: $table.maternalGrandmother, builder: (column) => column);

  GeneratedColumn<String> get maternalGrandfather => $composableBuilder(
      column: $table.maternalGrandfather, builder: (column) => column);

  GeneratedColumn<double> get epdBirthWeight => $composableBuilder(
      column: $table.epdBirthWeight, builder: (column) => column);

  GeneratedColumn<double> get epdWeaningWeight => $composableBuilder(
      column: $table.epdWeaningWeight, builder: (column) => column);

  GeneratedColumn<double> get epdYearlingWeight => $composableBuilder(
      column: $table.epdYearlingWeight, builder: (column) => column);

  Expression<T> reproductionsRefs<T extends Object>(
      Expression<T> Function($$ReproductionsTableAnnotationComposer a) f) {
    final $$ReproductionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.breeder,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableAnnotationComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> parentingRefs<T extends Object>(
      Expression<T> Function($$ParentingTableAnnotationComposer a) f) {
    final $$ParentingTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $db.parenting,
        getReferencedColumn: (t) => t.breeder,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParentingTableAnnotationComposer(
              $db: $db,
              $table: $db.parenting,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BreedersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BreedersTable,
    Breeder,
    $$BreedersTableFilterComposer,
    $$BreedersTableOrderingComposer,
    $$BreedersTableAnnotationComposer,
    $$BreedersTableCreateCompanionBuilder,
    $$BreedersTableUpdateCompanionBuilder,
    (Breeder, $$BreedersTableReferences),
    Breeder,
    PrefetchHooks Function({bool reproductionsRefs, bool parentingRefs})> {
  $$BreedersTableTableManager(_$AppDatabase db, $BreedersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BreedersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BreedersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BreedersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> father = const Value.absent(),
            Value<String?> mother = const Value.absent(),
            Value<String?> paternalGrandmother = const Value.absent(),
            Value<String?> paternalGrandfather = const Value.absent(),
            Value<String?> maternalGrandmother = const Value.absent(),
            Value<String?> maternalGrandfather = const Value.absent(),
            Value<double?> epdBirthWeight = const Value.absent(),
            Value<double?> epdWeaningWeight = const Value.absent(),
            Value<double?> epdYearlingWeight = const Value.absent(),
          }) =>
              BreedersCompanion(
            id: id,
            name: name,
            father: father,
            mother: mother,
            paternalGrandmother: paternalGrandmother,
            paternalGrandfather: paternalGrandfather,
            maternalGrandmother: maternalGrandmother,
            maternalGrandfather: maternalGrandfather,
            epdBirthWeight: epdBirthWeight,
            epdWeaningWeight: epdWeaningWeight,
            epdYearlingWeight: epdYearlingWeight,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> father = const Value.absent(),
            Value<String?> mother = const Value.absent(),
            Value<String?> paternalGrandmother = const Value.absent(),
            Value<String?> paternalGrandfather = const Value.absent(),
            Value<String?> maternalGrandmother = const Value.absent(),
            Value<String?> maternalGrandfather = const Value.absent(),
            Value<double?> epdBirthWeight = const Value.absent(),
            Value<double?> epdWeaningWeight = const Value.absent(),
            Value<double?> epdYearlingWeight = const Value.absent(),
          }) =>
              BreedersCompanion.insert(
            id: id,
            name: name,
            father: father,
            mother: mother,
            paternalGrandmother: paternalGrandmother,
            paternalGrandfather: paternalGrandfather,
            maternalGrandmother: maternalGrandmother,
            maternalGrandfather: maternalGrandfather,
            epdBirthWeight: epdBirthWeight,
            epdWeaningWeight: epdWeaningWeight,
            epdYearlingWeight: epdYearlingWeight,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BreedersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {reproductionsRefs = false, parentingRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reproductionsRefs) db.reproductions,
                if (parentingRefs) db.parenting
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reproductionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BreedersTableReferences
                            ._reproductionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BreedersTableReferences(db, table, p0)
                                .reproductionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.breeder == item.name),
                        typedResults: items),
                  if (parentingRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BreedersTableReferences._parentingRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BreedersTableReferences(db, table, p0)
                                .parentingRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.breeder == item.name),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BreedersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BreedersTable,
    Breeder,
    $$BreedersTableFilterComposer,
    $$BreedersTableOrderingComposer,
    $$BreedersTableAnnotationComposer,
    $$BreedersTableCreateCompanionBuilder,
    $$BreedersTableUpdateCompanionBuilder,
    (Breeder, $$BreedersTableReferences),
    Breeder,
    PrefetchHooks Function({bool reproductionsRefs, bool parentingRefs})>;
typedef $$DiscardsTableCreateCompanionBuilder = DiscardsCompanion Function({
  Value<int> bovine,
  required DateTime date,
  required DiscardReason reason,
  Value<String?> observation,
  Value<double?> weight,
});
typedef $$DiscardsTableUpdateCompanionBuilder = DiscardsCompanion Function({
  Value<int> bovine,
  Value<DateTime> date,
  Value<DiscardReason> reason,
  Value<String?> observation,
  Value<double?> weight,
});

final class $$DiscardsTableReferences
    extends BaseReferences<_$AppDatabase, $DiscardsTable, Discard> {
  $$DiscardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.discards.bovine, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DiscardsTableFilterComposer
    extends Composer<_$AppDatabase, $DiscardsTable> {
  $$DiscardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DiscardReason, DiscardReason, int>
      get reason => $composableBuilder(
          column: $table.reason,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DiscardsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiscardsTable> {
  $$DiscardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DiscardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscardsTable> {
  $$DiscardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DiscardReason, int> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DiscardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DiscardsTable,
    Discard,
    $$DiscardsTableFilterComposer,
    $$DiscardsTableOrderingComposer,
    $$DiscardsTableAnnotationComposer,
    $$DiscardsTableCreateCompanionBuilder,
    $$DiscardsTableUpdateCompanionBuilder,
    (Discard, $$DiscardsTableReferences),
    Discard,
    PrefetchHooks Function({bool bovine})> {
  $$DiscardsTableTableManager(_$AppDatabase db, $DiscardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiscardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiscardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiscardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DiscardReason> reason = const Value.absent(),
            Value<String?> observation = const Value.absent(),
            Value<double?> weight = const Value.absent(),
          }) =>
              DiscardsCompanion(
            bovine: bovine,
            date: date,
            reason: reason,
            observation: observation,
            weight: weight,
          ),
          createCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            required DateTime date,
            required DiscardReason reason,
            Value<String?> observation = const Value.absent(),
            Value<double?> weight = const Value.absent(),
          }) =>
              DiscardsCompanion.insert(
            bovine: bovine,
            date: date,
            reason: reason,
            observation: observation,
            weight: weight,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DiscardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable: $$DiscardsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$DiscardsTableReferences._bovineTable(db).earring,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DiscardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DiscardsTable,
    Discard,
    $$DiscardsTableFilterComposer,
    $$DiscardsTableOrderingComposer,
    $$DiscardsTableAnnotationComposer,
    $$DiscardsTableCreateCompanionBuilder,
    $$DiscardsTableUpdateCompanionBuilder,
    (Discard, $$DiscardsTableReferences),
    Discard,
    PrefetchHooks Function({bool bovine})>;
typedef $$ReproductionsTableCreateCompanionBuilder = ReproductionsCompanion
    Function({
  Value<int> id,
  required ReproductionKind kind,
  required DateTime date,
  Value<ReproductionDiagonostic> diagnostic,
  required int cow,
  Value<int?> bull,
  Value<String?> breeder,
  Value<int?> strawNumber,
});
typedef $$ReproductionsTableUpdateCompanionBuilder = ReproductionsCompanion
    Function({
  Value<int> id,
  Value<ReproductionKind> kind,
  Value<DateTime> date,
  Value<ReproductionDiagonostic> diagnostic,
  Value<int> cow,
  Value<int?> bull,
  Value<String?> breeder,
  Value<int?> strawNumber,
});

final class $$ReproductionsTableReferences
    extends BaseReferences<_$AppDatabase, $ReproductionsTable, Reproduction> {
  $$ReproductionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _cowTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.reproductions.cow, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get cow {
    if ($_item.cow == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.cow!));
    final item = $_typedResult.readTableOrNull(_cowTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BovinesTable _bullTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.reproductions.bull, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bull {
    if ($_item.bull == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bull!));
    final item = $_typedResult.readTableOrNull(_bullTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BreedersTable _breederTable(_$AppDatabase db) =>
      db.breeders.createAlias(
          $_aliasNameGenerator(db.reproductions.breeder, db.breeders.name));

  $$BreedersTableProcessedTableManager? get breeder {
    if ($_item.breeder == null) return null;
    final manager = $$BreedersTableTableManager($_db, $_db.breeders)
        .filter((f) => f.name($_item.breeder!));
    final item = $_typedResult.readTableOrNull(_breederTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PregnanciesTable, List<Pregnancy>>
      _pregnanciesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.pregnancies,
              aliasName: $_aliasNameGenerator(
                  db.reproductions.id, db.pregnancies.reproduction));

  $$PregnanciesTableProcessedTableManager get pregnanciesRefs {
    final manager = $$PregnanciesTableTableManager($_db, $_db.pregnancies)
        .filter((f) => f.reproduction.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_pregnanciesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ReproductionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReproductionsTable> {
  $$ReproductionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ReproductionKind, ReproductionKind, int>
      get kind => $composableBuilder(
          column: $table.kind,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ReproductionDiagonostic,
          ReproductionDiagonostic, int>
      get diagnostic => $composableBuilder(
          column: $table.diagnostic,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get strawNumber => $composableBuilder(
      column: $table.strawNumber, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get cow {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableFilterComposer get bull {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BreedersTableFilterComposer get breeder {
    final $$BreedersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.breeder,
        referencedTable: $db.breeders,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedersTableFilterComposer(
              $db: $db,
              $table: $db.breeders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> pregnanciesRefs(
      Expression<bool> Function($$PregnanciesTableFilterComposer f) f) {
    final $$PregnanciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.reproduction,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableFilterComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ReproductionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReproductionsTable> {
  $$ReproductionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diagnostic => $composableBuilder(
      column: $table.diagnostic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get strawNumber => $composableBuilder(
      column: $table.strawNumber, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get cow {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableOrderingComposer get bull {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BreedersTableOrderingComposer get breeder {
    final $$BreedersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.breeder,
        referencedTable: $db.breeders,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedersTableOrderingComposer(
              $db: $db,
              $table: $db.breeders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReproductionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReproductionsTable> {
  $$ReproductionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReproductionKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReproductionDiagonostic, int>
      get diagnostic => $composableBuilder(
          column: $table.diagnostic, builder: (column) => column);

  GeneratedColumn<int> get strawNumber => $composableBuilder(
      column: $table.strawNumber, builder: (column) => column);

  $$BovinesTableAnnotationComposer get cow {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableAnnotationComposer get bull {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BreedersTableAnnotationComposer get breeder {
    final $$BreedersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.breeder,
        referencedTable: $db.breeders,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedersTableAnnotationComposer(
              $db: $db,
              $table: $db.breeders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> pregnanciesRefs<T extends Object>(
      Expression<T> Function($$PregnanciesTableAnnotationComposer a) f) {
    final $$PregnanciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.reproduction,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableAnnotationComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ReproductionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReproductionsTable,
    Reproduction,
    $$ReproductionsTableFilterComposer,
    $$ReproductionsTableOrderingComposer,
    $$ReproductionsTableAnnotationComposer,
    $$ReproductionsTableCreateCompanionBuilder,
    $$ReproductionsTableUpdateCompanionBuilder,
    (Reproduction, $$ReproductionsTableReferences),
    Reproduction,
    PrefetchHooks Function(
        {bool cow, bool bull, bool breeder, bool pregnanciesRefs})> {
  $$ReproductionsTableTableManager(_$AppDatabase db, $ReproductionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReproductionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReproductionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReproductionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<ReproductionKind> kind = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<ReproductionDiagonostic> diagnostic = const Value.absent(),
            Value<int> cow = const Value.absent(),
            Value<int?> bull = const Value.absent(),
            Value<String?> breeder = const Value.absent(),
            Value<int?> strawNumber = const Value.absent(),
          }) =>
              ReproductionsCompanion(
            id: id,
            kind: kind,
            date: date,
            diagnostic: diagnostic,
            cow: cow,
            bull: bull,
            breeder: breeder,
            strawNumber: strawNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required ReproductionKind kind,
            required DateTime date,
            Value<ReproductionDiagonostic> diagnostic = const Value.absent(),
            required int cow,
            Value<int?> bull = const Value.absent(),
            Value<String?> breeder = const Value.absent(),
            Value<int?> strawNumber = const Value.absent(),
          }) =>
              ReproductionsCompanion.insert(
            id: id,
            kind: kind,
            date: date,
            diagnostic: diagnostic,
            cow: cow,
            bull: bull,
            breeder: breeder,
            strawNumber: strawNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ReproductionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {cow = false,
              bull = false,
              breeder = false,
              pregnanciesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pregnanciesRefs) db.pregnancies],
              addJoins: <
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
                      dynamic>>(state) {
                if (cow) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cow,
                    referencedTable:
                        $$ReproductionsTableReferences._cowTable(db),
                    referencedColumn:
                        $$ReproductionsTableReferences._cowTable(db).earring,
                  ) as T;
                }
                if (bull) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bull,
                    referencedTable:
                        $$ReproductionsTableReferences._bullTable(db),
                    referencedColumn:
                        $$ReproductionsTableReferences._bullTable(db).earring,
                  ) as T;
                }
                if (breeder) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.breeder,
                    referencedTable:
                        $$ReproductionsTableReferences._breederTable(db),
                    referencedColumn:
                        $$ReproductionsTableReferences._breederTable(db).name,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pregnanciesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ReproductionsTableReferences
                            ._pregnanciesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ReproductionsTableReferences(db, table, p0)
                                .pregnanciesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.reproduction == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ReproductionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReproductionsTable,
    Reproduction,
    $$ReproductionsTableFilterComposer,
    $$ReproductionsTableOrderingComposer,
    $$ReproductionsTableAnnotationComposer,
    $$ReproductionsTableCreateCompanionBuilder,
    $$ReproductionsTableUpdateCompanionBuilder,
    (Reproduction, $$ReproductionsTableReferences),
    Reproduction,
    PrefetchHooks Function(
        {bool cow, bool bull, bool breeder, bool pregnanciesRefs})>;
typedef $$PregnanciesTableCreateCompanionBuilder = PregnanciesCompanion
    Function({
  Value<int> id,
  required int cow,
  required DateTime date,
  required DateTime birthForecast,
  Value<int?> reproduction,
  Value<bool> hasEnded,
  Value<String?> observation,
});
typedef $$PregnanciesTableUpdateCompanionBuilder = PregnanciesCompanion
    Function({
  Value<int> id,
  Value<int> cow,
  Value<DateTime> date,
  Value<DateTime> birthForecast,
  Value<int?> reproduction,
  Value<bool> hasEnded,
  Value<String?> observation,
});

final class $$PregnanciesTableReferences
    extends BaseReferences<_$AppDatabase, $PregnanciesTable, Pregnancy> {
  $$PregnanciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _cowTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.pregnancies.cow, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get cow {
    if ($_item.cow == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.cow!));
    final item = $_typedResult.readTableOrNull(_cowTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ReproductionsTable _reproductionTable(_$AppDatabase db) =>
      db.reproductions.createAlias($_aliasNameGenerator(
          db.pregnancies.reproduction, db.reproductions.id));

  $$ReproductionsTableProcessedTableManager? get reproduction {
    if ($_item.reproduction == null) return null;
    final manager = $$ReproductionsTableTableManager($_db, $_db.reproductions)
        .filter((f) => f.id($_item.reproduction!));
    final item = $_typedResult.readTableOrNull(_reproductionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BirthsTable, List<Birth>> _birthsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.births,
          aliasName:
              $_aliasNameGenerator(db.pregnancies.id, db.births.pregnancy));

  $$BirthsTableProcessedTableManager get birthsRefs {
    final manager = $$BirthsTableTableManager($_db, $_db.births)
        .filter((f) => f.pregnancy.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_birthsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PregnanciesTableFilterComposer
    extends Composer<_$AppDatabase, $PregnanciesTable> {
  $$PregnanciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthForecast => $composableBuilder(
      column: $table.birthForecast, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasEnded => $composableBuilder(
      column: $table.hasEnded, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get cow {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ReproductionsTableFilterComposer get reproduction {
    final $$ReproductionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reproduction,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableFilterComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> birthsRefs(
      Expression<bool> Function($$BirthsTableFilterComposer f) f) {
    final $$BirthsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.births,
        getReferencedColumn: (t) => t.pregnancy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BirthsTableFilterComposer(
              $db: $db,
              $table: $db.births,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PregnanciesTableOrderingComposer
    extends Composer<_$AppDatabase, $PregnanciesTable> {
  $$PregnanciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthForecast => $composableBuilder(
      column: $table.birthForecast,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasEnded => $composableBuilder(
      column: $table.hasEnded, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get cow {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ReproductionsTableOrderingComposer get reproduction {
    final $$ReproductionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reproduction,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableOrderingComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PregnanciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PregnanciesTable> {
  $$PregnanciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get birthForecast => $composableBuilder(
      column: $table.birthForecast, builder: (column) => column);

  GeneratedColumn<bool> get hasEnded =>
      $composableBuilder(column: $table.hasEnded, builder: (column) => column);

  GeneratedColumn<String> get observation => $composableBuilder(
      column: $table.observation, builder: (column) => column);

  $$BovinesTableAnnotationComposer get cow {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ReproductionsTableAnnotationComposer get reproduction {
    final $$ReproductionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.reproduction,
        referencedTable: $db.reproductions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReproductionsTableAnnotationComposer(
              $db: $db,
              $table: $db.reproductions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> birthsRefs<T extends Object>(
      Expression<T> Function($$BirthsTableAnnotationComposer a) f) {
    final $$BirthsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.births,
        getReferencedColumn: (t) => t.pregnancy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BirthsTableAnnotationComposer(
              $db: $db,
              $table: $db.births,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PregnanciesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PregnanciesTable,
    Pregnancy,
    $$PregnanciesTableFilterComposer,
    $$PregnanciesTableOrderingComposer,
    $$PregnanciesTableAnnotationComposer,
    $$PregnanciesTableCreateCompanionBuilder,
    $$PregnanciesTableUpdateCompanionBuilder,
    (Pregnancy, $$PregnanciesTableReferences),
    Pregnancy,
    PrefetchHooks Function({bool cow, bool reproduction, bool birthsRefs})> {
  $$PregnanciesTableTableManager(_$AppDatabase db, $PregnanciesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PregnanciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PregnanciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PregnanciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> cow = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> birthForecast = const Value.absent(),
            Value<int?> reproduction = const Value.absent(),
            Value<bool> hasEnded = const Value.absent(),
            Value<String?> observation = const Value.absent(),
          }) =>
              PregnanciesCompanion(
            id: id,
            cow: cow,
            date: date,
            birthForecast: birthForecast,
            reproduction: reproduction,
            hasEnded: hasEnded,
            observation: observation,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int cow,
            required DateTime date,
            required DateTime birthForecast,
            Value<int?> reproduction = const Value.absent(),
            Value<bool> hasEnded = const Value.absent(),
            Value<String?> observation = const Value.absent(),
          }) =>
              PregnanciesCompanion.insert(
            id: id,
            cow: cow,
            date: date,
            birthForecast: birthForecast,
            reproduction: reproduction,
            hasEnded: hasEnded,
            observation: observation,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PregnanciesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {cow = false, reproduction = false, birthsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (birthsRefs) db.births],
              addJoins: <
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
                      dynamic>>(state) {
                if (cow) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cow,
                    referencedTable: $$PregnanciesTableReferences._cowTable(db),
                    referencedColumn:
                        $$PregnanciesTableReferences._cowTable(db).earring,
                  ) as T;
                }
                if (reproduction) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.reproduction,
                    referencedTable:
                        $$PregnanciesTableReferences._reproductionTable(db),
                    referencedColumn:
                        $$PregnanciesTableReferences._reproductionTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (birthsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$PregnanciesTableReferences._birthsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PregnanciesTableReferences(db, table, p0)
                                .birthsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.pregnancy == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PregnanciesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PregnanciesTable,
    Pregnancy,
    $$PregnanciesTableFilterComposer,
    $$PregnanciesTableOrderingComposer,
    $$PregnanciesTableAnnotationComposer,
    $$PregnanciesTableCreateCompanionBuilder,
    $$PregnanciesTableUpdateCompanionBuilder,
    (Pregnancy, $$PregnanciesTableReferences),
    Pregnancy,
    PrefetchHooks Function({bool cow, bool reproduction, bool birthsRefs})>;
typedef $$BirthsTableCreateCompanionBuilder = BirthsCompanion Function({
  Value<int> bovine,
  required DateTime date,
  required double weight,
  required BodyConditionScore bcs,
  Value<int?> pregnancy,
});
typedef $$BirthsTableUpdateCompanionBuilder = BirthsCompanion Function({
  Value<int> bovine,
  Value<DateTime> date,
  Value<double> weight,
  Value<BodyConditionScore> bcs,
  Value<int?> pregnancy,
});

final class $$BirthsTableReferences
    extends BaseReferences<_$AppDatabase, $BirthsTable, Birth> {
  $$BirthsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.births.bovine, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PregnanciesTable _pregnancyTable(_$AppDatabase db) =>
      db.pregnancies.createAlias(
          $_aliasNameGenerator(db.births.pregnancy, db.pregnancies.id));

  $$PregnanciesTableProcessedTableManager? get pregnancy {
    if ($_item.pregnancy == null) return null;
    final manager = $$PregnanciesTableTableManager($_db, $_db.pregnancies)
        .filter((f) => f.id($_item.pregnancy!));
    final item = $_typedResult.readTableOrNull(_pregnancyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BirthsTableFilterComposer
    extends Composer<_$AppDatabase, $BirthsTable> {
  $$BirthsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<BodyConditionScore, BodyConditionScore, int>
      get bcs => $composableBuilder(
          column: $table.bcs,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PregnanciesTableFilterComposer get pregnancy {
    final $$PregnanciesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pregnancy,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableFilterComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BirthsTableOrderingComposer
    extends Composer<_$AppDatabase, $BirthsTable> {
  $$BirthsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bcs => $composableBuilder(
      column: $table.bcs, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PregnanciesTableOrderingComposer get pregnancy {
    final $$PregnanciesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pregnancy,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableOrderingComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BirthsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BirthsTable> {
  $$BirthsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BodyConditionScore, int> get bcs =>
      $composableBuilder(column: $table.bcs, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PregnanciesTableAnnotationComposer get pregnancy {
    final $$PregnanciesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pregnancy,
        referencedTable: $db.pregnancies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PregnanciesTableAnnotationComposer(
              $db: $db,
              $table: $db.pregnancies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BirthsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BirthsTable,
    Birth,
    $$BirthsTableFilterComposer,
    $$BirthsTableOrderingComposer,
    $$BirthsTableAnnotationComposer,
    $$BirthsTableCreateCompanionBuilder,
    $$BirthsTableUpdateCompanionBuilder,
    (Birth, $$BirthsTableReferences),
    Birth,
    PrefetchHooks Function({bool bovine, bool pregnancy})> {
  $$BirthsTableTableManager(_$AppDatabase db, $BirthsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BirthsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BirthsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BirthsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<BodyConditionScore> bcs = const Value.absent(),
            Value<int?> pregnancy = const Value.absent(),
          }) =>
              BirthsCompanion(
            bovine: bovine,
            date: date,
            weight: weight,
            bcs: bcs,
            pregnancy: pregnancy,
          ),
          createCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            required DateTime date,
            required double weight,
            required BodyConditionScore bcs,
            Value<int?> pregnancy = const Value.absent(),
          }) =>
              BirthsCompanion.insert(
            bovine: bovine,
            date: date,
            weight: weight,
            bcs: bcs,
            pregnancy: pregnancy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BirthsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovine = false, pregnancy = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable: $$BirthsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$BirthsTableReferences._bovineTable(db).earring,
                  ) as T;
                }
                if (pregnancy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pregnancy,
                    referencedTable:
                        $$BirthsTableReferences._pregnancyTable(db),
                    referencedColumn:
                        $$BirthsTableReferences._pregnancyTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BirthsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BirthsTable,
    Birth,
    $$BirthsTableFilterComposer,
    $$BirthsTableOrderingComposer,
    $$BirthsTableAnnotationComposer,
    $$BirthsTableCreateCompanionBuilder,
    $$BirthsTableUpdateCompanionBuilder,
    (Birth, $$BirthsTableReferences),
    Birth,
    PrefetchHooks Function({bool bovine, bool pregnancy})>;
typedef $$ParentingTableCreateCompanionBuilder = ParentingCompanion Function({
  Value<int> bovine,
  Value<int?> cow,
  Value<int?> bull,
  Value<String?> breeder,
});
typedef $$ParentingTableUpdateCompanionBuilder = ParentingCompanion Function({
  Value<int> bovine,
  Value<int?> cow,
  Value<int?> bull,
  Value<String?> breeder,
});

final class $$ParentingTableReferences
    extends BaseReferences<_$AppDatabase, $ParentingTable, Parents> {
  $$ParentingTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.parenting.bovine, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BovinesTable _cowTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.parenting.cow, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get cow {
    if ($_item.cow == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.cow!));
    final item = $_typedResult.readTableOrNull(_cowTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BovinesTable _bullTable(_$AppDatabase db) => db.bovines
      .createAlias($_aliasNameGenerator(db.parenting.bull, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bull {
    if ($_item.bull == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bull!));
    final item = $_typedResult.readTableOrNull(_bullTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BreedersTable _breederTable(_$AppDatabase db) =>
      db.breeders.createAlias(
          $_aliasNameGenerator(db.parenting.breeder, db.breeders.name));

  $$BreedersTableProcessedTableManager? get breeder {
    if ($_item.breeder == null) return null;
    final manager = $$BreedersTableTableManager($_db, $_db.breeders)
        .filter((f) => f.name($_item.breeder!));
    final item = $_typedResult.readTableOrNull(_breederTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ParentingTableFilterComposer
    extends Composer<_$AppDatabase, $ParentingTable> {
  $$ParentingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableFilterComposer get cow {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableFilterComposer get bull {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BreedersTableFilterComposer get breeder {
    final $$BreedersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.breeder,
        referencedTable: $db.breeders,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedersTableFilterComposer(
              $db: $db,
              $table: $db.breeders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParentingTableOrderingComposer
    extends Composer<_$AppDatabase, $ParentingTable> {
  $$ParentingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableOrderingComposer get cow {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableOrderingComposer get bull {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BreedersTableOrderingComposer get breeder {
    final $$BreedersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.breeder,
        referencedTable: $db.breeders,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedersTableOrderingComposer(
              $db: $db,
              $table: $db.breeders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParentingTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParentingTable> {
  $$ParentingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableAnnotationComposer get cow {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cow,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BovinesTableAnnotationComposer get bull {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bull,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BreedersTableAnnotationComposer get breeder {
    final $$BreedersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.breeder,
        referencedTable: $db.breeders,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BreedersTableAnnotationComposer(
              $db: $db,
              $table: $db.breeders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParentingTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ParentingTable,
    Parents,
    $$ParentingTableFilterComposer,
    $$ParentingTableOrderingComposer,
    $$ParentingTableAnnotationComposer,
    $$ParentingTableCreateCompanionBuilder,
    $$ParentingTableUpdateCompanionBuilder,
    (Parents, $$ParentingTableReferences),
    Parents,
    PrefetchHooks Function({bool bovine, bool cow, bool bull, bool breeder})> {
  $$ParentingTableTableManager(_$AppDatabase db, $ParentingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParentingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParentingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParentingTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            Value<int?> cow = const Value.absent(),
            Value<int?> bull = const Value.absent(),
            Value<String?> breeder = const Value.absent(),
          }) =>
              ParentingCompanion(
            bovine: bovine,
            cow: cow,
            bull: bull,
            breeder: breeder,
          ),
          createCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            Value<int?> cow = const Value.absent(),
            Value<int?> bull = const Value.absent(),
            Value<String?> breeder = const Value.absent(),
          }) =>
              ParentingCompanion.insert(
            bovine: bovine,
            cow: cow,
            bull: bull,
            breeder: breeder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ParentingTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {bovine = false, cow = false, bull = false, breeder = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable:
                        $$ParentingTableReferences._bovineTable(db),
                    referencedColumn:
                        $$ParentingTableReferences._bovineTable(db).earring,
                  ) as T;
                }
                if (cow) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cow,
                    referencedTable: $$ParentingTableReferences._cowTable(db),
                    referencedColumn:
                        $$ParentingTableReferences._cowTable(db).earring,
                  ) as T;
                }
                if (bull) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bull,
                    referencedTable: $$ParentingTableReferences._bullTable(db),
                    referencedColumn:
                        $$ParentingTableReferences._bullTable(db).earring,
                  ) as T;
                }
                if (breeder) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.breeder,
                    referencedTable:
                        $$ParentingTableReferences._breederTable(db),
                    referencedColumn:
                        $$ParentingTableReferences._breederTable(db).name,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ParentingTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ParentingTable,
    Parents,
    $$ParentingTableFilterComposer,
    $$ParentingTableOrderingComposer,
    $$ParentingTableAnnotationComposer,
    $$ParentingTableCreateCompanionBuilder,
    $$ParentingTableUpdateCompanionBuilder,
    (Parents, $$ParentingTableReferences),
    Parents,
    PrefetchHooks Function({bool bovine, bool cow, bool bull, bool breeder})>;
typedef $$WeaningsTableCreateCompanionBuilder = WeaningsCompanion Function({
  Value<int> bovine,
  required DateTime date,
  required double weight,
});
typedef $$WeaningsTableUpdateCompanionBuilder = WeaningsCompanion Function({
  Value<int> bovine,
  Value<DateTime> date,
  Value<double> weight,
});

final class $$WeaningsTableReferences
    extends BaseReferences<_$AppDatabase, $WeaningsTable, Weaning> {
  $$WeaningsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.weanings.bovine, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WeaningsTableFilterComposer
    extends Composer<_$AppDatabase, $WeaningsTable> {
  $$WeaningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeaningsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeaningsTable> {
  $$WeaningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeaningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeaningsTable> {
  $$WeaningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeaningsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeaningsTable,
    Weaning,
    $$WeaningsTableFilterComposer,
    $$WeaningsTableOrderingComposer,
    $$WeaningsTableAnnotationComposer,
    $$WeaningsTableCreateCompanionBuilder,
    $$WeaningsTableUpdateCompanionBuilder,
    (Weaning, $$WeaningsTableReferences),
    Weaning,
    PrefetchHooks Function({bool bovine})> {
  $$WeaningsTableTableManager(_$AppDatabase db, $WeaningsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeaningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeaningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeaningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> weight = const Value.absent(),
          }) =>
              WeaningsCompanion(
            bovine: bovine,
            date: date,
            weight: weight,
          ),
          createCompanionCallback: ({
            Value<int> bovine = const Value.absent(),
            required DateTime date,
            required double weight,
          }) =>
              WeaningsCompanion.insert(
            bovine: bovine,
            date: date,
            weight: weight,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WeaningsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable: $$WeaningsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$WeaningsTableReferences._bovineTable(db).earring,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WeaningsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeaningsTable,
    Weaning,
    $$WeaningsTableFilterComposer,
    $$WeaningsTableOrderingComposer,
    $$WeaningsTableAnnotationComposer,
    $$WeaningsTableCreateCompanionBuilder,
    $$WeaningsTableUpdateCompanionBuilder,
    (Weaning, $$WeaningsTableReferences),
    Weaning,
    PrefetchHooks Function({bool bovine})>;
typedef $$TreatmentsTableCreateCompanionBuilder = TreatmentsCompanion Function({
  Value<int> id,
  required String medicine,
  required String reason,
  required DateTime startingDate,
  required DateTime endingDate,
  required int bovine,
});
typedef $$TreatmentsTableUpdateCompanionBuilder = TreatmentsCompanion Function({
  Value<int> id,
  Value<String> medicine,
  Value<String> reason,
  Value<DateTime> startingDate,
  Value<DateTime> endingDate,
  Value<int> bovine,
});

final class $$TreatmentsTableReferences
    extends BaseReferences<_$AppDatabase, $TreatmentsTable, Treatment> {
  $$TreatmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BovinesTable _bovineTable(_$AppDatabase db) => db.bovines.createAlias(
      $_aliasNameGenerator(db.treatments.bovine, db.bovines.earring));

  $$BovinesTableProcessedTableManager? get bovine {
    if ($_item.bovine == null) return null;
    final manager = $$BovinesTableTableManager($_db, $_db.bovines)
        .filter((f) => f.earring($_item.bovine!));
    final item = $_typedResult.readTableOrNull(_bovineTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TreatmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicine => $composableBuilder(
      column: $table.medicine, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startingDate => $composableBuilder(
      column: $table.startingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endingDate => $composableBuilder(
      column: $table.endingDate, builder: (column) => ColumnFilters(column));

  $$BovinesTableFilterComposer get bovine {
    final $$BovinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableFilterComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicine => $composableBuilder(
      column: $table.medicine, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startingDate => $composableBuilder(
      column: $table.startingDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endingDate => $composableBuilder(
      column: $table.endingDate, builder: (column) => ColumnOrderings(column));

  $$BovinesTableOrderingComposer get bovine {
    final $$BovinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableOrderingComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreatmentsTable> {
  $$TreatmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicine =>
      $composableBuilder(column: $table.medicine, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get startingDate => $composableBuilder(
      column: $table.startingDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endingDate => $composableBuilder(
      column: $table.endingDate, builder: (column) => column);

  $$BovinesTableAnnotationComposer get bovine {
    final $$BovinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bovine,
        referencedTable: $db.bovines,
        getReferencedColumn: (t) => t.earring,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BovinesTableAnnotationComposer(
              $db: $db,
              $table: $db.bovines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TreatmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool bovine})> {
  $$TreatmentsTableTableManager(_$AppDatabase db, $TreatmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> medicine = const Value.absent(),
            Value<String> reason = const Value.absent(),
            Value<DateTime> startingDate = const Value.absent(),
            Value<DateTime> endingDate = const Value.absent(),
            Value<int> bovine = const Value.absent(),
          }) =>
              TreatmentsCompanion(
            id: id,
            medicine: medicine,
            reason: reason,
            startingDate: startingDate,
            endingDate: endingDate,
            bovine: bovine,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String medicine,
            required String reason,
            required DateTime startingDate,
            required DateTime endingDate,
            required int bovine,
          }) =>
              TreatmentsCompanion.insert(
            id: id,
            medicine: medicine,
            reason: reason,
            startingDate: startingDate,
            endingDate: endingDate,
            bovine: bovine,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TreatmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bovine = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (bovine) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bovine,
                    referencedTable:
                        $$TreatmentsTableReferences._bovineTable(db),
                    referencedColumn:
                        $$TreatmentsTableReferences._bovineTable(db).earring,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TreatmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TreatmentsTable,
    Treatment,
    $$TreatmentsTableFilterComposer,
    $$TreatmentsTableOrderingComposer,
    $$TreatmentsTableAnnotationComposer,
    $$TreatmentsTableCreateCompanionBuilder,
    $$TreatmentsTableUpdateCompanionBuilder,
    (Treatment, $$TreatmentsTableReferences),
    Treatment,
    PrefetchHooks Function({bool bovine})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BovinesTableTableManager get bovines =>
      $$BovinesTableTableManager(_db, _db.bovines);
  $$BovinesEntryTableTableManager get bovinesEntry =>
      $$BovinesEntryTableTableManager(_db, _db.bovinesEntry);
  $$BreedersTableTableManager get breeders =>
      $$BreedersTableTableManager(_db, _db.breeders);
  $$DiscardsTableTableManager get discards =>
      $$DiscardsTableTableManager(_db, _db.discards);
  $$ReproductionsTableTableManager get reproductions =>
      $$ReproductionsTableTableManager(_db, _db.reproductions);
  $$PregnanciesTableTableManager get pregnancies =>
      $$PregnanciesTableTableManager(_db, _db.pregnancies);
  $$BirthsTableTableManager get births =>
      $$BirthsTableTableManager(_db, _db.births);
  $$ParentingTableTableManager get parenting =>
      $$ParentingTableTableManager(_db, _db.parenting);
  $$WeaningsTableTableManager get weanings =>
      $$WeaningsTableTableManager(_db, _db.weanings);
  $$TreatmentsTableTableManager get treatments =>
      $$TreatmentsTableTableManager(_db, _db.treatments);
}
