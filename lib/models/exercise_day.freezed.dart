// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExerciseDay _$ExerciseDayFromJson(Map<String, dynamic> json) {
  return _ExerciseDay.fromJson(json);
}

/// @nodoc
mixin _$ExerciseDay {
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get trainingBlockId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseDayCopyWith<ExerciseDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseDayCopyWith<$Res> {
  factory $ExerciseDayCopyWith(
          ExerciseDay value, $Res Function(ExerciseDay) then) =
      _$ExerciseDayCopyWithImpl<$Res, ExerciseDay>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String userId,
      String trainingBlockId,
      String name});
}

/// @nodoc
class _$ExerciseDayCopyWithImpl<$Res, $Val extends ExerciseDay>
    implements $ExerciseDayCopyWith<$Res> {
  _$ExerciseDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? trainingBlockId = null,
    Object? name = null,
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
      trainingBlockId: null == trainingBlockId
          ? _value.trainingBlockId
          : trainingBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExerciseDayCopyWith<$Res>
    implements $ExerciseDayCopyWith<$Res> {
  factory _$$_ExerciseDayCopyWith(
          _$_ExerciseDay value, $Res Function(_$_ExerciseDay) then) =
      __$$_ExerciseDayCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String userId,
      String trainingBlockId,
      String name});
}

/// @nodoc
class __$$_ExerciseDayCopyWithImpl<$Res>
    extends _$ExerciseDayCopyWithImpl<$Res, _$_ExerciseDay>
    implements _$$_ExerciseDayCopyWith<$Res> {
  __$$_ExerciseDayCopyWithImpl(
      _$_ExerciseDay _value, $Res Function(_$_ExerciseDay) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? trainingBlockId = null,
    Object? name = null,
  }) {
    return _then(_$_ExerciseDay(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      trainingBlockId: null == trainingBlockId
          ? _value.trainingBlockId
          : trainingBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExerciseDay with DiagnosticableTreeMixin implements _ExerciseDay {
  const _$_ExerciseDay(
      {@JsonKey(includeToJson: false) required this.id,
      required this.userId,
      required this.trainingBlockId,
      required this.name});

  factory _$_ExerciseDay.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseDayFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  final String userId;
  @override
  final String trainingBlockId;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseDay(id: $id, userId: $userId, trainingBlockId: $trainingBlockId, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseDay'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('trainingBlockId', trainingBlockId))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExerciseDay &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.trainingBlockId, trainingBlockId) ||
                other.trainingBlockId == trainingBlockId) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, trainingBlockId, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseDayCopyWith<_$_ExerciseDay> get copyWith =>
      __$$_ExerciseDayCopyWithImpl<_$_ExerciseDay>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseDayToJson(
      this,
    );
  }
}

abstract class _ExerciseDay implements ExerciseDay {
  const factory _ExerciseDay(
      {@JsonKey(includeToJson: false) required final String id,
      required final String userId,
      required final String trainingBlockId,
      required final String name}) = _$_ExerciseDay;

  factory _ExerciseDay.fromJson(Map<String, dynamic> json) =
      _$_ExerciseDay.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  String get userId;
  @override
  String get trainingBlockId;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseDayCopyWith<_$_ExerciseDay> get copyWith =>
      throw _privateConstructorUsedError;
}
