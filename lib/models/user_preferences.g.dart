// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserPreferencesCollection on Isar {
  IsarCollection<UserPreferences> get userPreferences => this.collection();
}

const UserPreferencesSchema = CollectionSchema(
  name: r'UserPreferences',
  id: -7545901164102504045,
  properties: {
    r'age': PropertySchema(
      id: 0,
      name: r'age',
      type: IsarType.long,
    ),
    r'bmi': PropertySchema(
      id: 1,
      name: r'bmi',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'fitnessLevel': PropertySchema(
      id: 3,
      name: r'fitnessLevel',
      type: IsarType.string,
      enumMap: _UserPreferencesfitnessLevelEnumValueMap,
    ),
    r'goal': PropertySchema(
      id: 4,
      name: r'goal',
      type: IsarType.string,
      enumMap: _UserPreferencesgoalEnumValueMap,
    ),
    r'height': PropertySchema(
      id: 5,
      name: r'height',
      type: IsarType.double,
    ),
    r'heightUnit': PropertySchema(
      id: 6,
      name: r'heightUnit',
      type: IsarType.string,
      enumMap: _UserPreferencesheightUnitEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 7,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'weight': PropertySchema(
      id: 8,
      name: r'weight',
      type: IsarType.double,
    ),
    r'weightUnit': PropertySchema(
      id: 9,
      name: r'weightUnit',
      type: IsarType.string,
      enumMap: _UserPreferencesweightUnitEnumValueMap,
    )
  },
  estimateSize: _userPreferencesEstimateSize,
  serialize: _userPreferencesSerialize,
  deserialize: _userPreferencesDeserialize,
  deserializeProp: _userPreferencesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userPreferencesGetId,
  getLinks: _userPreferencesGetLinks,
  attach: _userPreferencesAttach,
  version: '3.1.0+1',
);

int _userPreferencesEstimateSize(
  UserPreferences object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fitnessLevel;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.goal;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.heightUnit.name.length * 3;
  bytesCount += 3 + object.weightUnit.name.length * 3;
  return bytesCount;
}

void _userPreferencesSerialize(
  UserPreferences object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.age);
  writer.writeDouble(offsets[1], object.bmi);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.fitnessLevel?.name);
  writer.writeString(offsets[4], object.goal?.name);
  writer.writeDouble(offsets[5], object.height);
  writer.writeString(offsets[6], object.heightUnit.name);
  writer.writeDateTime(offsets[7], object.updatedAt);
  writer.writeDouble(offsets[8], object.weight);
  writer.writeString(offsets[9], object.weightUnit.name);
}

UserPreferences _userPreferencesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserPreferences(
    age: reader.readLongOrNull(offsets[0]),
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    fitnessLevel: _UserPreferencesfitnessLevelValueEnumMap[
        reader.readStringOrNull(offsets[3])],
    goal: _UserPreferencesgoalValueEnumMap[reader.readStringOrNull(offsets[4])],
    height: reader.readDoubleOrNull(offsets[5]),
    heightUnit: _UserPreferencesheightUnitValueEnumMap[
            reader.readStringOrNull(offsets[6])] ??
        HeightUnit.cm,
    updatedAt: reader.readDateTimeOrNull(offsets[7]),
    weight: reader.readDoubleOrNull(offsets[8]),
    weightUnit: _UserPreferencesweightUnitValueEnumMap[
            reader.readStringOrNull(offsets[9])] ??
        WeightUnit.kg,
  );
  object.id = id;
  return object;
}

