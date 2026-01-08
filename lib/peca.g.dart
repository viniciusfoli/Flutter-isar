// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peca.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPecaCollection on Isar {
  IsarCollection<Peca> get pecas => this.collection();
}

const PecaSchema = CollectionSchema(
  name: r'Peca',
  id: 5485410143358610903,
  properties: {
    r'cid': PropertySchema(
      id: 0,
      name: r'cid',
      type: IsarType.string,
    ),
    r'nome': PropertySchema(
      id: 1,
      name: r'nome',
      type: IsarType.string,
    ),
    r'temperatura': PropertySchema(
      id: 2,
      name: r'temperatura',
      type: IsarType.double,
    ),
    r'vibracao': PropertySchema(
      id: 3,
      name: r'vibracao',
      type: IsarType.double,
    )
  },
  estimateSize: _pecaEstimateSize,
  serialize: _pecaSerialize,
  deserialize: _pecaDeserialize,
  deserializeProp: _pecaDeserializeProp,
  idName: r'id',
  indexes: {
    r'cid': IndexSchema(
      id: 2203098626925536187,
      name: r'cid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'cid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _pecaGetId,
  getLinks: _pecaGetLinks,
  attach: _pecaAttach,
  version: '3.1.0+1',
);

int _pecaEstimateSize(
  Peca object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cid.length * 3;
  bytesCount += 3 + object.nome.length * 3;
  return bytesCount;
}

void _pecaSerialize(
  Peca object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cid);
  writer.writeString(offsets[1], object.nome);
  writer.writeDouble(offsets[2], object.temperatura);
  writer.writeDouble(offsets[3], object.vibracao);
}

Peca _pecaDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Peca();
  object.cid = reader.readString(offsets[0]);
  object.id = id;
  object.nome = reader.readString(offsets[1]);
  object.temperatura = reader.readDoubleOrNull(offsets[2]);
  object.vibracao = reader.readDoubleOrNull(offsets[3]);
  return object;
}

P _pecaDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pecaGetId(Peca object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pecaGetLinks(Peca object) {
  return [];
}

void _pecaAttach(IsarCollection<dynamic> col, Id id, Peca object) {
  object.id = id;
}

extension PecaByIndex on IsarCollection<Peca> {
  Future<Peca?> getByCid(String cid) {
    return getByIndex(r'cid', [cid]);
  }

  Peca? getByCidSync(String cid) {
    return getByIndexSync(r'cid', [cid]);
  }

  Future<bool> deleteByCid(String cid) {
    return deleteByIndex(r'cid', [cid]);
  }

  bool deleteByCidSync(String cid) {
    return deleteByIndexSync(r'cid', [cid]);
  }

  Future<List<Peca?>> getAllByCid(List<String> cidValues) {
    final values = cidValues.map((e) => [e]).toList();
    return getAllByIndex(r'cid', values);
  }

  List<Peca?> getAllByCidSync(List<String> cidValues) {
    final values = cidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'cid', values);
  }

  Future<int> deleteAllByCid(List<String> cidValues) {
    final values = cidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'cid', values);
  }

  int deleteAllByCidSync(List<String> cidValues) {
    final values = cidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'cid', values);
  }

  Future<Id> putByCid(Peca object) {
    return putByIndex(r'cid', object);
  }

  Id putByCidSync(Peca object, {bool saveLinks = true}) {
    return putByIndexSync(r'cid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCid(List<Peca> objects) {
    return putAllByIndex(r'cid', objects);
  }

  List<Id> putAllByCidSync(List<Peca> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'cid', objects, saveLinks: saveLinks);
  }
}

extension PecaQueryWhereSort on QueryBuilder<Peca, Peca, QWhere> {
  QueryBuilder<Peca, Peca, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PecaQueryWhere on QueryBuilder<Peca, Peca, QWhereClause> {
  QueryBuilder<Peca, Peca, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Peca, Peca, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Peca, Peca, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Peca, Peca, QAfterWhereClause> idBetween(
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

  QueryBuilder<Peca, Peca, QAfterWhereClause> cidEqualTo(String cid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'cid',
        value: [cid],
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterWhereClause> cidNotEqualTo(String cid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cid',
              lower: [],
              upper: [cid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cid',
              lower: [cid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cid',
              lower: [cid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cid',
              lower: [],
              upper: [cid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PecaQueryFilter on QueryBuilder<Peca, Peca, QFilterCondition> {
  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cid',
        value: '',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> cidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cid',
        value: '',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Peca, Peca, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Peca, Peca, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> temperaturaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'temperatura',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> temperaturaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'temperatura',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> temperaturaEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperatura',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> temperaturaGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temperatura',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> temperaturaLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temperatura',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> temperaturaBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temperatura',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> vibracaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vibracao',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> vibracaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vibracao',
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> vibracaoEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vibracao',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> vibracaoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vibracao',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> vibracaoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vibracao',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peca, Peca, QAfterFilterCondition> vibracaoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vibracao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension PecaQueryObject on QueryBuilder<Peca, Peca, QFilterCondition> {}

extension PecaQueryLinks on QueryBuilder<Peca, Peca, QFilterCondition> {}

extension PecaQuerySortBy on QueryBuilder<Peca, Peca, QSortBy> {
  QueryBuilder<Peca, Peca, QAfterSortBy> sortByCid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> sortByCidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.desc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> sortByTemperatura() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatura', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> sortByTemperaturaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatura', Sort.desc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> sortByVibracao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibracao', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> sortByVibracaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibracao', Sort.desc);
    });
  }
}

extension PecaQuerySortThenBy on QueryBuilder<Peca, Peca, QSortThenBy> {
  QueryBuilder<Peca, Peca, QAfterSortBy> thenByCid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByCidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.desc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByTemperatura() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatura', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByTemperaturaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatura', Sort.desc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByVibracao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibracao', Sort.asc);
    });
  }

  QueryBuilder<Peca, Peca, QAfterSortBy> thenByVibracaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibracao', Sort.desc);
    });
  }
}

extension PecaQueryWhereDistinct on QueryBuilder<Peca, Peca, QDistinct> {
  QueryBuilder<Peca, Peca, QDistinct> distinctByCid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peca, Peca, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peca, Peca, QDistinct> distinctByTemperatura() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperatura');
    });
  }

  QueryBuilder<Peca, Peca, QDistinct> distinctByVibracao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vibracao');
    });
  }
}

extension PecaQueryProperty on QueryBuilder<Peca, Peca, QQueryProperty> {
  QueryBuilder<Peca, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Peca, String, QQueryOperations> cidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cid');
    });
  }

  QueryBuilder<Peca, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<Peca, double?, QQueryOperations> temperaturaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperatura');
    });
  }

  QueryBuilder<Peca, double?, QQueryOperations> vibracaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vibracao');
    });
  }
}
