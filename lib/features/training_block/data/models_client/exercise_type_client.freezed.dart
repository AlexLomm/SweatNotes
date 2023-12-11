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
  ExerciseType get dbModel => throw _privateConstructorUsedError;
  Timestamp? get archivedAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
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
      {ExerciseType dbModel,
      Timestamp? archivedAt,
      String name,
      String unit,
      String notes,
      List<ExerciseClient> exercises});

  $ExerciseTypeCopyWith<$Res> get dbModel;
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
    Object? dbModel = null,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? unit = null,
    Object? notes = null,
    Object? exercises = null,
  }) {
    return _then(_value.copyWith(
      dbModel: null == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseType,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ExerciseClient>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExerciseTypeCopyWith<$Res> get dbModel {
    return $ExerciseTypeCopyWith<$Res>(_value.dbModel, (value) {
      return _then(_value.copyWith(dbModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExerciseTypeClientImplCopyWith<$Res>
    implements $ExerciseTypeClientCopyWith<$Res> {
  factory _$$ExerciseTypeClientImplCopyWith(_$ExerciseTypeClientImpl value,
          $Res Function(_$ExerciseTypeClientImpl) then) =
      __$$ExerciseTypeClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ExerciseType dbModel,
      Timestamp? archivedAt,
      String name,
      String unit,
      String notes,
      List<ExerciseClient> exercises});

  @override
  $ExerciseTypeCopyWith<$Res> get dbModel;
}

/// @nodoc
class __$$ExerciseTypeClientImplCopyWithImpl<$Res>
    extends _$ExerciseTypeClientCopyWithImpl<$Res, _$ExerciseTypeClientImpl>
    implements _$$ExerciseTypeClientImplCopyWith<$Res> {
  __$$ExerciseTypeClientImplCopyWithImpl(_$ExerciseTypeClientImpl _value,
      $Res Function(_$ExerciseTypeClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbModel = null,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? unit = null,
    Object? notes = null,
    Object? exercises = null,
  }) {
    return _then(_$ExerciseTypeClientImpl(
      dbModel: null == dbModel
          ? _value.dbModel
          : dbModel // ignore: cast_nullable_to_non_nullable
              as ExerciseType,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<ExerciseClient>,
    ));
  }
}

/// @nodoc

class _$ExerciseTypeClientImpl extends _ExerciseTypeClient
    with DiagnosticableTreeMixin {
  const _$ExerciseTypeClientImpl(
      {required this.dbModel,
      this.archivedAt,
      required this.name,
      required this.unit,
      required this.notes,
      required final List<ExerciseClient> exercises})
      : _exercises = exercises,
        super._();

  @override
  final ExerciseType dbModel;
  @override
  final Timestamp? archivedAt;
  @override
  final String name;
  @override
  final String unit;
  @override
  final String notes;
  final List<ExerciseClient> _exercises;
  @override
  List<ExerciseClient> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseTypeClient(dbModel: $dbModel, archivedAt: $archivedAt, name: $name, unit: $unit, notes: $notes, exercises: $exercises)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseTypeClient'))
      ..add(DiagnosticsProperty('dbModel', dbModel))
      ..add(DiagnosticsProperty('archivedAt', archivedAt))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('unit', unit))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('exercises', exercises));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseTypeClientImplCopyWith<_$ExerciseTypeClientImpl> get copyWith =>
      __$$ExerciseTypeClientImplCopyWithImpl<_$ExerciseTypeClientImpl>(
          this, _$identity);
}

abstract class _ExerciseTypeClient extends ExerciseTypeClient {
  const factory _ExerciseTypeClient(
          {required final ExerciseType dbModel,
          final Timestamp? archivedAt,
          required final String name,
          required final String unit,
          required final String notes,
          required final List<ExerciseClient> exercises}) =
      _$ExerciseTypeClientImpl;
  const _ExerciseTypeClient._() : super._();

  @override
  ExerciseType get dbModel;
  @override
  Timestamp? get archivedAt;
  @override
  String get name;
  @override
  String get unit;
  @override
  String get notes;
  @override
  List<ExerciseClient> get exercises;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseTypeClientImplCopyWith<_$ExerciseTypeClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
