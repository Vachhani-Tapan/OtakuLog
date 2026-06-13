// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGoalModelCollection on Isar {
  IsarCollection<GoalModel> get goalModels => this.collection();
}

const GoalModelSchema = CollectionSchema(
  name: r'GoalModel',
  id: -1812259076224842086,
  properties: {
    r'goalType': PropertySchema(
      id: 0,
      name: r'goalType',
      type: IsarType.string,
    ),
    r'month': PropertySchema(
      id: 1,
      name: r'month',
      type: IsarType.long,
    ),
    r'targetValue': PropertySchema(
      id: 2,
      name: r'targetValue',
      type: IsarType.long,
    ),
    r'year': PropertySchema(
      id: 3,
      name: r'year',
      type: IsarType.long,
    )
  },
  estimateSize: _goalModelEstimateSize,
  serialize: _goalModelSerialize,
  deserialize: _goalModelDeserialize,
  deserializeProp: _goalModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'goalType_month_year': IndexSchema(
      id: -8501649641600268170,
      name: r'goalType_month_year',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'goalType',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'month',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'year',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _goalModelGetId,
  getLinks: _goalModelGetLinks,
  attach: _goalModelAttach,
  version: '3.1.0+1',
);

int _goalModelEstimateSize(
  GoalModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.goalType.length * 3;
  return bytesCount;
}

void _goalModelSerialize(
  GoalModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.goalType);
  writer.writeLong(offsets[1], object.month);
  writer.writeLong(offsets[2], object.targetValue);
  writer.writeLong(offsets[3], object.year);
}

GoalModel _goalModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoalModel();
  object.goalType = reader.readString(offsets[0]);
  object.id = id;
  object.month = reader.readLong(offsets[1]);
  object.targetValue = reader.readLong(offsets[2]);
  object.year = reader.readLong(offsets[3]);
  return object;
}

