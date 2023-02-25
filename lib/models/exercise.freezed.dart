// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get exerciseDayId => throw _privateConstructorUsedError;
  String get exerciseTypeId => throw _privateConstructorUsedError;
  int get placement => throw _privateConstructorUsedError;
  List<ExerciseSet> get sets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String exerciseDayId,
      String exerciseTypeId,
      int placement,
      List<ExerciseSet> sets});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? exerciseDayId = null,
    Object? exerciseTypeId = null,
    Object? placement = null,
    Object? sets = null,
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
      exerciseDayId: null == exerciseDayId
          ? _value.exerciseDayId
          : exerciseDayId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseTypeId: null == exerciseTypeId
          ? _value.exerciseTypeId
          : exerciseTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      placement: null == placement
          ? _value.placement
          : placement // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSet>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExerciseCopyWith<$Res> implements $ExerciseCopyWith<$Res> {
  factory _$$_ExerciseCopyWith(
          _$_Exercise value, $Res Function(_$_Exercise) then) =
      __$$_ExerciseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String exerciseDayId,
      String exerciseTypeId,
      int placement,
      List<ExerciseSet> sets});
}

/// @nodoc
class __$$_ExerciseCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$_Exercise>
    implements _$$_ExerciseCopyWith<$Res> {
  __$$_ExerciseCopyWithImpl(
      _$_Exercise _value, $Res Function(_$_Exercise) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? exerciseDayId = null,
    Object? exerciseTypeId = null,
    Object? placement = null,
    Object? sets = null,
  }) {
    return _then(_$_Exercise(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDayId: null == exerciseDayId
          ? _value.exerciseDayId
          : exerciseDayId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseTypeId: null == exerciseTypeId
          ? _value.exerciseTypeId
          : exerciseTypeId // ignore: cast_nullable_to_non_nullable
              as String,
      placement: null == placement
          ? _value.placement
          : placement // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSet>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Exercise with DiagnosticableTreeMixin implements _Exercise {
  const _$_Exercise(
      {required this.id,
      required this.userId,
      required this.exerciseDayId,
      required this.exerciseTypeId,
      this.placement = -1,
      final List<ExerciseSet> sets = const []})
      : _sets = sets;

  factory _$_Exercise.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String exerciseDayId;
  @override
  final String exerciseTypeId;
  @override
  @JsonKey()
  final int placement;
  final List<ExerciseSet> _sets;
  @override
  @JsonKey()
  List<ExerciseSet> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Exercise(id: $id, userId: $userId, exerciseDayId: $exerciseDayId, exerciseTypeId: $exerciseTypeId, placement: $placement, sets: $sets)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Exercise'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('exerciseDayId', exerciseDayId))
      ..add(DiagnosticsProperty('exerciseTypeId', exerciseTypeId))
      ..add(DiagnosticsProperty('placement', placement))
      ..add(DiagnosticsProperty('sets', sets));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Exercise &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.exerciseDayId, exerciseDayId) ||
                other.exerciseDayId == exerciseDayId) &&
            (identical(other.exerciseTypeId, exerciseTypeId) ||
                other.exerciseTypeId == exerciseTypeId) &&
            (identical(other.placement, placement) ||
                other.placement == placement) &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, exerciseDayId,
      exerciseTypeId, placement, const DeepCollectionEquality().hash(_sets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseCopyWith<_$_Exercise> get copyWith =>
      __$$_ExerciseCopyWithImpl<_$_Exercise>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseToJson(
      this,
    );
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {required final String id,
      required final String userId,
      required final String exerciseDayId,
      required final String exerciseTypeId,
      final int placement,
      final List<ExerciseSet> sets}) = _$_Exercise;

  factory _Exercise.fromJson(Map<String, dynamic> json) = _$_Exercise.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get exerciseDayId;
  @override
  String get exerciseTypeId;
  @override
  int get placement;
  @override
  List<ExerciseSet> get sets;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseCopyWith<_$_Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}
