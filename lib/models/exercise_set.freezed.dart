// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExerciseSet _$ExerciseSetFromJson(Map<String, dynamic> json) {
  return _ExerciseSet.fromJson(json);
}

/// @nodoc
mixin _$ExerciseSet {
  String get load => throw _privateConstructorUsedError;
  String get reps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseSetCopyWith<ExerciseSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseSetCopyWith<$Res> {
  factory $ExerciseSetCopyWith(
          ExerciseSet value, $Res Function(ExerciseSet) then) =
      _$ExerciseSetCopyWithImpl<$Res, ExerciseSet>;
  @useResult
  $Res call({String load, String reps});
}

/// @nodoc
class _$ExerciseSetCopyWithImpl<$Res, $Val extends ExerciseSet>
    implements $ExerciseSetCopyWith<$Res> {
  _$ExerciseSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? load = null,
    Object? reps = null,
  }) {
    return _then(_value.copyWith(
      load: null == load
          ? _value.load
          : load // ignore: cast_nullable_to_non_nullable
              as String,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExerciseSetCopyWith<$Res>
    implements $ExerciseSetCopyWith<$Res> {
  factory _$$_ExerciseSetCopyWith(
          _$_ExerciseSet value, $Res Function(_$_ExerciseSet) then) =
      __$$_ExerciseSetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String load, String reps});
}

/// @nodoc
class __$$_ExerciseSetCopyWithImpl<$Res>
    extends _$ExerciseSetCopyWithImpl<$Res, _$_ExerciseSet>
    implements _$$_ExerciseSetCopyWith<$Res> {
  __$$_ExerciseSetCopyWithImpl(
      _$_ExerciseSet _value, $Res Function(_$_ExerciseSet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? load = null,
    Object? reps = null,
  }) {
    return _then(_$_ExerciseSet(
      load: null == load
          ? _value.load
          : load // ignore: cast_nullable_to_non_nullable
              as String,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExerciseSet with DiagnosticableTreeMixin implements _ExerciseSet {
  const _$_ExerciseSet({this.load = '', this.reps = ''});

  factory _$_ExerciseSet.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseSetFromJson(json);

  @override
  @JsonKey()
  final String load;
  @override
  @JsonKey()
  final String reps;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseSet(load: $load, reps: $reps)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseSet'))
      ..add(DiagnosticsProperty('load', load))
      ..add(DiagnosticsProperty('reps', reps));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExerciseSet &&
            (identical(other.load, load) || other.load == load) &&
            (identical(other.reps, reps) || other.reps == reps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, load, reps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseSetCopyWith<_$_ExerciseSet> get copyWith =>
      __$$_ExerciseSetCopyWithImpl<_$_ExerciseSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseSetToJson(
      this,
    );
  }
}

abstract class _ExerciseSet implements ExerciseSet {
  const factory _ExerciseSet({final String load, final String reps}) =
      _$_ExerciseSet;

  factory _ExerciseSet.fromJson(Map<String, dynamic> json) =
      _$_ExerciseSet.fromJson;

  @override
  String get load;
  @override
  String get reps;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseSetCopyWith<_$_ExerciseSet> get copyWith =>
      throw _privateConstructorUsedError;
}