P _goalModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _goalModelGetId(GoalModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _goalModelGetLinks(GoalModel object) {
  return [];
}

void _goalModelAttach(IsarCollection<dynamic> col, Id id, GoalModel object) {
  object.id = id;
}

extension GoalModelByIndex on IsarCollection<GoalModel> {
  Future<GoalModel?> getByGoalTypeMonthYear(
      String goalType, int month, int year) {
    return getByIndex(r'goalType_month_year', [goalType, month, year]);
  }

  GoalModel? getByGoalTypeMonthYearSync(String goalType, int month, int year) {
    return getByIndexSync(r'goalType_month_year', [goalType, month, year]);
  }

  Future<bool> deleteByGoalTypeMonthYear(String goalType, int month, int year) {
    return deleteByIndex(r'goalType_month_year', [goalType, month, year]);
  }

  bool deleteByGoalTypeMonthYearSync(String goalType, int month, int year) {
    return deleteByIndexSync(r'goalType_month_year', [goalType, month, year]);
  }

  Future<List<GoalModel?>> getAllByGoalTypeMonthYear(
      List<String> goalTypeValues,
      List<int> monthValues,
      List<int> yearValues) {
    final len = goalTypeValues.length;
    assert(monthValues.length == len && yearValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([goalTypeValues[i], monthValues[i], yearValues[i]]);
    }

    return getAllByIndex(r'goalType_month_year', values);
  }

  List<GoalModel?> getAllByGoalTypeMonthYearSync(List<String> goalTypeValues,
      List<int> monthValues, List<int> yearValues) {
    final len = goalTypeValues.length;
    assert(monthValues.length == len && yearValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([goalTypeValues[i], monthValues[i], yearValues[i]]);
    }

    return getAllByIndexSync(r'goalType_month_year', values);
  }

  Future<int> deleteAllByGoalTypeMonthYear(List<String> goalTypeValues,
      List<int> monthValues, List<int> yearValues) {
    final len = goalTypeValues.length;
    assert(monthValues.length == len && yearValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([goalTypeValues[i], monthValues[i], yearValues[i]]);
    }

    return deleteAllByIndex(r'goalType_month_year', values);
  }

  int deleteAllByGoalTypeMonthYearSync(List<String> goalTypeValues,
      List<int> monthValues, List<int> yearValues) {
    final len = goalTypeValues.length;
    assert(monthValues.length == len && yearValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([goalTypeValues[i], monthValues[i], yearValues[i]]);
    }

    return deleteAllByIndexSync(r'goalType_month_year', values);
  }

  Future<Id> putByGoalTypeMonthYear(GoalModel object) {
    return putByIndex(r'goalType_month_year', object);
  }

  Id putByGoalTypeMonthYearSync(GoalModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'goalType_month_year', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGoalTypeMonthYear(List<GoalModel> objects) {
    return putAllByIndex(r'goalType_month_year', objects);
  }

  List<Id> putAllByGoalTypeMonthYearSync(List<GoalModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'goalType_month_year', objects,
        saveLinks: saveLinks);
  }
}

extension GoalModelQueryWhereSort
    on QueryBuilder<GoalModel, GoalModel, QWhere> {
  QueryBuilder<GoalModel, GoalModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GoalModelQueryWhere
    on QueryBuilder<GoalModel, GoalModel, QWhereClause> {
  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeEqualToAnyMonthYear(String goalType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'goalType_month_year',
        value: [goalType],
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeNotEqualToAnyMonthYear(String goalType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [],
              upper: [goalType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [],
              upper: [goalType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeMonthEqualToAnyYear(String goalType, int month) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'goalType_month_year',
        value: [goalType, month],
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeEqualToMonthNotEqualToAnyYear(String goalType, int month) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType],
              upper: [goalType, month],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType, month],
              includeLower: false,
              upper: [goalType],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType, month],
              includeLower: false,
              upper: [goalType],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType],
              upper: [goalType, month],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeEqualToMonthGreaterThanAnyYear(
    String goalType,
    int month, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'goalType_month_year',
        lower: [goalType, month],
        includeLower: include,
        upper: [goalType],
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeEqualToMonthLessThanAnyYear(
    String goalType,
    int month, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'goalType_month_year',
        lower: [goalType],
        upper: [goalType, month],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeEqualToMonthBetweenAnyYear(
    String goalType,
    int lowerMonth,
    int upperMonth, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'goalType_month_year',
        lower: [goalType, lowerMonth],
        includeLower: includeLower,
        upper: [goalType, upperMonth],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeMonthYearEqualTo(String goalType, int month, int year) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'goalType_month_year',
        value: [goalType, month, year],
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeMonthEqualToYearNotEqualTo(String goalType, int month, int year) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType, month],
              upper: [goalType, month, year],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType, month, year],
              includeLower: false,
              upper: [goalType, month],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType, month, year],
              includeLower: false,
              upper: [goalType, month],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'goalType_month_year',
              lower: [goalType, month],
              upper: [goalType, month, year],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeMonthEqualToYearGreaterThan(
    String goalType,
    int month,
    int year, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'goalType_month_year',
        lower: [goalType, month, year],
        includeLower: include,
        upper: [goalType, month],
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeMonthEqualToYearLessThan(
    String goalType,
    int month,
    int year, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'goalType_month_year',
        lower: [goalType, month],
        upper: [goalType, month, year],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterWhereClause>
      goalTypeMonthEqualToYearBetween(
    String goalType,
    int month,
    int lowerYear,
    int upperYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'goalType_month_year',
        lower: [goalType, month, lowerYear],
        includeLower: includeLower,
        upper: [goalType, month, upperYear],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GoalModelQueryFilter
    on QueryBuilder<GoalModel, GoalModel, QFilterCondition> {
  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'goalType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'goalType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> goalTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalType',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
      goalTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'goalType',
        value: '',
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> monthEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> monthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> monthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'month',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> monthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'month',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> targetValueEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetValue',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition>
      targetValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetValue',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> targetValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetValue',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> targetValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> yearEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> yearGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> yearLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterFilterCondition> yearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GoalModelQueryObject
    on QueryBuilder<GoalModel, GoalModel, QFilterCondition> {}

extension GoalModelQueryLinks
    on QueryBuilder<GoalModel, GoalModel, QFilterCondition> {}

extension GoalModelQuerySortBy on QueryBuilder<GoalModel, GoalModel, QSortBy> {
  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByGoalType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByGoalTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByTargetValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetValue', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByTargetValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetValue', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension GoalModelQuerySortThenBy
    on QueryBuilder<GoalModel, GoalModel, QSortThenBy> {
  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByGoalType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByGoalTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalType', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'month', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByTargetValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetValue', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByTargetValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetValue', Sort.desc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension GoalModelQueryWhereDistinct
    on QueryBuilder<GoalModel, GoalModel, QDistinct> {
  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByGoalType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'month');
    });
  }

  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByTargetValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetValue');
    });
  }

  QueryBuilder<GoalModel, GoalModel, QDistinct> distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension GoalModelQueryProperty
    on QueryBuilder<GoalModel, GoalModel, QQueryProperty> {
  QueryBuilder<GoalModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GoalModel, String, QQueryOperations> goalTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalType');
    });
  }

  QueryBuilder<GoalModel, int, QQueryOperations> monthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'month');
    });
  }

  QueryBuilder<GoalModel, int, QQueryOperations> targetValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetValue');
    });
  }

  QueryBuilder<GoalModel, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
