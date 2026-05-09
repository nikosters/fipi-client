// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examGroupMeta = const VerificationMeta(
    'examGroup',
  );
  @override
  late final GeneratedColumn<String> examGroup = GeneratedColumn<String>(
    'exam_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, examGroup, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('exam_group')) {
      context.handle(
        _examGroupMeta,
        examGroup.isAcceptableOrUnknown(data['exam_group']!, _examGroupMeta),
      );
    } else if (isInserting) {
      context.missing(_examGroupMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    } else if (isInserting) {
      context.missing(_enabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      examGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_group'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final String id;
  final String title;
  final String examGroup;
  final bool enabled;
  const Subject({
    required this.id,
    required this.title,
    required this.examGroup,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['exam_group'] = Variable<String>(examGroup);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      title: Value(title),
      examGroup: Value(examGroup),
      enabled: Value(enabled),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      examGroup: serializer.fromJson<String>(json['examGroup']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'examGroup': serializer.toJson<String>(examGroup),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  Subject copyWith({
    String? id,
    String? title,
    String? examGroup,
    bool? enabled,
  }) => Subject(
    id: id ?? this.id,
    title: title ?? this.title,
    examGroup: examGroup ?? this.examGroup,
    enabled: enabled ?? this.enabled,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      examGroup: data.examGroup.present ? data.examGroup.value : this.examGroup,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('examGroup: $examGroup, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, examGroup, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.title == this.title &&
          other.examGroup == this.examGroup &&
          other.enabled == this.enabled);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> examGroup;
  final Value<bool> enabled;
  final Value<int> rowid;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.examGroup = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectsCompanion.insert({
    required String id,
    required String title,
    required String examGroup,
    required bool enabled,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       examGroup = Value(examGroup),
       enabled = Value(enabled);
  static Insertable<Subject> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? examGroup,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (examGroup != null) 'exam_group': examGroup,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? examGroup,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      examGroup: examGroup ?? this.examGroup,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (examGroup.present) {
      map['exam_group'] = Variable<String>(examGroup.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('examGroup: $examGroup, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicNodesTable extends TopicNodes
    with TableInfo<$TopicNodesTable, TopicNodeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentCodeMeta = const VerificationMeta(
    'parentCode',
  );
  @override
  late final GeneratedColumn<String> parentCode = GeneratedColumn<String>(
    'parent_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    code,
    title,
    parentCode,
    depth,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topic_nodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicNodeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('parent_code')) {
      context.handle(
        _parentCodeMeta,
        parentCode.isAcceptableOrUnknown(data['parent_code']!, _parentCodeMeta),
      );
    }
    if (data.containsKey('depth')) {
      context.handle(
        _depthMeta,
        depth.isAcceptableOrUnknown(data['depth']!, _depthMeta),
      );
    } else if (isInserting) {
      context.missing(_depthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopicNodeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicNodeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      parentCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_code'],
      ),
      depth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
    );
  }

  @override
  $TopicNodesTable createAlias(String alias) {
    return $TopicNodesTable(attachedDatabase, alias);
  }
}

class TopicNodeRow extends DataClass implements Insertable<TopicNodeRow> {
  final String id;
  final String subjectId;
  final String code;
  final String title;
  final String? parentCode;
  final int depth;
  const TopicNodeRow({
    required this.id,
    required this.subjectId,
    required this.code,
    required this.title,
    this.parentCode,
    required this.depth,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject_id'] = Variable<String>(subjectId);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || parentCode != null) {
      map['parent_code'] = Variable<String>(parentCode);
    }
    map['depth'] = Variable<int>(depth);
    return map;
  }

  TopicNodesCompanion toCompanion(bool nullToAbsent) {
    return TopicNodesCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      code: Value(code),
      title: Value(title),
      parentCode: parentCode == null && nullToAbsent
          ? const Value.absent()
          : Value(parentCode),
      depth: Value(depth),
    );
  }

  factory TopicNodeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicNodeRow(
      id: serializer.fromJson<String>(json['id']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      parentCode: serializer.fromJson<String?>(json['parentCode']),
      depth: serializer.fromJson<int>(json['depth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subjectId': serializer.toJson<String>(subjectId),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'parentCode': serializer.toJson<String?>(parentCode),
      'depth': serializer.toJson<int>(depth),
    };
  }

  TopicNodeRow copyWith({
    String? id,
    String? subjectId,
    String? code,
    String? title,
    Value<String?> parentCode = const Value.absent(),
    int? depth,
  }) => TopicNodeRow(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    code: code ?? this.code,
    title: title ?? this.title,
    parentCode: parentCode.present ? parentCode.value : this.parentCode,
    depth: depth ?? this.depth,
  );
  TopicNodeRow copyWithCompanion(TopicNodesCompanion data) {
    return TopicNodeRow(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      parentCode: data.parentCode.present
          ? data.parentCode.value
          : this.parentCode,
      depth: data.depth.present ? data.depth.value : this.depth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicNodeRow(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('parentCode: $parentCode, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, subjectId, code, title, parentCode, depth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicNodeRow &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.code == this.code &&
          other.title == this.title &&
          other.parentCode == this.parentCode &&
          other.depth == this.depth);
}

class TopicNodesCompanion extends UpdateCompanion<TopicNodeRow> {
  final Value<String> id;
  final Value<String> subjectId;
  final Value<String> code;
  final Value<String> title;
  final Value<String?> parentCode;
  final Value<int> depth;
  final Value<int> rowid;
  const TopicNodesCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.parentCode = const Value.absent(),
    this.depth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicNodesCompanion.insert({
    required String id,
    required String subjectId,
    required String code,
    required String title,
    this.parentCode = const Value.absent(),
    required int depth,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subjectId = Value(subjectId),
       code = Value(code),
       title = Value(title),
       depth = Value(depth);
  static Insertable<TopicNodeRow> custom({
    Expression<String>? id,
    Expression<String>? subjectId,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? parentCode,
    Expression<int>? depth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (parentCode != null) 'parent_code': parentCode,
      if (depth != null) 'depth': depth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicNodesCompanion copyWith({
    Value<String>? id,
    Value<String>? subjectId,
    Value<String>? code,
    Value<String>? title,
    Value<String?>? parentCode,
    Value<int>? depth,
    Value<int>? rowid,
  }) {
    return TopicNodesCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      code: code ?? this.code,
      title: title ?? this.title,
      parentCode: parentCode ?? this.parentCode,
      depth: depth ?? this.depth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (parentCode.present) {
      map['parent_code'] = Variable<String>(parentCode.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicNodesCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('parentCode: $parentCode, ')
          ..write('depth: $depth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnswerKindCacheTable extends AnswerKindCache
    with TableInfo<$AnswerKindCacheTable, AnswerKindCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswerKindCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    code,
    title,
    kind,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answer_kind_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnswerKindCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnswerKindCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswerKindCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $AnswerKindCacheTable createAlias(String alias) {
    return $AnswerKindCacheTable(attachedDatabase, alias);
  }
}

class AnswerKindCacheData extends DataClass
    implements Insertable<AnswerKindCacheData> {
  final String id;
  final String subjectId;
  final String code;
  final String title;
  final String kind;
  final DateTime cachedAt;
  const AnswerKindCacheData({
    required this.id,
    required this.subjectId,
    required this.code,
    required this.title,
    required this.kind,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject_id'] = Variable<String>(subjectId);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['kind'] = Variable<String>(kind);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  AnswerKindCacheCompanion toCompanion(bool nullToAbsent) {
    return AnswerKindCacheCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      code: Value(code),
      title: Value(title),
      kind: Value(kind),
      cachedAt: Value(cachedAt),
    );
  }

  factory AnswerKindCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswerKindCacheData(
      id: serializer.fromJson<String>(json['id']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      kind: serializer.fromJson<String>(json['kind']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subjectId': serializer.toJson<String>(subjectId),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'kind': serializer.toJson<String>(kind),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  AnswerKindCacheData copyWith({
    String? id,
    String? subjectId,
    String? code,
    String? title,
    String? kind,
    DateTime? cachedAt,
  }) => AnswerKindCacheData(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    code: code ?? this.code,
    title: title ?? this.title,
    kind: kind ?? this.kind,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  AnswerKindCacheData copyWithCompanion(AnswerKindCacheCompanion data) {
    return AnswerKindCacheData(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      kind: data.kind.present ? data.kind.value : this.kind,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnswerKindCacheData(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subjectId, code, title, kind, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnswerKindCacheData &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.code == this.code &&
          other.title == this.title &&
          other.kind == this.kind &&
          other.cachedAt == this.cachedAt);
}

class AnswerKindCacheCompanion extends UpdateCompanion<AnswerKindCacheData> {
  final Value<String> id;
  final Value<String> subjectId;
  final Value<String> code;
  final Value<String> title;
  final Value<String> kind;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const AnswerKindCacheCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.kind = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnswerKindCacheCompanion.insert({
    required String id,
    required String subjectId,
    required String code,
    required String title,
    required String kind,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subjectId = Value(subjectId),
       code = Value(code),
       title = Value(title),
       kind = Value(kind),
       cachedAt = Value(cachedAt);
  static Insertable<AnswerKindCacheData> custom({
    Expression<String>? id,
    Expression<String>? subjectId,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? kind,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (kind != null) 'kind': kind,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnswerKindCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? subjectId,
    Value<String>? code,
    Value<String>? title,
    Value<String>? kind,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return AnswerKindCacheCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      code: code ?? this.code,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswerKindCacheCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionCacheTable extends QuestionCache
    with TableInfo<$QuestionCacheTable, QuestionCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filterHashMeta = const VerificationMeta(
    'filterHash',
  );
  @override
  late final GeneratedColumn<String> filterHash = GeneratedColumn<String>(
    'filter_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _guidMeta = const VerificationMeta('guid');
  @override
  late final GeneratedColumn<String> guid = GeneratedColumn<String>(
    'guid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortNumberMeta = const VerificationMeta(
    'shortNumber',
  );
  @override
  late final GeneratedColumn<String> shortNumber = GeneratedColumn<String>(
    'short_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerKindMeta = const VerificationMeta(
    'answerKind',
  );
  @override
  late final GeneratedColumn<String> answerKind = GeneratedColumn<String>(
    'answer_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicCodesJsonMeta = const VerificationMeta(
    'topicCodesJson',
  );
  @override
  late final GeneratedColumn<String> topicCodesJson = GeneratedColumn<String>(
    'topic_codes_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalHtmlMeta = const VerificationMeta(
    'originalHtml',
  );
  @override
  late final GeneratedColumn<String> originalHtml = GeneratedColumn<String>(
    'original_html',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    filterHash,
    page,
    guid,
    shortNumber,
    answerKind,
    topicCodesJson,
    originalHtml,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuestionCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('filter_hash')) {
      context.handle(
        _filterHashMeta,
        filterHash.isAcceptableOrUnknown(data['filter_hash']!, _filterHashMeta),
      );
    } else if (isInserting) {
      context.missing(_filterHashMeta);
    }
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    if (data.containsKey('guid')) {
      context.handle(
        _guidMeta,
        guid.isAcceptableOrUnknown(data['guid']!, _guidMeta),
      );
    } else if (isInserting) {
      context.missing(_guidMeta);
    }
    if (data.containsKey('short_number')) {
      context.handle(
        _shortNumberMeta,
        shortNumber.isAcceptableOrUnknown(
          data['short_number']!,
          _shortNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shortNumberMeta);
    }
    if (data.containsKey('answer_kind')) {
      context.handle(
        _answerKindMeta,
        answerKind.isAcceptableOrUnknown(data['answer_kind']!, _answerKindMeta),
      );
    } else if (isInserting) {
      context.missing(_answerKindMeta);
    }
    if (data.containsKey('topic_codes_json')) {
      context.handle(
        _topicCodesJsonMeta,
        topicCodesJson.isAcceptableOrUnknown(
          data['topic_codes_json']!,
          _topicCodesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_topicCodesJsonMeta);
    }
    if (data.containsKey('original_html')) {
      context.handle(
        _originalHtmlMeta,
        originalHtml.isAcceptableOrUnknown(
          data['original_html']!,
          _originalHtmlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalHtmlMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      filterHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}filter_hash'],
      )!,
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      )!,
      guid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guid'],
      )!,
      shortNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_number'],
      )!,
      answerKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_kind'],
      )!,
      topicCodesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_codes_json'],
      )!,
      originalHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_html'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $QuestionCacheTable createAlias(String alias) {
    return $QuestionCacheTable(attachedDatabase, alias);
  }
}

class QuestionCacheData extends DataClass
    implements Insertable<QuestionCacheData> {
  final String id;
  final String subjectId;
  final String filterHash;
  final int page;
  final String guid;
  final String shortNumber;
  final String answerKind;
  final String topicCodesJson;
  final String originalHtml;
  final DateTime cachedAt;
  const QuestionCacheData({
    required this.id,
    required this.subjectId,
    required this.filterHash,
    required this.page,
    required this.guid,
    required this.shortNumber,
    required this.answerKind,
    required this.topicCodesJson,
    required this.originalHtml,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject_id'] = Variable<String>(subjectId);
    map['filter_hash'] = Variable<String>(filterHash);
    map['page'] = Variable<int>(page);
    map['guid'] = Variable<String>(guid);
    map['short_number'] = Variable<String>(shortNumber);
    map['answer_kind'] = Variable<String>(answerKind);
    map['topic_codes_json'] = Variable<String>(topicCodesJson);
    map['original_html'] = Variable<String>(originalHtml);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  QuestionCacheCompanion toCompanion(bool nullToAbsent) {
    return QuestionCacheCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      filterHash: Value(filterHash),
      page: Value(page),
      guid: Value(guid),
      shortNumber: Value(shortNumber),
      answerKind: Value(answerKind),
      topicCodesJson: Value(topicCodesJson),
      originalHtml: Value(originalHtml),
      cachedAt: Value(cachedAt),
    );
  }

  factory QuestionCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionCacheData(
      id: serializer.fromJson<String>(json['id']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      filterHash: serializer.fromJson<String>(json['filterHash']),
      page: serializer.fromJson<int>(json['page']),
      guid: serializer.fromJson<String>(json['guid']),
      shortNumber: serializer.fromJson<String>(json['shortNumber']),
      answerKind: serializer.fromJson<String>(json['answerKind']),
      topicCodesJson: serializer.fromJson<String>(json['topicCodesJson']),
      originalHtml: serializer.fromJson<String>(json['originalHtml']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subjectId': serializer.toJson<String>(subjectId),
      'filterHash': serializer.toJson<String>(filterHash),
      'page': serializer.toJson<int>(page),
      'guid': serializer.toJson<String>(guid),
      'shortNumber': serializer.toJson<String>(shortNumber),
      'answerKind': serializer.toJson<String>(answerKind),
      'topicCodesJson': serializer.toJson<String>(topicCodesJson),
      'originalHtml': serializer.toJson<String>(originalHtml),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  QuestionCacheData copyWith({
    String? id,
    String? subjectId,
    String? filterHash,
    int? page,
    String? guid,
    String? shortNumber,
    String? answerKind,
    String? topicCodesJson,
    String? originalHtml,
    DateTime? cachedAt,
  }) => QuestionCacheData(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    filterHash: filterHash ?? this.filterHash,
    page: page ?? this.page,
    guid: guid ?? this.guid,
    shortNumber: shortNumber ?? this.shortNumber,
    answerKind: answerKind ?? this.answerKind,
    topicCodesJson: topicCodesJson ?? this.topicCodesJson,
    originalHtml: originalHtml ?? this.originalHtml,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  QuestionCacheData copyWithCompanion(QuestionCacheCompanion data) {
    return QuestionCacheData(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      filterHash: data.filterHash.present
          ? data.filterHash.value
          : this.filterHash,
      page: data.page.present ? data.page.value : this.page,
      guid: data.guid.present ? data.guid.value : this.guid,
      shortNumber: data.shortNumber.present
          ? data.shortNumber.value
          : this.shortNumber,
      answerKind: data.answerKind.present
          ? data.answerKind.value
          : this.answerKind,
      topicCodesJson: data.topicCodesJson.present
          ? data.topicCodesJson.value
          : this.topicCodesJson,
      originalHtml: data.originalHtml.present
          ? data.originalHtml.value
          : this.originalHtml,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionCacheData(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('filterHash: $filterHash, ')
          ..write('page: $page, ')
          ..write('guid: $guid, ')
          ..write('shortNumber: $shortNumber, ')
          ..write('answerKind: $answerKind, ')
          ..write('topicCodesJson: $topicCodesJson, ')
          ..write('originalHtml: $originalHtml, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subjectId,
    filterHash,
    page,
    guid,
    shortNumber,
    answerKind,
    topicCodesJson,
    originalHtml,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionCacheData &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.filterHash == this.filterHash &&
          other.page == this.page &&
          other.guid == this.guid &&
          other.shortNumber == this.shortNumber &&
          other.answerKind == this.answerKind &&
          other.topicCodesJson == this.topicCodesJson &&
          other.originalHtml == this.originalHtml &&
          other.cachedAt == this.cachedAt);
}

class QuestionCacheCompanion extends UpdateCompanion<QuestionCacheData> {
  final Value<String> id;
  final Value<String> subjectId;
  final Value<String> filterHash;
  final Value<int> page;
  final Value<String> guid;
  final Value<String> shortNumber;
  final Value<String> answerKind;
  final Value<String> topicCodesJson;
  final Value<String> originalHtml;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const QuestionCacheCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.filterHash = const Value.absent(),
    this.page = const Value.absent(),
    this.guid = const Value.absent(),
    this.shortNumber = const Value.absent(),
    this.answerKind = const Value.absent(),
    this.topicCodesJson = const Value.absent(),
    this.originalHtml = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionCacheCompanion.insert({
    required String id,
    required String subjectId,
    required String filterHash,
    required int page,
    required String guid,
    required String shortNumber,
    required String answerKind,
    required String topicCodesJson,
    required String originalHtml,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subjectId = Value(subjectId),
       filterHash = Value(filterHash),
       page = Value(page),
       guid = Value(guid),
       shortNumber = Value(shortNumber),
       answerKind = Value(answerKind),
       topicCodesJson = Value(topicCodesJson),
       originalHtml = Value(originalHtml),
       cachedAt = Value(cachedAt);
  static Insertable<QuestionCacheData> custom({
    Expression<String>? id,
    Expression<String>? subjectId,
    Expression<String>? filterHash,
    Expression<int>? page,
    Expression<String>? guid,
    Expression<String>? shortNumber,
    Expression<String>? answerKind,
    Expression<String>? topicCodesJson,
    Expression<String>? originalHtml,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (filterHash != null) 'filter_hash': filterHash,
      if (page != null) 'page': page,
      if (guid != null) 'guid': guid,
      if (shortNumber != null) 'short_number': shortNumber,
      if (answerKind != null) 'answer_kind': answerKind,
      if (topicCodesJson != null) 'topic_codes_json': topicCodesJson,
      if (originalHtml != null) 'original_html': originalHtml,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? subjectId,
    Value<String>? filterHash,
    Value<int>? page,
    Value<String>? guid,
    Value<String>? shortNumber,
    Value<String>? answerKind,
    Value<String>? topicCodesJson,
    Value<String>? originalHtml,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return QuestionCacheCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      filterHash: filterHash ?? this.filterHash,
      page: page ?? this.page,
      guid: guid ?? this.guid,
      shortNumber: shortNumber ?? this.shortNumber,
      answerKind: answerKind ?? this.answerKind,
      topicCodesJson: topicCodesJson ?? this.topicCodesJson,
      originalHtml: originalHtml ?? this.originalHtml,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (filterHash.present) {
      map['filter_hash'] = Variable<String>(filterHash.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (guid.present) {
      map['guid'] = Variable<String>(guid.value);
    }
    if (shortNumber.present) {
      map['short_number'] = Variable<String>(shortNumber.value);
    }
    if (answerKind.present) {
      map['answer_kind'] = Variable<String>(answerKind.value);
    }
    if (topicCodesJson.present) {
      map['topic_codes_json'] = Variable<String>(topicCodesJson.value);
    }
    if (originalHtml.present) {
      map['original_html'] = Variable<String>(originalHtml.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionCacheCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('filterHash: $filterHash, ')
          ..write('page: $page, ')
          ..write('guid: $guid, ')
          ..write('shortNumber: $shortNumber, ')
          ..write('answerKind: $answerKind, ')
          ..write('topicCodesJson: $topicCodesJson, ')
          ..write('originalHtml: $originalHtml, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SolvedQuestionsTable extends SolvedQuestions
    with TableInfo<$SolvedQuestionsTable, SolvedQuestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SolvedQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _guidMeta = const VerificationMeta('guid');
  @override
  late final GeneratedColumn<String> guid = GeneratedColumn<String>(
    'guid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
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
  List<GeneratedColumn> get $columns => [guid, subjectId, status, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'solved_questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SolvedQuestion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('guid')) {
      context.handle(
        _guidMeta,
        guid.isAcceptableOrUnknown(data['guid']!, _guidMeta),
      );
    } else if (isInserting) {
      context.missing(_guidMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
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
  Set<GeneratedColumn> get $primaryKey => {guid};
  @override
  SolvedQuestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SolvedQuestion(
      guid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guid'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SolvedQuestionsTable createAlias(String alias) {
    return $SolvedQuestionsTable(attachedDatabase, alias);
  }
}

class SolvedQuestion extends DataClass implements Insertable<SolvedQuestion> {
  final String guid;
  final String subjectId;
  final String status;
  final DateTime updatedAt;
  const SolvedQuestion({
    required this.guid,
    required this.subjectId,
    required this.status,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['guid'] = Variable<String>(guid);
    map['subject_id'] = Variable<String>(subjectId);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SolvedQuestionsCompanion toCompanion(bool nullToAbsent) {
    return SolvedQuestionsCompanion(
      guid: Value(guid),
      subjectId: Value(subjectId),
      status: Value(status),
      updatedAt: Value(updatedAt),
    );
  }

  factory SolvedQuestion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SolvedQuestion(
      guid: serializer.fromJson<String>(json['guid']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'guid': serializer.toJson<String>(guid),
      'subjectId': serializer.toJson<String>(subjectId),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SolvedQuestion copyWith({
    String? guid,
    String? subjectId,
    String? status,
    DateTime? updatedAt,
  }) => SolvedQuestion(
    guid: guid ?? this.guid,
    subjectId: subjectId ?? this.subjectId,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SolvedQuestion copyWithCompanion(SolvedQuestionsCompanion data) {
    return SolvedQuestion(
      guid: data.guid.present ? data.guid.value : this.guid,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SolvedQuestion(')
          ..write('guid: $guid, ')
          ..write('subjectId: $subjectId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(guid, subjectId, status, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SolvedQuestion &&
          other.guid == this.guid &&
          other.subjectId == this.subjectId &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt);
}

class SolvedQuestionsCompanion extends UpdateCompanion<SolvedQuestion> {
  final Value<String> guid;
  final Value<String> subjectId;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SolvedQuestionsCompanion({
    this.guid = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SolvedQuestionsCompanion.insert({
    required String guid,
    required String subjectId,
    required String status,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : guid = Value(guid),
       subjectId = Value(subjectId),
       status = Value(status),
       updatedAt = Value(updatedAt);
  static Insertable<SolvedQuestion> custom({
    Expression<String>? guid,
    Expression<String>? subjectId,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (guid != null) 'guid': guid,
      if (subjectId != null) 'subject_id': subjectId,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SolvedQuestionsCompanion copyWith({
    Value<String>? guid,
    Value<String>? subjectId,
    Value<String>? status,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SolvedQuestionsCompanion(
      guid: guid ?? this.guid,
      subjectId: subjectId ?? this.subjectId,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (guid.present) {
      map['guid'] = Variable<String>(guid.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
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
    return (StringBuffer('SolvedQuestionsCompanion(')
          ..write('guid: $guid, ')
          ..write('subjectId: $subjectId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SelectionStateTable extends SelectionState
    with TableInfo<$SelectionStateTable, SelectionStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SelectionStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicCodesJsonMeta = const VerificationMeta(
    'topicCodesJson',
  );
  @override
  late final GeneratedColumn<String> topicCodesJson = GeneratedColumn<String>(
    'topic_codes_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerKindsJsonMeta = const VerificationMeta(
    'answerKindsJson',
  );
  @override
  late final GeneratedColumn<String> answerKindsJson = GeneratedColumn<String>(
    'answer_kinds_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _showSolvedMeta = const VerificationMeta(
    'showSolved',
  );
  @override
  late final GeneratedColumn<bool> showSolved = GeneratedColumn<bool>(
    'show_solved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_solved" IN (0, 1))',
    ),
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
    subjectId,
    topicCodesJson,
    answerKindsJson,
    showSolved,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'selection_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<SelectionStateData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('topic_codes_json')) {
      context.handle(
        _topicCodesJsonMeta,
        topicCodesJson.isAcceptableOrUnknown(
          data['topic_codes_json']!,
          _topicCodesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_topicCodesJsonMeta);
    }
    if (data.containsKey('answer_kinds_json')) {
      context.handle(
        _answerKindsJsonMeta,
        answerKindsJson.isAcceptableOrUnknown(
          data['answer_kinds_json']!,
          _answerKindsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answerKindsJsonMeta);
    }
    if (data.containsKey('show_solved')) {
      context.handle(
        _showSolvedMeta,
        showSolved.isAcceptableOrUnknown(data['show_solved']!, _showSolvedMeta),
      );
    } else if (isInserting) {
      context.missing(_showSolvedMeta);
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
  Set<GeneratedColumn> get $primaryKey => {subjectId};
  @override
  SelectionStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SelectionStateData(
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_id'],
      )!,
      topicCodesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_codes_json'],
      )!,
      answerKindsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_kinds_json'],
      )!,
      showSolved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_solved'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SelectionStateTable createAlias(String alias) {
    return $SelectionStateTable(attachedDatabase, alias);
  }
}

class SelectionStateData extends DataClass
    implements Insertable<SelectionStateData> {
  final String subjectId;
  final String topicCodesJson;
  final String answerKindsJson;
  final bool showSolved;
  final DateTime updatedAt;
  const SelectionStateData({
    required this.subjectId,
    required this.topicCodesJson,
    required this.answerKindsJson,
    required this.showSolved,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['subject_id'] = Variable<String>(subjectId);
    map['topic_codes_json'] = Variable<String>(topicCodesJson);
    map['answer_kinds_json'] = Variable<String>(answerKindsJson);
    map['show_solved'] = Variable<bool>(showSolved);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SelectionStateCompanion toCompanion(bool nullToAbsent) {
    return SelectionStateCompanion(
      subjectId: Value(subjectId),
      topicCodesJson: Value(topicCodesJson),
      answerKindsJson: Value(answerKindsJson),
      showSolved: Value(showSolved),
      updatedAt: Value(updatedAt),
    );
  }

  factory SelectionStateData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SelectionStateData(
      subjectId: serializer.fromJson<String>(json['subjectId']),
      topicCodesJson: serializer.fromJson<String>(json['topicCodesJson']),
      answerKindsJson: serializer.fromJson<String>(json['answerKindsJson']),
      showSolved: serializer.fromJson<bool>(json['showSolved']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'subjectId': serializer.toJson<String>(subjectId),
      'topicCodesJson': serializer.toJson<String>(topicCodesJson),
      'answerKindsJson': serializer.toJson<String>(answerKindsJson),
      'showSolved': serializer.toJson<bool>(showSolved),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SelectionStateData copyWith({
    String? subjectId,
    String? topicCodesJson,
    String? answerKindsJson,
    bool? showSolved,
    DateTime? updatedAt,
  }) => SelectionStateData(
    subjectId: subjectId ?? this.subjectId,
    topicCodesJson: topicCodesJson ?? this.topicCodesJson,
    answerKindsJson: answerKindsJson ?? this.answerKindsJson,
    showSolved: showSolved ?? this.showSolved,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SelectionStateData copyWithCompanion(SelectionStateCompanion data) {
    return SelectionStateData(
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      topicCodesJson: data.topicCodesJson.present
          ? data.topicCodesJson.value
          : this.topicCodesJson,
      answerKindsJson: data.answerKindsJson.present
          ? data.answerKindsJson.value
          : this.answerKindsJson,
      showSolved: data.showSolved.present
          ? data.showSolved.value
          : this.showSolved,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SelectionStateData(')
          ..write('subjectId: $subjectId, ')
          ..write('topicCodesJson: $topicCodesJson, ')
          ..write('answerKindsJson: $answerKindsJson, ')
          ..write('showSolved: $showSolved, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    subjectId,
    topicCodesJson,
    answerKindsJson,
    showSolved,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SelectionStateData &&
          other.subjectId == this.subjectId &&
          other.topicCodesJson == this.topicCodesJson &&
          other.answerKindsJson == this.answerKindsJson &&
          other.showSolved == this.showSolved &&
          other.updatedAt == this.updatedAt);
}

class SelectionStateCompanion extends UpdateCompanion<SelectionStateData> {
  final Value<String> subjectId;
  final Value<String> topicCodesJson;
  final Value<String> answerKindsJson;
  final Value<bool> showSolved;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SelectionStateCompanion({
    this.subjectId = const Value.absent(),
    this.topicCodesJson = const Value.absent(),
    this.answerKindsJson = const Value.absent(),
    this.showSolved = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SelectionStateCompanion.insert({
    required String subjectId,
    required String topicCodesJson,
    required String answerKindsJson,
    required bool showSolved,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : subjectId = Value(subjectId),
       topicCodesJson = Value(topicCodesJson),
       answerKindsJson = Value(answerKindsJson),
       showSolved = Value(showSolved),
       updatedAt = Value(updatedAt);
  static Insertable<SelectionStateData> custom({
    Expression<String>? subjectId,
    Expression<String>? topicCodesJson,
    Expression<String>? answerKindsJson,
    Expression<bool>? showSolved,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (subjectId != null) 'subject_id': subjectId,
      if (topicCodesJson != null) 'topic_codes_json': topicCodesJson,
      if (answerKindsJson != null) 'answer_kinds_json': answerKindsJson,
      if (showSolved != null) 'show_solved': showSolved,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SelectionStateCompanion copyWith({
    Value<String>? subjectId,
    Value<String>? topicCodesJson,
    Value<String>? answerKindsJson,
    Value<bool>? showSolved,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SelectionStateCompanion(
      subjectId: subjectId ?? this.subjectId,
      topicCodesJson: topicCodesJson ?? this.topicCodesJson,
      answerKindsJson: answerKindsJson ?? this.answerKindsJson,
      showSolved: showSolved ?? this.showSolved,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (topicCodesJson.present) {
      map['topic_codes_json'] = Variable<String>(topicCodesJson.value);
    }
    if (answerKindsJson.present) {
      map['answer_kinds_json'] = Variable<String>(answerKindsJson.value);
    }
    if (showSolved.present) {
      map['show_solved'] = Variable<bool>(showSolved.value);
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
    return (StringBuffer('SelectionStateCompanion(')
          ..write('subjectId: $subjectId, ')
          ..write('topicCodesJson: $topicCodesJson, ')
          ..write('answerKindsJson: $answerKindsJson, ')
          ..write('showSolved: $showSolved, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $TopicNodesTable topicNodes = $TopicNodesTable(this);
  late final $AnswerKindCacheTable answerKindCache = $AnswerKindCacheTable(
    this,
  );
  late final $QuestionCacheTable questionCache = $QuestionCacheTable(this);
  late final $SolvedQuestionsTable solvedQuestions = $SolvedQuestionsTable(
    this,
  );
  late final $SelectionStateTable selectionState = $SelectionStateTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    subjects,
    topicNodes,
    answerKindCache,
    questionCache,
    solvedQuestions,
    selectionState,
  ];
}

typedef $$SubjectsTableCreateCompanionBuilder =
    SubjectsCompanion Function({
      required String id,
      required String title,
      required String examGroup,
      required bool enabled,
      Value<int> rowid,
    });
typedef $$SubjectsTableUpdateCompanionBuilder =
    SubjectsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> examGroup,
      Value<bool> enabled,
      Value<int> rowid,
    });

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examGroup => $composableBuilder(
    column: $table.examGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examGroup => $composableBuilder(
    column: $table.examGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get examGroup =>
      $composableBuilder(column: $table.examGroup, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, BaseReferences<_$AppDatabase, $SubjectsTable, Subject>),
          Subject,
          PrefetchHooks Function()
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> examGroup = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                title: title,
                examGroup: examGroup,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String examGroup,
                required bool enabled,
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion.insert(
                id: id,
                title: title,
                examGroup: examGroup,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, BaseReferences<_$AppDatabase, $SubjectsTable, Subject>),
      Subject,
      PrefetchHooks Function()
    >;
typedef $$TopicNodesTableCreateCompanionBuilder =
    TopicNodesCompanion Function({
      required String id,
      required String subjectId,
      required String code,
      required String title,
      Value<String?> parentCode,
      required int depth,
      Value<int> rowid,
    });
typedef $$TopicNodesTableUpdateCompanionBuilder =
    TopicNodesCompanion Function({
      Value<String> id,
      Value<String> subjectId,
      Value<String> code,
      Value<String> title,
      Value<String?> parentCode,
      Value<int> depth,
      Value<int> rowid,
    });

class $$TopicNodesTableFilterComposer
    extends Composer<_$AppDatabase, $TopicNodesTable> {
  $$TopicNodesTableFilterComposer({
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

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentCode => $composableBuilder(
    column: $table.parentCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TopicNodesTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicNodesTable> {
  $$TopicNodesTableOrderingComposer({
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

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentCode => $composableBuilder(
    column: $table.parentCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TopicNodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicNodesTable> {
  $$TopicNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get parentCode => $composableBuilder(
    column: $table.parentCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);
}

class $$TopicNodesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicNodesTable,
          TopicNodeRow,
          $$TopicNodesTableFilterComposer,
          $$TopicNodesTableOrderingComposer,
          $$TopicNodesTableAnnotationComposer,
          $$TopicNodesTableCreateCompanionBuilder,
          $$TopicNodesTableUpdateCompanionBuilder,
          (
            TopicNodeRow,
            BaseReferences<_$AppDatabase, $TopicNodesTable, TopicNodeRow>,
          ),
          TopicNodeRow,
          PrefetchHooks Function()
        > {
  $$TopicNodesTableTableManager(_$AppDatabase db, $TopicNodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicNodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> parentCode = const Value.absent(),
                Value<int> depth = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicNodesCompanion(
                id: id,
                subjectId: subjectId,
                code: code,
                title: title,
                parentCode: parentCode,
                depth: depth,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subjectId,
                required String code,
                required String title,
                Value<String?> parentCode = const Value.absent(),
                required int depth,
                Value<int> rowid = const Value.absent(),
              }) => TopicNodesCompanion.insert(
                id: id,
                subjectId: subjectId,
                code: code,
                title: title,
                parentCode: parentCode,
                depth: depth,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TopicNodesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicNodesTable,
      TopicNodeRow,
      $$TopicNodesTableFilterComposer,
      $$TopicNodesTableOrderingComposer,
      $$TopicNodesTableAnnotationComposer,
      $$TopicNodesTableCreateCompanionBuilder,
      $$TopicNodesTableUpdateCompanionBuilder,
      (
        TopicNodeRow,
        BaseReferences<_$AppDatabase, $TopicNodesTable, TopicNodeRow>,
      ),
      TopicNodeRow,
      PrefetchHooks Function()
    >;
typedef $$AnswerKindCacheTableCreateCompanionBuilder =
    AnswerKindCacheCompanion Function({
      required String id,
      required String subjectId,
      required String code,
      required String title,
      required String kind,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$AnswerKindCacheTableUpdateCompanionBuilder =
    AnswerKindCacheCompanion Function({
      Value<String> id,
      Value<String> subjectId,
      Value<String> code,
      Value<String> title,
      Value<String> kind,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$AnswerKindCacheTableFilterComposer
    extends Composer<_$AppDatabase, $AnswerKindCacheTable> {
  $$AnswerKindCacheTableFilterComposer({
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

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnswerKindCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $AnswerKindCacheTable> {
  $$AnswerKindCacheTableOrderingComposer({
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

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnswerKindCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnswerKindCacheTable> {
  $$AnswerKindCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$AnswerKindCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnswerKindCacheTable,
          AnswerKindCacheData,
          $$AnswerKindCacheTableFilterComposer,
          $$AnswerKindCacheTableOrderingComposer,
          $$AnswerKindCacheTableAnnotationComposer,
          $$AnswerKindCacheTableCreateCompanionBuilder,
          $$AnswerKindCacheTableUpdateCompanionBuilder,
          (
            AnswerKindCacheData,
            BaseReferences<
              _$AppDatabase,
              $AnswerKindCacheTable,
              AnswerKindCacheData
            >,
          ),
          AnswerKindCacheData,
          PrefetchHooks Function()
        > {
  $$AnswerKindCacheTableTableManager(
    _$AppDatabase db,
    $AnswerKindCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnswerKindCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnswerKindCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnswerKindCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnswerKindCacheCompanion(
                id: id,
                subjectId: subjectId,
                code: code,
                title: title,
                kind: kind,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subjectId,
                required String code,
                required String title,
                required String kind,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => AnswerKindCacheCompanion.insert(
                id: id,
                subjectId: subjectId,
                code: code,
                title: title,
                kind: kind,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnswerKindCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnswerKindCacheTable,
      AnswerKindCacheData,
      $$AnswerKindCacheTableFilterComposer,
      $$AnswerKindCacheTableOrderingComposer,
      $$AnswerKindCacheTableAnnotationComposer,
      $$AnswerKindCacheTableCreateCompanionBuilder,
      $$AnswerKindCacheTableUpdateCompanionBuilder,
      (
        AnswerKindCacheData,
        BaseReferences<
          _$AppDatabase,
          $AnswerKindCacheTable,
          AnswerKindCacheData
        >,
      ),
      AnswerKindCacheData,
      PrefetchHooks Function()
    >;
typedef $$QuestionCacheTableCreateCompanionBuilder =
    QuestionCacheCompanion Function({
      required String id,
      required String subjectId,
      required String filterHash,
      required int page,
      required String guid,
      required String shortNumber,
      required String answerKind,
      required String topicCodesJson,
      required String originalHtml,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$QuestionCacheTableUpdateCompanionBuilder =
    QuestionCacheCompanion Function({
      Value<String> id,
      Value<String> subjectId,
      Value<String> filterHash,
      Value<int> page,
      Value<String> guid,
      Value<String> shortNumber,
      Value<String> answerKind,
      Value<String> topicCodesJson,
      Value<String> originalHtml,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$QuestionCacheTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionCacheTable> {
  $$QuestionCacheTableFilterComposer({
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

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filterHash => $composableBuilder(
    column: $table.filterHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guid => $composableBuilder(
    column: $table.guid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortNumber => $composableBuilder(
    column: $table.shortNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerKind => $composableBuilder(
    column: $table.answerKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicCodesJson => $composableBuilder(
    column: $table.topicCodesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalHtml => $composableBuilder(
    column: $table.originalHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuestionCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionCacheTable> {
  $$QuestionCacheTableOrderingComposer({
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

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filterHash => $composableBuilder(
    column: $table.filterHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guid => $composableBuilder(
    column: $table.guid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortNumber => $composableBuilder(
    column: $table.shortNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerKind => $composableBuilder(
    column: $table.answerKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicCodesJson => $composableBuilder(
    column: $table.topicCodesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalHtml => $composableBuilder(
    column: $table.originalHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionCacheTable> {
  $$QuestionCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get filterHash => $composableBuilder(
    column: $table.filterHash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumn<String> get guid =>
      $composableBuilder(column: $table.guid, builder: (column) => column);

  GeneratedColumn<String> get shortNumber => $composableBuilder(
    column: $table.shortNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerKind => $composableBuilder(
    column: $table.answerKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get topicCodesJson => $composableBuilder(
    column: $table.topicCodesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalHtml => $composableBuilder(
    column: $table.originalHtml,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$QuestionCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionCacheTable,
          QuestionCacheData,
          $$QuestionCacheTableFilterComposer,
          $$QuestionCacheTableOrderingComposer,
          $$QuestionCacheTableAnnotationComposer,
          $$QuestionCacheTableCreateCompanionBuilder,
          $$QuestionCacheTableUpdateCompanionBuilder,
          (
            QuestionCacheData,
            BaseReferences<
              _$AppDatabase,
              $QuestionCacheTable,
              QuestionCacheData
            >,
          ),
          QuestionCacheData,
          PrefetchHooks Function()
        > {
  $$QuestionCacheTableTableManager(_$AppDatabase db, $QuestionCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> filterHash = const Value.absent(),
                Value<int> page = const Value.absent(),
                Value<String> guid = const Value.absent(),
                Value<String> shortNumber = const Value.absent(),
                Value<String> answerKind = const Value.absent(),
                Value<String> topicCodesJson = const Value.absent(),
                Value<String> originalHtml = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionCacheCompanion(
                id: id,
                subjectId: subjectId,
                filterHash: filterHash,
                page: page,
                guid: guid,
                shortNumber: shortNumber,
                answerKind: answerKind,
                topicCodesJson: topicCodesJson,
                originalHtml: originalHtml,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subjectId,
                required String filterHash,
                required int page,
                required String guid,
                required String shortNumber,
                required String answerKind,
                required String topicCodesJson,
                required String originalHtml,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => QuestionCacheCompanion.insert(
                id: id,
                subjectId: subjectId,
                filterHash: filterHash,
                page: page,
                guid: guid,
                shortNumber: shortNumber,
                answerKind: answerKind,
                topicCodesJson: topicCodesJson,
                originalHtml: originalHtml,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuestionCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionCacheTable,
      QuestionCacheData,
      $$QuestionCacheTableFilterComposer,
      $$QuestionCacheTableOrderingComposer,
      $$QuestionCacheTableAnnotationComposer,
      $$QuestionCacheTableCreateCompanionBuilder,
      $$QuestionCacheTableUpdateCompanionBuilder,
      (
        QuestionCacheData,
        BaseReferences<_$AppDatabase, $QuestionCacheTable, QuestionCacheData>,
      ),
      QuestionCacheData,
      PrefetchHooks Function()
    >;
typedef $$SolvedQuestionsTableCreateCompanionBuilder =
    SolvedQuestionsCompanion Function({
      required String guid,
      required String subjectId,
      required String status,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SolvedQuestionsTableUpdateCompanionBuilder =
    SolvedQuestionsCompanion Function({
      Value<String> guid,
      Value<String> subjectId,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SolvedQuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $SolvedQuestionsTable> {
  $$SolvedQuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get guid => $composableBuilder(
    column: $table.guid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SolvedQuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SolvedQuestionsTable> {
  $$SolvedQuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get guid => $composableBuilder(
    column: $table.guid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SolvedQuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SolvedQuestionsTable> {
  $$SolvedQuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get guid =>
      $composableBuilder(column: $table.guid, builder: (column) => column);

  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SolvedQuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SolvedQuestionsTable,
          SolvedQuestion,
          $$SolvedQuestionsTableFilterComposer,
          $$SolvedQuestionsTableOrderingComposer,
          $$SolvedQuestionsTableAnnotationComposer,
          $$SolvedQuestionsTableCreateCompanionBuilder,
          $$SolvedQuestionsTableUpdateCompanionBuilder,
          (
            SolvedQuestion,
            BaseReferences<
              _$AppDatabase,
              $SolvedQuestionsTable,
              SolvedQuestion
            >,
          ),
          SolvedQuestion,
          PrefetchHooks Function()
        > {
  $$SolvedQuestionsTableTableManager(
    _$AppDatabase db,
    $SolvedQuestionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SolvedQuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SolvedQuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SolvedQuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> guid = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SolvedQuestionsCompanion(
                guid: guid,
                subjectId: subjectId,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String guid,
                required String subjectId,
                required String status,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SolvedQuestionsCompanion.insert(
                guid: guid,
                subjectId: subjectId,
                status: status,
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

typedef $$SolvedQuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SolvedQuestionsTable,
      SolvedQuestion,
      $$SolvedQuestionsTableFilterComposer,
      $$SolvedQuestionsTableOrderingComposer,
      $$SolvedQuestionsTableAnnotationComposer,
      $$SolvedQuestionsTableCreateCompanionBuilder,
      $$SolvedQuestionsTableUpdateCompanionBuilder,
      (
        SolvedQuestion,
        BaseReferences<_$AppDatabase, $SolvedQuestionsTable, SolvedQuestion>,
      ),
      SolvedQuestion,
      PrefetchHooks Function()
    >;
typedef $$SelectionStateTableCreateCompanionBuilder =
    SelectionStateCompanion Function({
      required String subjectId,
      required String topicCodesJson,
      required String answerKindsJson,
      required bool showSolved,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SelectionStateTableUpdateCompanionBuilder =
    SelectionStateCompanion Function({
      Value<String> subjectId,
      Value<String> topicCodesJson,
      Value<String> answerKindsJson,
      Value<bool> showSolved,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SelectionStateTableFilterComposer
    extends Composer<_$AppDatabase, $SelectionStateTable> {
  $$SelectionStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicCodesJson => $composableBuilder(
    column: $table.topicCodesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerKindsJson => $composableBuilder(
    column: $table.answerKindsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showSolved => $composableBuilder(
    column: $table.showSolved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SelectionStateTableOrderingComposer
    extends Composer<_$AppDatabase, $SelectionStateTable> {
  $$SelectionStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get subjectId => $composableBuilder(
    column: $table.subjectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicCodesJson => $composableBuilder(
    column: $table.topicCodesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerKindsJson => $composableBuilder(
    column: $table.answerKindsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showSolved => $composableBuilder(
    column: $table.showSolved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SelectionStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $SelectionStateTable> {
  $$SelectionStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get subjectId =>
      $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get topicCodesJson => $composableBuilder(
    column: $table.topicCodesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerKindsJson => $composableBuilder(
    column: $table.answerKindsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showSolved => $composableBuilder(
    column: $table.showSolved,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SelectionStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SelectionStateTable,
          SelectionStateData,
          $$SelectionStateTableFilterComposer,
          $$SelectionStateTableOrderingComposer,
          $$SelectionStateTableAnnotationComposer,
          $$SelectionStateTableCreateCompanionBuilder,
          $$SelectionStateTableUpdateCompanionBuilder,
          (
            SelectionStateData,
            BaseReferences<
              _$AppDatabase,
              $SelectionStateTable,
              SelectionStateData
            >,
          ),
          SelectionStateData,
          PrefetchHooks Function()
        > {
  $$SelectionStateTableTableManager(
    _$AppDatabase db,
    $SelectionStateTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SelectionStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SelectionStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SelectionStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> subjectId = const Value.absent(),
                Value<String> topicCodesJson = const Value.absent(),
                Value<String> answerKindsJson = const Value.absent(),
                Value<bool> showSolved = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SelectionStateCompanion(
                subjectId: subjectId,
                topicCodesJson: topicCodesJson,
                answerKindsJson: answerKindsJson,
                showSolved: showSolved,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String subjectId,
                required String topicCodesJson,
                required String answerKindsJson,
                required bool showSolved,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SelectionStateCompanion.insert(
                subjectId: subjectId,
                topicCodesJson: topicCodesJson,
                answerKindsJson: answerKindsJson,
                showSolved: showSolved,
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

typedef $$SelectionStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SelectionStateTable,
      SelectionStateData,
      $$SelectionStateTableFilterComposer,
      $$SelectionStateTableOrderingComposer,
      $$SelectionStateTableAnnotationComposer,
      $$SelectionStateTableCreateCompanionBuilder,
      $$SelectionStateTableUpdateCompanionBuilder,
      (
        SelectionStateData,
        BaseReferences<_$AppDatabase, $SelectionStateTable, SelectionStateData>,
      ),
      SelectionStateData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$TopicNodesTableTableManager get topicNodes =>
      $$TopicNodesTableTableManager(_db, _db.topicNodes);
  $$AnswerKindCacheTableTableManager get answerKindCache =>
      $$AnswerKindCacheTableTableManager(_db, _db.answerKindCache);
  $$QuestionCacheTableTableManager get questionCache =>
      $$QuestionCacheTableTableManager(_db, _db.questionCache);
  $$SolvedQuestionsTableTableManager get solvedQuestions =>
      $$SolvedQuestionsTableTableManager(_db, _db.solvedQuestions);
  $$SelectionStateTableTableManager get selectionState =>
      $$SelectionStateTableTableManager(_db, _db.selectionState);
}
