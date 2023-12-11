// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExerciseClient {
  Exercise? get dbModel => throw _privateConstructorUsedError;
  bool get isFiller => throw _privateConstructorUsedError;
  int? get reactionScore => throw _privateConstructorUsedError;
  List<ExerciseSetClient> get sets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExerciseClientCopyWith<ExerciseClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseClientCopyWith<$Res> {
  factory $ExerciseClientCopyWith(
          ExerciseClient value, $Res Function(ExerciseClient) then) =
      _$ExerciseClientCopyWithImpl<$Res, ExerciseClient>;
  @useResult
  $Res call(
      {Exercise? dbModel,
      bool isFiller,
      int? reactionScore,
      List<ExerciseSetClient> sets});

  $ExerciseCopyWith<$Res>? get dbModel;
}

/// @nodoc
class _$ExerciseClientCopyWithImpl<$Res, $Val extends ExerciseClient>
    implements $ExerciseClientCopyWith<$Res> {
  _$ExerciseClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = freezed,
    Object? isFiller = null,
    Object? reactionScore = freezed,
    Object? sets = null,
  }) {
    return _then(_value.copyWith(
      dbModel: freezed == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as Exercise?,
      isFiller: null == isFiller
          ? _value.isFiller
          : isFiller // ignore: cast_nullable_to_non_nullable
              as bool,
      reactionScore: freezed == reactionScore
          ? _value.reactionScore
          : reactionScore // ignore: cast_nullable_to_non_nullable
              as int?,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSetClient>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<$Res>? get dbModel {
    if (_value.dbModel == null) {
      return null;
    }

    return $ExerciseCopyWith<$Res>(_value.dbModel!, (value) {
      return _then(_value.copyWith(dbModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExerciseClientImplCopyWith<$Res>
    implements $ExerciseClientCopyWith<$Res> {
  factory _$$ExerciseClientImplCopyWith(_$ExerciseClientImpl value,
          $Res Function(_$ExerciseClientImpl) then) =
      __$$ExerciseClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Exercise? dbModel,
      bool isFiller,
      int? reactionScore,
      List<ExerciseSetClient> sets});

  @override
  $ExerciseCopyWith<$Res>? get dbModel;
}

/// @nodoc
class __$$ExerciseClientImplCopyWithImpl<$Res>
    extends _$ExerciseClientCopyWithImpl<$Res, _$ExerciseClientImpl>
    implements _$$ExerciseClientImplCopyWith<$Res> {
  __$$ExerciseClientImplCopyWithImpl(
      _$ExerciseClientImpl _value, $Res Function(_$ExerciseClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = freezed,
    Object? isFiller = null,
    Object? reactionScore = freezed,
    Object? sets = null,
  }) {
    return _then(_$ExerciseClientImpl(
      dbModel: freezed == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as Exercise?,
      isFiller: null == isFiller
          ? _value.isFiller
          : isFiller // ignore: cast_nullable_to_non_nullable
              as bool,
      reactionScore: freezed == reactionScore
          ? _value.reactionScore
          : reactionScore // ignore: cast_nullable_to_non_nullable
              as int?,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSetClient>,
    ));
  }
}

/// @nodoc

class _$ExerciseClientImpl extends _ExerciseClient
    with DiagnosticableTreeMixin {
  const _$ExerciseClientImpl(
      {this.dbModel,
      required this.isFiller,
      required this.reactionScore,
      required this.sets})
      : super._();

  @override
  final Exercise? dbModel;
  @override
  final bool isFiller;
  @override
  final int? reactionScore;
  @override
  final List<ExerciseSetClient> sets;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseClient(dbModel: $dbModel, isFiller: $isFiller, reactionScore: $reactionScore, sets: $sets)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseClient'))
      ..add(DiagnosticsProperty('dbModel', dbModel))
      ..add(DiagnosticsProperty('isFiller', isFiller))
      ..add(DiagnosticsProperty('reactionScore', reactionScore))
      ..add(DiagnosticsProperty('sets', sets));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseClientImplCopyWith<_$ExerciseClientImpl> get copyWith =>
      __$$ExerciseClientImplCopyWithImpl<_$ExerciseClientImpl>(
          this, _$identity);
}

abstract class _ExerciseClient extends ExerciseClient {
  const factory _ExerciseClient(
      {final Exercise? dbModel,
      required final bool isFiller,
      required final int? reactionScore,
      required final List<ExerciseSetClient> sets}) = _$ExerciseClientImpl;
  const _ExerciseClient._() : super._();

  @override
  Exercise? get dbModel;
  @override
  bool get isFiller;
  @override
  int? get reactionScore;
  @override
  List<ExerciseSetClient> get sets;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseClientImplCopyWith<_$ExerciseClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
