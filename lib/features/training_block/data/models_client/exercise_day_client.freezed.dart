// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_day_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExerciseDayClient {
  ExerciseDay? get dbModel => throw _privateConstructorUsedError;
  Timestamp? get archivedAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ExerciseTypeClient> get exerciseTypes =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExerciseDayClientCopyWith<ExerciseDayClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseDayClientCopyWith<$Res> {
  factory $ExerciseDayClientCopyWith(
          ExerciseDayClient value, $Res Function(ExerciseDayClient) then) =
      _$ExerciseDayClientCopyWithImpl<$Res, ExerciseDayClient>;
  @useResult
  $Res call(
      {ExerciseDay? dbModel,
      Timestamp? archivedAt,
      String name,
      List<ExerciseTypeClient> exerciseTypes});

  $ExerciseDayCopyWith<$Res>? get dbModel;
}

/// @nodoc
class _$ExerciseDayClientCopyWithImpl<$Res, $Val extends ExerciseDayClient>
    implements $ExerciseDayClientCopyWith<$Res> {
  _$ExerciseDayClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = freezed,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? exerciseTypes = null,
  }) {
    return _then(_value.copyWith(
      dbModel: freezed == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseDay?,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseTypes: null == exerciseTypes
          ? _value.exerciseTypes
          : exerciseTypes // ignore: cast_nullable_to_non_nullable
              as List<ExerciseTypeClient>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExerciseDayCopyWith<$Res>? get dbModel {
    if (_value.dbModel == null) {
      return null;
    }

    return $ExerciseDayCopyWith<$Res>(_value.dbModel!, (value) {
      return _then(_value.copyWith(dbModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ExerciseDayClientCopyWith<$Res>
    implements $ExerciseDayClientCopyWith<$Res> {
  factory _$$_ExerciseDayClientCopyWith(_$_ExerciseDayClient value,
          $Res Function(_$_ExerciseDayClient) then) =
      __$$_ExerciseDayClientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ExerciseDay? dbModel,
      Timestamp? archivedAt,
      String name,
      List<ExerciseTypeClient> exerciseTypes});

  @override
  $ExerciseDayCopyWith<$Res>? get dbModel;
}

/// @nodoc
class __$$_ExerciseDayClientCopyWithImpl<$Res>
    extends _$ExerciseDayClientCopyWithImpl<$Res, _$_ExerciseDayClient>
    implements _$$_ExerciseDayClientCopyWith<$Res> {
  __$$_ExerciseDayClientCopyWithImpl(
      _$_ExerciseDayClient _value, $Res Function(_$_ExerciseDayClient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = freezed,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? exerciseTypes = null,
  }) {
    return _then(_$_ExerciseDayClient(
      dbModel: freezed == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseDay?,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseTypes: null == exerciseTypes
          ? _value._exerciseTypes
          : exerciseTypes // ignore: cast_nullable_to_non_nullable
              as List<ExerciseTypeClient>,
    ));
  }
}

/// @nodoc

class _$_ExerciseDayClient extends _ExerciseDayClient
    with DiagnosticableTreeMixin {
  const _$_ExerciseDayClient(
      {this.dbModel,
      this.archivedAt,
      required this.name,
      required final List<ExerciseTypeClient> exerciseTypes})
      : _exerciseTypes = exerciseTypes,
        super._();

  @override
  final ExerciseDay? dbModel;
  @override
  final Timestamp? archivedAt;
  @override
  final String name;
  final List<ExerciseTypeClient> _exerciseTypes;
  @override
  List<ExerciseTypeClient> get exerciseTypes {
    if (_exerciseTypes is EqualUnmodifiableListView) return _exerciseTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseTypes);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseDayClient(dbModel: $dbModel, archivedAt: $archivedAt, name: $name, exerciseTypes: $exerciseTypes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseDayClient'))
      ..add(DiagnosticsProperty('dbModel', dbModel))
      ..add(DiagnosticsProperty('archivedAt', archivedAt))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseTypes', exerciseTypes));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseDayClientCopyWith<_$_ExerciseDayClient> get copyWith =>
      __$$_ExerciseDayClientCopyWithImpl<_$_ExerciseDayClient>(
          this, _$identity);
}

abstract class _ExerciseDayClient extends ExerciseDayClient {
  const factory _ExerciseDayClient(
          {final ExerciseDay? dbModel,
          final Timestamp? archivedAt,
          required final String name,
          required final List<ExerciseTypeClient> exerciseTypes}) =
      _$_ExerciseDayClient;
  const _ExerciseDayClient._() : super._();

  @override
  ExerciseDay? get dbModel;
  @override
  Timestamp? get archivedAt;
  @override
  String get name;
  @override
  List<ExerciseTypeClient> get exerciseTypes;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseDayClientCopyWith<_$_ExerciseDayClient> get copyWith =>
      throw _privateConstructorUsedError;
}
