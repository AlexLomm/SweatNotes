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
  @Assert('reactionScore == null || [-5, 0, 5].contains(reactionScore)',
      'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)')
  int? get reactionScore => throw _privateConstructorUsedError;
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
      {@Assert('reactionScore == null || [-5, 0, 5].contains(reactionScore)',
          'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)')
      int? reactionScore,
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
    Object? reactionScore = freezed,
    Object? sets = null,
  }) {
    return _then(_value.copyWith(
      reactionScore: freezed == reactionScore
          ? _value.reactionScore
          : reactionScore // ignore: cast_nullable_to_non_nullable
              as int?,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSet>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Assert('reactionScore == null || [-5, 0, 5].contains(reactionScore)',
          'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)')
      int? reactionScore,
      List<ExerciseSet> sets});
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reactionScore = freezed,
    Object? sets = null,
  }) {
    return _then(_$ExerciseImpl(
      reactionScore: freezed == reactionScore
          ? _value.reactionScore
          : reactionScore // ignore: cast_nullable_to_non_nullable
              as int?,
      sets: null == sets
          ? _value._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSet>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl extends _Exercise with DiagnosticableTreeMixin {
  const _$ExerciseImpl(
      {@Assert('reactionScore == null || [-5, 0, 5].contains(reactionScore)',
          'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)')
      this.reactionScore,
      final List<ExerciseSet> sets = const []})
      : _sets = sets,
        super._();

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  @Assert('reactionScore == null || [-5, 0, 5].contains(reactionScore)',
      'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)')
  final int? reactionScore;
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
    return 'Exercise(reactionScore: $reactionScore, sets: $sets)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Exercise'))
      ..add(DiagnosticsProperty('reactionScore', reactionScore))
      ..add(DiagnosticsProperty('sets', sets));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(
      this,
    );
  }
}

abstract class _Exercise extends Exercise {
  const factory _Exercise(
      {@Assert('reactionScore == null || [-5, 0, 5].contains(reactionScore)',
          'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)')
      final int? reactionScore,
      final List<ExerciseSet> sets}) = _$ExerciseImpl;
  const _Exercise._() : super._();

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  @Assert('reactionScore == null || [-5, 0, 5].contains(reactionScore)',
      'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)')
  int? get reactionScore;
  @override
  List<ExerciseSet> get sets;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
