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
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;

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
  $Res call({String id, String userId, String name, String unit});
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
    Object? userId = null,
    Object? name = null,
    Object? unit = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({String id, String userId, String name, String unit});
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
    Object? userId = null,
    Object? name = null,
    Object? unit = null,
  }) {
    return _then(_$_ExerciseType(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExerciseType with DiagnosticableTreeMixin implements _ExerciseType {
  const _$_ExerciseType(
      {required this.id,
      required this.userId,
      required this.name,
      required this.unit});

  factory _$_ExerciseType.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseTypeFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String unit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseType(id: $id, userId: $userId, name: $name, unit: $unit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseType'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('unit', unit));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExerciseType &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, unit);

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
      {required final String id,
      required final String userId,
      required final String name,
      required final String unit}) = _$_ExerciseType;

  factory _ExerciseType.fromJson(Map<String, dynamic> json) =
      _$_ExerciseType.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String get unit;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseTypeCopyWith<_$_ExerciseType> get copyWith =>
      throw _privateConstructorUsedError;
}
