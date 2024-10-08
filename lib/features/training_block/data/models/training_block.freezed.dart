// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrainingBlock _$TrainingBlockFromJson(Map<String, dynamic> json) {
  return _TrainingBlock.fromJson(json);
}

/// @nodoc
mixin _$TrainingBlock {
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: timestampFromJson, toJson: timestampToJson, defaultValue: null)
  Timestamp? get archivedAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: timestampFromJson, toJson: timestampToJson, defaultValue: null)
  Timestamp? get startedAt => throw _privateConstructorUsedError;
  Map<String, int> get exerciseDaysOrdering =>
      throw _privateConstructorUsedError;
  int get exercisesCollapsedIncludingIndex =>
      throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ExerciseDay> get exerciseDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrainingBlockCopyWith<TrainingBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingBlockCopyWith<$Res> {
  factory $TrainingBlockCopyWith(
          TrainingBlock value, $Res Function(TrainingBlock) then) =
      _$TrainingBlockCopyWithImpl<$Res, TrainingBlock>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      Timestamp? archivedAt,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      Timestamp? startedAt,
      Map<String, int> exerciseDaysOrdering,
      int exercisesCollapsedIncludingIndex,
      String name,
      List<ExerciseDay> exerciseDays});
}

/// @nodoc
class _$TrainingBlockCopyWithImpl<$Res, $Val extends TrainingBlock>
    implements $TrainingBlockCopyWith<$Res> {
  _$TrainingBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? archivedAt = freezed,
    Object? startedAt = freezed,
    Object? exerciseDaysOrdering = null,
    Object? exercisesCollapsedIncludingIndex = null,
    Object? name = null,
    Object? exerciseDays = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      exerciseDaysOrdering: null == exerciseDaysOrdering
          ? _value.exerciseDaysOrdering
          : exerciseDaysOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      exercisesCollapsedIncludingIndex: null == exercisesCollapsedIncludingIndex
          ? _value.exercisesCollapsedIncludingIndex
          : exercisesCollapsedIncludingIndex // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDays: null == exerciseDays
          ? _value.exerciseDays
          : exerciseDays // ignore: cast_nullable_to_non_nullable
              as List<ExerciseDay>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainingBlockImplCopyWith<$Res>
    implements $TrainingBlockCopyWith<$Res> {
  factory _$$TrainingBlockImplCopyWith(
          _$TrainingBlockImpl value, $Res Function(_$TrainingBlockImpl) then) =
      __$$TrainingBlockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      Timestamp? archivedAt,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      Timestamp? startedAt,
      Map<String, int> exerciseDaysOrdering,
      int exercisesCollapsedIncludingIndex,
      String name,
      List<ExerciseDay> exerciseDays});
}

/// @nodoc
class __$$TrainingBlockImplCopyWithImpl<$Res>
    extends _$TrainingBlockCopyWithImpl<$Res, _$TrainingBlockImpl>
    implements _$$TrainingBlockImplCopyWith<$Res> {
  __$$TrainingBlockImplCopyWithImpl(
      _$TrainingBlockImpl _value, $Res Function(_$TrainingBlockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? archivedAt = freezed,
    Object? startedAt = freezed,
    Object? exerciseDaysOrdering = null,
    Object? exercisesCollapsedIncludingIndex = null,
    Object? name = null,
    Object? exerciseDays = null,
  }) {
    return _then(_$TrainingBlockImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      exerciseDaysOrdering: null == exerciseDaysOrdering
          ? _value._exerciseDaysOrdering
          : exerciseDaysOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      exercisesCollapsedIncludingIndex: null == exercisesCollapsedIncludingIndex
          ? _value.exercisesCollapsedIncludingIndex
          : exercisesCollapsedIncludingIndex // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDays: null == exerciseDays
          ? _value._exerciseDays
          : exerciseDays // ignore: cast_nullable_to_non_nullable
              as List<ExerciseDay>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingBlockImpl
    with DiagnosticableTreeMixin
    implements _TrainingBlock {
  const _$TrainingBlockImpl(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      this.archivedAt,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      this.startedAt,
      final Map<String, int> exerciseDaysOrdering = const {},
      this.exercisesCollapsedIncludingIndex = -1,
      required this.name,
      final List<ExerciseDay> exerciseDays = const []})
      : _exerciseDaysOrdering = exerciseDaysOrdering,
        _exerciseDays = exerciseDays;

  factory _$TrainingBlockImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingBlockImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  @JsonKey(
      fromJson: timestampFromJson, toJson: timestampToJson, defaultValue: null)
  final Timestamp? archivedAt;
  @override
  @JsonKey(
      fromJson: timestampFromJson, toJson: timestampToJson, defaultValue: null)
  final Timestamp? startedAt;
  final Map<String, int> _exerciseDaysOrdering;
  @override
  @JsonKey()
  Map<String, int> get exerciseDaysOrdering {
    if (_exerciseDaysOrdering is EqualUnmodifiableMapView)
      return _exerciseDaysOrdering;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exerciseDaysOrdering);
  }

  @override
  @JsonKey()
  final int exercisesCollapsedIncludingIndex;
  @override
  final String name;
  final List<ExerciseDay> _exerciseDays;
  @override
  @JsonKey()
  List<ExerciseDay> get exerciseDays {
    if (_exerciseDays is EqualUnmodifiableListView) return _exerciseDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseDays);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrainingBlock(id: $id, archivedAt: $archivedAt, startedAt: $startedAt, exerciseDaysOrdering: $exerciseDaysOrdering, exercisesCollapsedIncludingIndex: $exercisesCollapsedIncludingIndex, name: $name, exerciseDays: $exerciseDays)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrainingBlock'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('archivedAt', archivedAt))
      ..add(DiagnosticsProperty('startedAt', startedAt))
      ..add(DiagnosticsProperty('exerciseDaysOrdering', exerciseDaysOrdering))
      ..add(DiagnosticsProperty(
          'exercisesCollapsedIncludingIndex', exercisesCollapsedIncludingIndex))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseDays', exerciseDays));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingBlockImplCopyWith<_$TrainingBlockImpl> get copyWith =>
      __$$TrainingBlockImplCopyWithImpl<_$TrainingBlockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingBlockImplToJson(
      this,
    );
  }
}

abstract class _TrainingBlock implements TrainingBlock {
  const factory _TrainingBlock(
      {@JsonKey(includeToJson: false) required final String id,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      final Timestamp? archivedAt,
      @JsonKey(
          fromJson: timestampFromJson,
          toJson: timestampToJson,
          defaultValue: null)
      final Timestamp? startedAt,
      final Map<String, int> exerciseDaysOrdering,
      final int exercisesCollapsedIncludingIndex,
      required final String name,
      final List<ExerciseDay> exerciseDays}) = _$TrainingBlockImpl;

  factory _TrainingBlock.fromJson(Map<String, dynamic> json) =
      _$TrainingBlockImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  @JsonKey(
      fromJson: timestampFromJson, toJson: timestampToJson, defaultValue: null)
  Timestamp? get archivedAt;
  @override
  @JsonKey(
      fromJson: timestampFromJson, toJson: timestampToJson, defaultValue: null)
  Timestamp? get startedAt;
  @override
  Map<String, int> get exerciseDaysOrdering;
  @override
  int get exercisesCollapsedIncludingIndex;
  @override
  String get name;
  @override
  List<ExerciseDay> get exerciseDays;
  @override
  @JsonKey(ignore: true)
  _$$TrainingBlockImplCopyWith<_$TrainingBlockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