P _userPreferencesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (_UserPreferencesfitnessLevelValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 4:
      return (_UserPreferencesgoalValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (_UserPreferencesheightUnitValueEnumMap[
              reader.readStringOrNull(offset)] ??
          HeightUnit.cm) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (_UserPreferencesweightUnitValueEnumMap[
              reader.readStringOrNull(offset)] ??
          WeightUnit.kg) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserPreferencesfitnessLevelEnumValueMap = {
  r'beginner': r'beginner',
  r'intermediate': r'intermediate',
  r'advanced': r'advanced',
};
const _UserPreferencesfitnessLevelValueEnumMap = {
  r'beginner': FitnessLevel.beginner,
  r'intermediate': FitnessLevel.intermediate,
  r'advanced': FitnessLevel.advanced,
};
const _UserPreferencesgoalEnumValueMap = {
  r'loseWeight': r'loseWeight',
  r'buildMuscle': r'buildMuscle',
  r'maintainFitness': r'maintainFitness',
  r'increaseEndurance': r'increaseEndurance',
  r'general': r'general',
};
const _UserPreferencesgoalValueEnumMap = {
  r'loseWeight': FitnessGoal.loseWeight,
  r'buildMuscle': FitnessGoal.buildMuscle,
  r'maintainFitness': FitnessGoal.maintainFitness,
  r'increaseEndurance': FitnessGoal.increaseEndurance,
  r'general': FitnessGoal.general,
};
const _UserPreferencesheightUnitEnumValueMap = {
  r'cm': r'cm',
  r'inches': r'inches',
};
const _UserPreferencesheightUnitValueEnumMap = {
  r'cm': HeightUnit.cm,
  r'inches': HeightUnit.inches,
};
const _UserPreferencesweightUnitEnumValueMap = {
  r'kg': r'kg',
  r'lbs': r'lbs',
};
const _UserPreferencesweightUnitValueEnumMap = {
  r'kg': WeightUnit.kg,
  r'lbs': WeightUnit.lbs,
};

Id _userPreferencesGetId(UserPreferences object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userPreferencesGetLinks(UserPreferences object) {
  return [];
}

void _userPreferencesAttach(
    IsarCollection<dynamic> col, Id id, UserPreferences object) {
  object.id = id;
}

extension UserPreferencesQueryWhereSort
    on QueryBuilder<UserPreferences, UserPreferences, QWhere> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserPreferencesQueryWhere
    on QueryBuilder<UserPreferences, UserPreferences, QWhereClause> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserPreferencesQueryFilter
    on QueryBuilder<UserPreferences, UserPreferences, QFilterCondition> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      ageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'age',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      ageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'age',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      ageEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      ageGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      ageLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      ageBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'age',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      bmiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bmi',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      bmiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bmi',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      bmiEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      bmiGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      bmiLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      bmiBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bmi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fitnessLevel',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fitnessLevel',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelEqualTo(
    FitnessLevel? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelGreaterThan(
    FitnessLevel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelLessThan(
    FitnessLevel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelBetween(
    FitnessLevel? lower,
    FitnessLevel? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fitnessLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fitnessLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fitnessLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fitnessLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      fitnessLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fitnessLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'goal',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'goal',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalEqualTo(
    FitnessGoal? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalGreaterThan(
    FitnessGoal? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalLessThan(
    FitnessGoal? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalBetween(
    FitnessGoal? lower,
    FitnessGoal? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goal',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      goalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goal',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitEqualTo(
    HeightUnit value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitGreaterThan(
    HeightUnit value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitLessThan(
    HeightUnit value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitBetween(
    HeightUnit lower,
    HeightUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heightUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'heightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'heightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'heightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'heightUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      heightUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'heightUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitEqualTo(
    WeightUnit value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitGreaterThan(
    WeightUnit value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitLessThan(
    WeightUnit value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitBetween(
    WeightUnit lower,
    WeightUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'weightUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'weightUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      weightUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'weightUnit',
        value: '',
      ));
    });
  }
}

extension UserPreferencesQueryObject
    on QueryBuilder<UserPreferences, UserPreferences, QFilterCondition> {}

extension UserPreferencesQueryLinks
    on QueryBuilder<UserPreferences, UserPreferences, QFilterCondition> {}

extension UserPreferencesQuerySortBy
    on QueryBuilder<UserPreferences, UserPreferences, QSortBy> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByBmiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByFitnessLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByFitnessLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByHeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightUnit', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByHeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightUnit', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.desc);
    });
  }
}

extension UserPreferencesQuerySortThenBy
    on QueryBuilder<UserPreferences, UserPreferences, QSortThenBy> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByBmiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByFitnessLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByFitnessLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fitnessLevel', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goal', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByHeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightUnit', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByHeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightUnit', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.desc);
    });
  }
}

extension UserPreferencesQueryWhereDistinct
    on QueryBuilder<UserPreferences, UserPreferences, QDistinct> {
  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'age');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bmi');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByFitnessLevel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fitnessLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByGoal(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByHeightUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heightUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByWeightUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightUnit', caseSensitive: caseSensitive);
    });
  }
}

extension UserPreferencesQueryProperty
    on QueryBuilder<UserPreferences, UserPreferences, QQueryProperty> {
  QueryBuilder<UserPreferences, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserPreferences, int?, QQueryOperations> ageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'age');
    });
  }

  QueryBuilder<UserPreferences, double?, QQueryOperations> bmiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bmi');
    });
  }

  QueryBuilder<UserPreferences, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<UserPreferences, FitnessLevel?, QQueryOperations>
      fitnessLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fitnessLevel');
    });
  }

  QueryBuilder<UserPreferences, FitnessGoal?, QQueryOperations> goalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goal');
    });
  }

  QueryBuilder<UserPreferences, double?, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<UserPreferences, HeightUnit, QQueryOperations>
      heightUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heightUnit');
    });
  }

  QueryBuilder<UserPreferences, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<UserPreferences, double?, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }

  QueryBuilder<UserPreferences, WeightUnit, QQueryOperations>
      weightUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightUnit');
    });
  }
}
