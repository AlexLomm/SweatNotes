// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_block_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainingBlockClient {
  TrainingBlock get dbModel => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ExerciseDayClient> get exerciseDays =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingBlockClientCopyWith<TrainingBlockClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingBlockClientCopyWith<$Res> {
  factory $TrainingBlockClientCopyWith(
          TrainingBlockClient value, $Res Function(TrainingBlockClient) then) =
      _$TrainingBlockClientCopyWithImpl<$Res, TrainingBlockClient>;
  @useResult
  $Res call(
      {TrainingBlock dbModel,
      String name,
      List<ExerciseDayClient> exerciseDays});

  $TrainingBlockCopyWith<$Res> get dbModel;
}

/// @nodoc
class _$TrainingBlockClientCopyWithImpl<$Res, $Val extends TrainingBlockClient>
    implements $TrainingBlockClientCopyWith<$Res> {
  _$TrainingBlockClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = null,
    Object? name = null,
    Object? exerciseDays = null,
  }) {
    return _then(_value.copyWith(
      dbModel: null == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as TrainingBlock,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDays: null == exerciseDays
          ? _value.exerciseDays
          : exerciseDays // ignore: cast_nullable_to_non_nullable
              as List<ExerciseDayClient>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TrainingBlockCopyWith<$Res> get dbModel {
    return $TrainingBlockCopyWith<$Res>(_value.dbModel, (value) {
      return _then(_value.copyWith(dbModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TrainingBlockClientCopyWith<$Res>
    implements $TrainingBlockClientCopyWith<$Res> {
  factory _$$_TrainingBlockClientCopyWith(_$_TrainingBlockClient value,
          $Res Function(_$_TrainingBlockClient) then) =
      __$$_TrainingBlockClientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TrainingBlock dbModel,
      String name,
      List<ExerciseDayClient> exerciseDays});

  @override
  $TrainingBlockCopyWith<$Res> get dbModel;
}

/// @nodoc
class __$$_TrainingBlockClientCopyWithImpl<$Res>
    extends _$TrainingBlockClientCopyWithImpl<$Res, _$_TrainingBlockClient>
    implements _$$_TrainingBlockClientCopyWith<$Res> {
  __$$_TrainingBlockClientCopyWithImpl(_$_TrainingBlockClient _value,
      $Res Function(_$_TrainingBlockClient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = null,
    Object? name = null,
    Object? exerciseDays = null,
  }) {
    return _then(_$_TrainingBlockClient(
      dbModel: null == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as TrainingBlock,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDays: null == exerciseDays
          ? _value._exerciseDays
          : exerciseDays // ignore: cast_nullable_to_non_nullable
              as List<ExerciseDayClient>,
    ));
  }
}

/// @nodoc

class _$_TrainingBlockClient extends _TrainingBlockClient
    with DiagnosticableTreeMixin {
  const _$_TrainingBlockClient(
      {required this.dbModel,
      required this.name,
      required final List<ExerciseDayClient> exerciseDays})
      : _exerciseDays = exerciseDays,
        super._();

  @override
  final TrainingBlock dbModel;
  @override
  final String name;
  final List<ExerciseDayClient> _exerciseDays;
  @override
  List<ExerciseDayClient> get exerciseDays {
    if (_exerciseDays is EqualUnmodifiableListView) return _exerciseDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseDays);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrainingBlockClient(dbModel: $dbModel, name: $name, exerciseDays: $exerciseDays)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrainingBlockClient'))
      ..add(DiagnosticsProperty('dbModel', dbModel))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseDays', exerciseDays));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingBlockClientCopyWith<_$_TrainingBlockClient> get copyWith =>
      __$$_TrainingBlockClientCopyWithImpl<_$_TrainingBlockClient>(
          this, _$identity);
}

abstract class _TrainingBlockClient extends TrainingBlockClient {
  const factory _TrainingBlockClient(
          {required final TrainingBlock dbModel,
          required final String name,
          required final List<ExerciseDayClient> exerciseDays}) =
      _$_TrainingBlockClient;
  const _TrainingBlockClient._() : super._();

  @override
  TrainingBlock get dbModel;
  @override
  String get name;
  @override
  List<ExerciseDayClient> get exerciseDays;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingBlockClientCopyWith<_$_TrainingBlockClient> get copyWith =>
      throw _privateConstructorUsedError;
}
