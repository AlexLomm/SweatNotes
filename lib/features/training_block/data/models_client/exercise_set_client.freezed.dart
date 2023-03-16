// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_set_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExerciseSetClient {
  ExerciseSet? get dbModel => throw _privateConstructorUsedError;
  int? get progressFactor => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError; // TODO: change to int
  String get reps =>
      throw _privateConstructorUsedError; // TODO: change to double
  String get load => throw _privateConstructorUsedError;
  String get predictedReps => throw _privateConstructorUsedError;
  String get predictedLoad => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExerciseSetClientCopyWith<ExerciseSetClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseSetClientCopyWith<$Res> {
  factory $ExerciseSetClientCopyWith(
          ExerciseSetClient value, $Res Function(ExerciseSetClient) then) =
      _$ExerciseSetClientCopyWithImpl<$Res, ExerciseSetClient>;
  @useResult
  $Res call(
      {ExerciseSet? dbModel,
      int? progressFactor,
      String unit,
      String reps,
      String load,
      String predictedReps,
      String predictedLoad});

  $ExerciseSetCopyWith<$Res>? get dbModel;
}

/// @nodoc
class _$ExerciseSetClientCopyWithImpl<$Res, $Val extends ExerciseSetClient>
    implements $ExerciseSetClientCopyWith<$Res> {
  _$ExerciseSetClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = freezed,
    Object? progressFactor = freezed,
    Object? unit = null,
    Object? reps = null,
    Object? load = null,
    Object? predictedReps = null,
    Object? predictedLoad = null,
  }) {
    return _then(_value.copyWith(
      dbModel: freezed == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseSet?,
      progressFactor: freezed == progressFactor
          ? _value.progressFactor
          : progressFactor // ignore: cast_nullable_to_non_nullable
              as int?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as String,
      load: null == load
          ? _value.load
          : load // ignore: cast_nullable_to_non_nullable
              as String,
      predictedReps: null == predictedReps
          ? _value.predictedReps
          : predictedReps // ignore: cast_nullable_to_non_nullable
              as String,
      predictedLoad: null == predictedLoad
          ? _value.predictedLoad
          : predictedLoad // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExerciseSetCopyWith<$Res>? get dbModel {
    if (_value.dbModel == null) {
      return null;
    }

    return $ExerciseSetCopyWith<$Res>(_value.dbModel!, (value) {
      return _then(_value.copyWith(dbModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ExerciseSetClientCopyWith<$Res>
    implements $ExerciseSetClientCopyWith<$Res> {
  factory _$$_ExerciseSetClientCopyWith(_$_ExerciseSetClient value,
          $Res Function(_$_ExerciseSetClient) then) =
      __$$_ExerciseSetClientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ExerciseSet? dbModel,
      int? progressFactor,
      String unit,
      String reps,
      String load,
      String predictedReps,
      String predictedLoad});

  @override
  $ExerciseSetCopyWith<$Res>? get dbModel;
}

/// @nodoc
class __$$_ExerciseSetClientCopyWithImpl<$Res>
    extends _$ExerciseSetClientCopyWithImpl<$Res, _$_ExerciseSetClient>
    implements _$$_ExerciseSetClientCopyWith<$Res> {
  __$$_ExerciseSetClientCopyWithImpl(
      _$_ExerciseSetClient _value, $Res Function(_$_ExerciseSetClient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = freezed,
    Object? progressFactor = freezed,
    Object? unit = null,
    Object? reps = null,
    Object? load = null,
    Object? predictedReps = null,
    Object? predictedLoad = null,
  }) {
    return _then(_$_ExerciseSetClient(
      dbModel: freezed == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseSet?,
      progressFactor: freezed == progressFactor
          ? _value.progressFactor
          : progressFactor // ignore: cast_nullable_to_non_nullable
              as int?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as String,
      load: null == load
          ? _value.load
          : load // ignore: cast_nullable_to_non_nullable
              as String,
      predictedReps: null == predictedReps
          ? _value.predictedReps
          : predictedReps // ignore: cast_nullable_to_non_nullable
              as String,
      predictedLoad: null == predictedLoad
          ? _value.predictedLoad
          : predictedLoad // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ExerciseSetClient extends _ExerciseSetClient
    with DiagnosticableTreeMixin {
  _$_ExerciseSetClient(
      {required this.dbModel,
      this.progressFactor,
      required this.unit,
      required this.reps,
      required this.load,
      this.predictedReps = '',
      this.predictedLoad = ''})
      : super._();

  @override
  final ExerciseSet? dbModel;
  @override
  final int? progressFactor;
  @override
  final String unit;
// TODO: change to int
  @override
  final String reps;
// TODO: change to double
  @override
  final String load;
  @override
  @JsonKey()
  final String predictedReps;
  @override
  @JsonKey()
  final String predictedLoad;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseSetClient(dbModel: $dbModel, progressFactor: $progressFactor, unit: $unit, reps: $reps, load: $load, predictedReps: $predictedReps, predictedLoad: $predictedLoad)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseSetClient'))
      ..add(DiagnosticsProperty('dbModel', dbModel))
      ..add(DiagnosticsProperty('progressFactor', progressFactor))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('reps', reps))
      ..add(DiagnosticsProperty('load', load))
      ..add(DiagnosticsProperty('predictedReps', predictedReps))
      ..add(DiagnosticsProperty('predictedLoad', predictedLoad));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExerciseSetClient &&
            (identical(other.dbModel, dbModel) || other.dbModel == dbModel) &&
            (identical(other.progressFactor, progressFactor) ||
                other.progressFactor == progressFactor) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.load, load) || other.load == load) &&
            (identical(other.predictedReps, predictedReps) ||
                other.predictedReps == predictedReps) &&
            (identical(other.predictedLoad, predictedLoad) ||
                other.predictedLoad == predictedLoad));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dbModel, progressFactor, unit,
      reps, load, predictedReps, predictedLoad);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseSetClientCopyWith<_$_ExerciseSetClient> get copyWith =>
      __$$_ExerciseSetClientCopyWithImpl<_$_ExerciseSetClient>(
          this, _$identity);
}

abstract class _ExerciseSetClient extends ExerciseSetClient {
  factory _ExerciseSetClient(
      {required final ExerciseSet? dbModel,
      final int? progressFactor,
      required final String unit,
      required final String reps,
      required final String load,
      final String predictedReps,
      final String predictedLoad}) = _$_ExerciseSetClient;
  _ExerciseSetClient._() : super._();

  @override
  ExerciseSet? get dbModel;
  @override
  int? get progressFactor;
  @override
  String get unit;
  @override // TODO: change to int
  String get reps;
  @override // TODO: change to double
  String get load;
  @override
  String get predictedReps;
  @override
  String get predictedLoad;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseSetClientCopyWith<_$_ExerciseSetClient> get copyWith =>
      throw _privateConstructorUsedError;
}
