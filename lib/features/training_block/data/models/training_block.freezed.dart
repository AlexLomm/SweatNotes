// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrainingBlock _$TrainingBlockFromJson(Map<String, dynamic> json) {
  return _TrainingBlock.fromJson(json);
}

/// @nodoc
mixin _$TrainingBlock {
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson)
  Timestamp? get archivedAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ExerciseDay> get exerciseDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrainingBlockCopyWith<TrainingBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingBlockCopyWith<$Res> {
  factory $TrainingBlockCopyWith(
          TrainingBlock value, $Res Function(TrainingBlock) then) =
      _$TrainingBlockCopyWithImpl<$Res, TrainingBlock>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false)
          String id,
      @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson)
          Timestamp? archivedAt,
      String name,
      List<ExerciseDay> exerciseDays});
}

/// @nodoc
class _$TrainingBlockCopyWithImpl<$Res, $Val extends TrainingBlock>
    implements $TrainingBlockCopyWith<$Res> {
  _$TrainingBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? exerciseDays = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDays: null == exerciseDays
          ? _value.exerciseDays
          : exerciseDays // ignore: cast_nullable_to_non_nullable
              as List<ExerciseDay>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrainingBlockCopyWith<$Res>
    implements $TrainingBlockCopyWith<$Res> {
  factory _$$_TrainingBlockCopyWith(
          _$_TrainingBlock value, $Res Function(_$_TrainingBlock) then) =
      __$$_TrainingBlockCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false)
          String id,
      @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson)
          Timestamp? archivedAt,
      String name,
      List<ExerciseDay> exerciseDays});
}

/// @nodoc
class __$$_TrainingBlockCopyWithImpl<$Res>
    extends _$TrainingBlockCopyWithImpl<$Res, _$_TrainingBlock>
    implements _$$_TrainingBlockCopyWith<$Res> {
  __$$_TrainingBlockCopyWithImpl(
      _$_TrainingBlock _value, $Res Function(_$_TrainingBlock) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? archivedAt = freezed,
    Object? name = null,
    Object? exerciseDays = null,
  }) {
    return _then(_$_TrainingBlock(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDays: null == exerciseDays
          ? _value._exerciseDays
          : exerciseDays // ignore: cast_nullable_to_non_nullable
              as List<ExerciseDay>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TrainingBlock with DiagnosticableTreeMixin implements _TrainingBlock {
  const _$_TrainingBlock(
      {@JsonKey(includeToJson: false)
          required this.id,
      @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson)
          this.archivedAt,
      required this.name,
      final List<ExerciseDay> exerciseDays = const []})
      : _exerciseDays = exerciseDays;

  factory _$_TrainingBlock.fromJson(Map<String, dynamic> json) =>
      _$$_TrainingBlockFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson)
  final Timestamp? archivedAt;
  @override
  final String name;
  final List<ExerciseDay> _exerciseDays;
  @override
  @JsonKey()
  List<ExerciseDay> get exerciseDays {
    if (_exerciseDays is EqualUnmodifiableListView) return _exerciseDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseDays);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrainingBlock(id: $id, archivedAt: $archivedAt, name: $name, exerciseDays: $exerciseDays)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrainingBlock'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('archivedAt', archivedAt))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseDays', exerciseDays));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingBlockCopyWith<_$_TrainingBlock> get copyWith =>
      __$$_TrainingBlockCopyWithImpl<_$_TrainingBlock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrainingBlockToJson(
      this,
    );
  }
}

abstract class _TrainingBlock implements TrainingBlock {
  const factory _TrainingBlock(
      {@JsonKey(includeToJson: false)
          required final String id,
      @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson)
          final Timestamp? archivedAt,
      required final String name,
      final List<ExerciseDay> exerciseDays}) = _$_TrainingBlock;

  factory _TrainingBlock.fromJson(Map<String, dynamic> json) =
      _$_TrainingBlock.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson)
  Timestamp? get archivedAt;
  @override
  String get name;
  @override
  List<ExerciseDay> get exerciseDays;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingBlockCopyWith<_$_TrainingBlock> get copyWith =>
      throw _privateConstructorUsedError;
}
