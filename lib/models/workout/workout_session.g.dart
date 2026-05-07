// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutSessionCollection on Isar {
  IsarCollection<WorkoutSession> get workoutSessions => this.collection();
}

const WorkoutSessionSchema = CollectionSchema(
  name: r'WorkoutSession',
  id: 3465719098422617094,
  properties: {
    r'completedExercises': PropertySchema(
      id: 0,
      name: r'completedExercises',
      type: IsarType.long,
    ),
    r'endTime': PropertySchema(
      id: 1,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'exercises': PropertySchema(
      id: 2,
      name: r'exercises',
      type: IsarType.objectList,
      target: r'CompletedExercise',
    ),
    r'isCompleted': PropertySchema(
      id: 3,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'startTime': PropertySchema(
      id: 4,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'totalDuration': PropertySchema(
      id: 5,
      name: r'totalDuration',
      type: IsarType.long,
    ),
    r'totalExercises': PropertySchema(
      id: 6,
      name: r'totalExercises',
      type: IsarType.long,
    ),
    r'workoutPlanId': PropertySchema(
      id: 7,
      name: r'workoutPlanId',
      type: IsarType.string,
    ),
    r'workoutPlanName': PropertySchema(
      id: 8,
      name: r'workoutPlanName',
      type: IsarType.string,
    )
  },
  estimateSize: _workoutSessionEstimateSize,
  serialize: _workoutSessionSerialize,
  deserialize: _workoutSessionDeserialize,
  deserializeProp: _workoutSessionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'CompletedExercise': CompletedExerciseSchema},
  getId: _workoutSessionGetId,
  getLinks: _workoutSessionGetLinks,
  attach: _workoutSessionAttach,
  version: '3.1.0+1',
);

int _workoutSessionEstimateSize(
  WorkoutSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.exercises;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CompletedExercise]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CompletedExerciseSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.workoutPlanId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.workoutPlanName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _workoutSessionSerialize(
  WorkoutSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.completedExercises);
  writer.writeDateTime(offsets[1], object.endTime);
  writer.writeObjectList<CompletedExercise>(
    offsets[2],
    allOffsets,
    CompletedExerciseSchema.serialize,
    object.exercises,
  );
  writer.writeBool(offsets[3], object.isCompleted);
  writer.writeDateTime(offsets[4], object.startTime);
  writer.writeLong(offsets[5], object.totalDuration);
  writer.writeLong(offsets[6], object.totalExercises);
  writer.writeString(offsets[7], object.workoutPlanId);
  writer.writeString(offsets[8], object.workoutPlanName);
}

WorkoutSession _workoutSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutSession(
    completedExercises: reader.readLongOrNull(offsets[0]),
    endTime: reader.readDateTimeOrNull(offsets[1]),
    exercises: reader.readObjectList<CompletedExercise>(
      offsets[2],
      CompletedExerciseSchema.deserialize,
      allOffsets,
      CompletedExercise(),
    ),
    isCompleted: reader.readBoolOrNull(offsets[3]) ?? false,
    startTime: reader.readDateTimeOrNull(offsets[4]),
    totalDuration: reader.readLongOrNull(offsets[5]),
    totalExercises: reader.readLongOrNull(offsets[6]),
    workoutPlanId: reader.readStringOrNull(offsets[7]),
    workoutPlanName: reader.readStringOrNull(offsets[8]),
  );
  object.id = id;
  return object;
}

P _workoutSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<CompletedExercise>(
        offset,
        CompletedExerciseSchema.deserialize,
        allOffsets,
        CompletedExercise(),
      )) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutSessionGetId(WorkoutSession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutSessionGetLinks(WorkoutSession object) {
  return [];
}

void _workoutSessionAttach(
    IsarCollection<dynamic> col, Id id, WorkoutSession object) {
  object.id = id;
}

extension WorkoutSessionQueryWhereSort
    on QueryBuilder<WorkoutSession, WorkoutSession, QWhere> {
  QueryBuilder<WorkoutSession, WorkoutSession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutSessionQueryWhere
    on QueryBuilder<WorkoutSession, WorkoutSession, QWhereClause> {
  QueryBuilder<WorkoutSession, WorkoutSession, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterWhereClause> idBetween(
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

extension WorkoutSessionQueryFilter
    on QueryBuilder<WorkoutSession, WorkoutSession, QFilterCondition> {
  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      completedExercisesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedExercises',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      completedExercisesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedExercises',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      completedExercisesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedExercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      completedExercisesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedExercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      completedExercisesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedExercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      completedExercisesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedExercises',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      endTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      endTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      endTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exercises',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exercises',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'exercises',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
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

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      startTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      startTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      startTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      startTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalDuration',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalDuration',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalDurationEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalDurationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalDurationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalDurationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalExercisesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalExercises',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalExercisesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalExercises',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalExercisesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalExercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalExercisesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalExercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalExercisesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalExercises',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      totalExercisesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalExercises',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workoutPlanId',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workoutPlanId',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutPlanId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workoutPlanId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workoutPlanId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workoutPlanId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'workoutPlanId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'workoutPlanId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'workoutPlanId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'workoutPlanId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutPlanId',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'workoutPlanId',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workoutPlanName',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workoutPlanName',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutPlanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workoutPlanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workoutPlanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workoutPlanName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'workoutPlanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'workoutPlanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'workoutPlanName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'workoutPlanName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutPlanName',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      workoutPlanNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'workoutPlanName',
        value: '',
      ));
    });
  }
}

extension WorkoutSessionQueryObject
    on QueryBuilder<WorkoutSession, WorkoutSession, QFilterCondition> {
  QueryBuilder<WorkoutSession, WorkoutSession, QAfterFilterCondition>
      exercisesElement(FilterQuery<CompletedExercise> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'exercises');
    });
  }
}

