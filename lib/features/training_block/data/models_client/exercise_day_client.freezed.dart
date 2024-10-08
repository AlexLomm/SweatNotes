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
  ExerciseDay get dbModel => throw _privateConstructorUsedError;
  List<DateTime> get dates => throw _privateConstructorUsedError;
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
      {ExerciseDay dbModel,
      List<DateTime> dates,
      Timestamp? archivedAt,
      String name,
      List<ExerciseTypeClient> exerciseTypes});

  $ExerciseDayCopyWith<$Res> get dbModel;
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
    Object? dbModel = null,
    Object? dates = null,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? exerciseTypes = null,
  }) {
    return _then(_value.copyWith(
      dbModel: null == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseDay,
      dates: null == dates
          ? _value.dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
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
  $ExerciseDayCopyWith<$Res> get dbModel {
    return $ExerciseDayCopyWith<$Res>(_value.dbModel, (value) {
      return _then(_value.copyWith(dbModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExerciseDayClientImplCopyWith<$Res>
    implements $ExerciseDayClientCopyWith<$Res> {
  factory _$$ExerciseDayClientImplCopyWith(_$ExerciseDayClientImpl value,
          $Res Function(_$ExerciseDayClientImpl) then) =
      __$$ExerciseDayClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ExerciseDay dbModel,
      List<DateTime> dates,
      Timestamp? archivedAt,
      String name,
      List<ExerciseTypeClient> exerciseTypes});

  @override
  $ExerciseDayCopyWith<$Res> get dbModel;
}

/// @nodoc
class __$$ExerciseDayClientImplCopyWithImpl<$Res>
    extends _$ExerciseDayClientCopyWithImpl<$Res, _$ExerciseDayClientImpl>
    implements _$$ExerciseDayClientImplCopyWith<$Res> {
  __$$ExerciseDayClientImplCopyWithImpl(_$ExerciseDayClientImpl _value,
      $Res Function(_$ExerciseDayClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = null,
    Object? dates = null,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? exerciseTypes = null,
  }) {
    return _then(_$ExerciseDayClientImpl(
      dbModel: null == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseDay,
      dates: null == dates
          ? _value._dates
          : dates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
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

class _$ExerciseDayClientImpl extends _ExerciseDayClient
    with DiagnosticableTreeMixin {
  const _$ExerciseDayClientImpl(
      {required this.dbModel,
      required final List<DateTime> dates,
      this.archivedAt,
      required this.name,
      required final List<ExerciseTypeClient> exerciseTypes})
      : _dates = dates,
        _exerciseTypes = exerciseTypes,
        super._();

  @override
  final ExerciseDay dbModel;
  final List<DateTime> _dates;
  @override
  List<DateTime> get dates {
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dates);
  }

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
    return 'ExerciseDayClient(dbModel: $dbModel, dates: $dates, archivedAt: $archivedAt, name: $name, exerciseTypes: $exerciseTypes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseDayClient'))
      ..add(DiagnosticsProperty('dbModel', dbModel))
      ..add(DiagnosticsProperty('dates', dates))
      ..add(DiagnosticsProperty('archivedAt', archivedAt))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseTypes', exerciseTypes));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseDayClientImplCopyWith<_$ExerciseDayClientImpl> get copyWith =>
      __$$ExerciseDayClientImplCopyWithImpl<_$ExerciseDayClientImpl>(
          this, _$identity);
}

abstract class _ExerciseDayClient extends ExerciseDayClient {
  const factory _ExerciseDayClient(
          {required final ExerciseDay dbModel,
          required final List<DateTime> dates,
          final Timestamp? archivedAt,
          required final String name,
          required final List<ExerciseTypeClient> exerciseTypes}) =
      _$ExerciseDayClientImpl;
  const _ExerciseDayClient._() : super._();

  @override
  ExerciseDay get dbModel;
  @override
  List<DateTime> get dates;
  @override
  Timestamp? get archivedAt;
  @override
  String get name;
  @override
  List<ExerciseTypeClient> get exerciseTypes;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseDayClientImplCopyWith<_$ExerciseDayClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
