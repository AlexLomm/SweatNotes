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
  String get trainingBlockId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
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
      String trainingBlockId,
      String name,
      String unit,
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
    Object? trainingBlockId = null,
    Object? name = null,
    Object? unit = null,
    Object? exercises = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExerciseTypeCopyWith<$Res>
    implements $ExerciseTypeCopyWith<$Res> {
  factory _$$_ExerciseTypeCopyWith(
          _$_ExerciseType value, $Res Function(_$_ExerciseType) then) =
      __$$_ExerciseTypeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String trainingBlockId,
      String name,
      String unit,
      List<Exercise> exercises});
}

/// @nodoc
class __$$_ExerciseTypeCopyWithImpl<$Res>
    extends _$ExerciseTypeCopyWithImpl<$Res, _$_ExerciseType>
    implements _$$_ExerciseTypeCopyWith<$Res> {
  __$$_ExerciseTypeCopyWithImpl(
      _$_ExerciseType _value, $Res Function(_$_ExerciseType) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? trainingBlockId = null,
    Object? name = null,
    Object? unit = null,
    Object? exercises = null,
  }) {
    return _then(_$_ExerciseType(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExerciseType with DiagnosticableTreeMixin implements _ExerciseType {
  const _$_ExerciseType(
      {@JsonKey(includeToJson: false) required this.id,
      required this.trainingBlockId,
      required this.name,
      required this.unit,
      final List<Exercise> exercises = const []})
      : _exercises = exercises;

  factory _$_ExerciseType.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseTypeFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  final String trainingBlockId;
  @override
  final String name;
  @override
  final String unit;
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
    return 'ExerciseType(id: $id, trainingBlockId: $trainingBlockId, name: $name, unit: $unit, exercises: $exercises)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseType'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('trainingBlockId', trainingBlockId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('exercises', exercises));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseTypeCopyWith<_$_ExerciseType> get copyWith =>
      __$$_ExerciseTypeCopyWithImpl<_$_ExerciseType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseTypeToJson(
      this,
    );
  }
}

abstract class _ExerciseType implements ExerciseType {
  const factory _ExerciseType(
      {@JsonKey(includeToJson: false) required final String id,
      required final String trainingBlockId,
      required final String name,
      required final String unit,
      final List<Exercise> exercises}) = _$_ExerciseType;

  factory _ExerciseType.fromJson(Map<String, dynamic> json) =
      _$_ExerciseType.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  String get trainingBlockId;
  @override
  String get name;
  @override
  String get unit;
  @override
  List<Exercise> get exercises;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseTypeCopyWith<_$_ExerciseType> get copyWith =>
      throw _privateConstructorUsedError;
}
