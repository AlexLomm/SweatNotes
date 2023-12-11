// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExerciseType _$ExerciseTypeFromJson(Map<String, dynamic> json) {
  return _ExerciseType.fromJson(json);
}

/// @nodoc
mixin _$ExerciseType {
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
  Timestamp? get archivedAt => throw _privateConstructorUsedError;
  String get trainingBlockId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  List<Exercise> get exercises => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseTypeCopyWith<ExerciseType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseTypeCopyWith<$Res> {
  factory $ExerciseTypeCopyWith(
          ExerciseType value, $Res Function(ExerciseType) then) =
      _$ExerciseTypeCopyWithImpl<$Res, ExerciseType>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
      Timestamp? archivedAt,
      String trainingBlockId,
      String name,
      String unit,
      String notes,
      List<Exercise> exercises});
}

/// @nodoc
class _$ExerciseTypeCopyWithImpl<$Res, $Val extends ExerciseType>
    implements $ExerciseTypeCopyWith<$Res> {
  _$ExerciseTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? archivedAt = freezed,
    Object? trainingBlockId = null,
    Object? name = null,
    Object? unit = null,
    Object? notes = null,
    Object? exercises = null,
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
      trainingBlockId: null == trainingBlockId
          ? _value.trainingBlockId
          : trainingBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseTypeImplCopyWith<$Res>
    implements $ExerciseTypeCopyWith<$Res> {
  factory _$$ExerciseTypeImplCopyWith(
          _$ExerciseTypeImpl value, $Res Function(_$ExerciseTypeImpl) then) =
      __$$ExerciseTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
      Timestamp? archivedAt,
      String trainingBlockId,
      String name,
      String unit,
      String notes,
      List<Exercise> exercises});
}

/// @nodoc
class __$$ExerciseTypeImplCopyWithImpl<$Res>
    extends _$ExerciseTypeCopyWithImpl<$Res, _$ExerciseTypeImpl>
    implements _$$ExerciseTypeImplCopyWith<$Res> {
  __$$ExerciseTypeImplCopyWithImpl(
      _$ExerciseTypeImpl _value, $Res Function(_$ExerciseTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? archivedAt = freezed,
    Object? trainingBlockId = null,
    Object? name = null,
    Object? unit = null,
    Object? notes = null,
    Object? exercises = null,
  }) {
    return _then(_$ExerciseTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      trainingBlockId: null == trainingBlockId
          ? _value.trainingBlockId
          : trainingBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseTypeImpl with DiagnosticableTreeMixin implements _ExerciseType {
  const _$ExerciseTypeImpl(
      {@JsonKey(includeToJson: false) required this.id,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
      this.archivedAt,
      required this.trainingBlockId,
      required this.name,
      required this.unit,
      required this.notes,
      final List<Exercise> exercises = const []})
      : _exercises = exercises;

  factory _$ExerciseTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseTypeImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
  final Timestamp? archivedAt;
  @override
  final String trainingBlockId;
  @override
  final String name;
  @override
  final String unit;
  @override
  final String notes;
  final List<Exercise> _exercises;
  @override
  @JsonKey()
  List<Exercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseType(id: $id, archivedAt: $archivedAt, trainingBlockId: $trainingBlockId, name: $name, unit: $unit, notes: $notes, exercises: $exercises)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseType'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('archivedAt', archivedAt))
      ..add(DiagnosticsProperty('trainingBlockId', trainingBlockId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('exercises', exercises));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseTypeImplCopyWith<_$ExerciseTypeImpl> get copyWith =>
      __$$ExerciseTypeImplCopyWithImpl<_$ExerciseTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseTypeImplToJson(
      this,
    );
  }
}

abstract class _ExerciseType implements ExerciseType {
  const factory _ExerciseType(
      {@JsonKey(includeToJson: false) required final String id,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
      final Timestamp? archivedAt,
      required final String trainingBlockId,
      required final String name,
      required final String unit,
      required final String notes,
      final List<Exercise> exercises}) = _$ExerciseTypeImpl;

  factory _ExerciseType.fromJson(Map<String, dynamic> json) =
      _$ExerciseTypeImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
  Timestamp? get archivedAt;
  @override
  String get trainingBlockId;
  @override
  String get name;
  @override
  String get unit;
  @override
  String get notes;
  @override
  List<Exercise> get exercises;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseTypeImplCopyWith<_$ExerciseTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
