// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_type_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExerciseTypeClient {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  List<ExerciseClient> get exercises => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExerciseTypeClientCopyWith<ExerciseTypeClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseTypeClientCopyWith<$Res> {
  factory $ExerciseTypeClientCopyWith(
          ExerciseTypeClient value, $Res Function(ExerciseTypeClient) then) =
      _$ExerciseTypeClientCopyWithImpl<$Res, ExerciseTypeClient>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String unit,
      List<ExerciseClient> exercises});
}

/// @nodoc
class _$ExerciseTypeClientCopyWithImpl<$Res, $Val extends ExerciseTypeClient>
    implements $ExerciseTypeClientCopyWith<$Res> {
  _$ExerciseTypeClientCopyWithImpl(this._value, this._then);

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
    Object? exercises = null,
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
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ExerciseClient>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExerciseTypeClientCopyWith<$Res>
    implements $ExerciseTypeClientCopyWith<$Res> {
  factory _$$_ExerciseTypeClientCopyWith(_$_ExerciseTypeClient value,
          $Res Function(_$_ExerciseTypeClient) then) =
      __$$_ExerciseTypeClientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String name,
      String unit,
      List<ExerciseClient> exercises});
}

/// @nodoc
class __$$_ExerciseTypeClientCopyWithImpl<$Res>
    extends _$ExerciseTypeClientCopyWithImpl<$Res, _$_ExerciseTypeClient>
    implements _$$_ExerciseTypeClientCopyWith<$Res> {
  __$$_ExerciseTypeClientCopyWithImpl(
      _$_ExerciseTypeClient _value, $Res Function(_$_ExerciseTypeClient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? unit = null,
    Object? exercises = null,
  }) {
    return _then(_$_ExerciseTypeClient(
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
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ExerciseClient>,
    ));
  }
}

/// @nodoc

class _$_ExerciseTypeClient extends _ExerciseTypeClient
    with DiagnosticableTreeMixin {
  const _$_ExerciseTypeClient(
      {required this.id,
      required this.userId,
      required this.name,
      required this.unit,
      required final List<ExerciseClient> exercises})
      : _exercises = exercises,
        super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final String unit;
  final List<ExerciseClient> _exercises;
  @override
  List<ExerciseClient> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseTypeClient(id: $id, userId: $userId, name: $name, unit: $unit, exercises: $exercises)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseTypeClient'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('exercises', exercises));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExerciseTypeClient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, unit,
      const DeepCollectionEquality().hash(_exercises));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseTypeClientCopyWith<_$_ExerciseTypeClient> get copyWith =>
      __$$_ExerciseTypeClientCopyWithImpl<_$_ExerciseTypeClient>(
          this, _$identity);
}

abstract class _ExerciseTypeClient extends ExerciseTypeClient {
  const factory _ExerciseTypeClient(
      {required final String id,
      required final String userId,
      required final String name,
      required final String unit,
      required final List<ExerciseClient> exercises}) = _$_ExerciseTypeClient;
  const _ExerciseTypeClient._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  String get unit;
  @override
  List<ExerciseClient> get exercises;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseTypeClientCopyWith<_$_ExerciseTypeClient> get copyWith =>
      throw _privateConstructorUsedError;
}