extension WorkoutSessionQueryLinks
    on QueryBuilder<WorkoutSession, WorkoutSession, QFilterCondition> {}

extension WorkoutSessionQuerySortBy
    on QueryBuilder<WorkoutSession, WorkoutSession, QSortBy> {
  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByCompletedExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedExercises', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByCompletedExercisesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedExercises', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByTotalExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExercises', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByTotalExercisesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExercises', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByWorkoutPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByWorkoutPlanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanId', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByWorkoutPlanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanName', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      sortByWorkoutPlanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanName', Sort.desc);
    });
  }
}

extension WorkoutSessionQuerySortThenBy
    on QueryBuilder<WorkoutSession, WorkoutSession, QSortThenBy> {
  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByCompletedExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedExercises', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByCompletedExercisesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedExercises', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByTotalExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExercises', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByTotalExercisesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExercises', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByWorkoutPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanId', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByWorkoutPlanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanId', Sort.desc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByWorkoutPlanName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanName', Sort.asc);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QAfterSortBy>
      thenByWorkoutPlanNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutPlanName', Sort.desc);
    });
  }
}

extension WorkoutSessionQueryWhereDistinct
    on QueryBuilder<WorkoutSession, WorkoutSession, QDistinct> {
  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct>
      distinctByCompletedExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedExercises');
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct>
      distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct>
      distinctByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDuration');
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct>
      distinctByTotalExercises() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalExercises');
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct>
      distinctByWorkoutPlanId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutPlanId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutSession, WorkoutSession, QDistinct>
      distinctByWorkoutPlanName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutPlanName',
          caseSensitive: caseSensitive);
    });
  }
}

extension WorkoutSessionQueryProperty
    on QueryBuilder<WorkoutSession, WorkoutSession, QQueryProperty> {
  QueryBuilder<WorkoutSession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutSession, int?, QQueryOperations>
      completedExercisesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedExercises');
    });
  }

  QueryBuilder<WorkoutSession, DateTime?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<WorkoutSession, List<CompletedExercise>?, QQueryOperations>
      exercisesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exercises');
    });
  }

  QueryBuilder<WorkoutSession, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<WorkoutSession, DateTime?, QQueryOperations>
      startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<WorkoutSession, int?, QQueryOperations> totalDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDuration');
    });
  }

  QueryBuilder<WorkoutSession, int?, QQueryOperations>
      totalExercisesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalExercises');
    });
  }

  QueryBuilder<WorkoutSession, String?, QQueryOperations>
      workoutPlanIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutPlanId');
    });
  }

  QueryBuilder<WorkoutSession, String?, QQueryOperations>
      workoutPlanNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutPlanName');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CompletedExerciseSchema = Schema(
  name: r'CompletedExercise',
  id: -5522568464605476811,
  properties: {
    r'completedAt': PropertySchema(
      id: 0,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'duration': PropertySchema(
      id: 1,
      name: r'duration',
      type: IsarType.long,
    ),
    r'exerciseId': PropertySchema(
      id: 2,
      name: r'exerciseId',
      type: IsarType.string,
    ),
    r'exerciseName': PropertySchema(
      id: 3,
      name: r'exerciseName',
      type: IsarType.string,
    ),
    r'isCompleted': PropertySchema(
      id: 4,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'reps': PropertySchema(
      id: 5,
      name: r'reps',
      type: IsarType.long,
    ),
    r'sets': PropertySchema(
      id: 6,
      name: r'sets',
      type: IsarType.long,
    )
  },
  estimateSize: _completedExerciseEstimateSize,
  serialize: _completedExerciseSerialize,
  deserialize: _completedExerciseDeserialize,
  deserializeProp: _completedExerciseDeserializeProp,
);

int _completedExerciseEstimateSize(
  CompletedExercise object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.exerciseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.exerciseName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _completedExerciseSerialize(
  CompletedExercise object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completedAt);
  writer.writeLong(offsets[1], object.duration);
  writer.writeString(offsets[2], object.exerciseId);
  writer.writeString(offsets[3], object.exerciseName);
  writer.writeBool(offsets[4], object.isCompleted);
  writer.writeLong(offsets[5], object.reps);
  writer.writeLong(offsets[6], object.sets);
}

CompletedExercise _completedExerciseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompletedExercise(
    completedAt: reader.readDateTimeOrNull(offsets[0]),
    duration: reader.readLongOrNull(offsets[1]),
    exerciseId: reader.readStringOrNull(offsets[2]),
    exerciseName: reader.readStringOrNull(offsets[3]),
    isCompleted: reader.readBoolOrNull(offsets[4]) ?? false,
    reps: reader.readLongOrNull(offsets[5]),
    sets: reader.readLongOrNull(offsets[6]),
  );
  return object;
}

P _completedExerciseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CompletedExerciseQueryFilter
    on QueryBuilder<CompletedExercise, CompletedExercise, QFilterCondition> {
  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      durationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      durationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      durationEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      durationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      durationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      durationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exerciseId',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exerciseId',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseId',
        value: '',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseId',
        value: '',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exerciseName',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exerciseName',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      exerciseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      repsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reps',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      repsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reps',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      repsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      repsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      repsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reps',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      repsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      setsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sets',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      setsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sets',
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      setsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      setsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      setsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sets',
        value: value,
      ));
    });
  }

  QueryBuilder<CompletedExercise, CompletedExercise, QAfterFilterCondition>
      setsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CompletedExerciseQueryObject
    on QueryBuilder<CompletedExercise, CompletedExercise, QFilterCondition> {}
