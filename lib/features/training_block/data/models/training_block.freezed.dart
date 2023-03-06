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
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, int> get exerciseDaysOrdering =>
      throw _privateConstructorUsedError;

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
      {@JsonKey(includeToJson: false) String id,
      String userId,
      String name,
      Map<String, int> exerciseDaysOrdering});
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
    Object? userId = null,
    Object? name = null,
    Object? exerciseDaysOrdering = null,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDaysOrdering: null == exerciseDaysOrdering
          ? _value.exerciseDaysOrdering
          : exerciseDaysOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
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
      {@JsonKey(includeToJson: false) String id,
      String userId,
      String name,
      Map<String, int> exerciseDaysOrdering});
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
    Object? userId = null,
    Object? name = null,
    Object? exerciseDaysOrdering = null,
  }) {
    return _then(_$_TrainingBlock(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDaysOrdering: null == exerciseDaysOrdering
          ? _value._exerciseDaysOrdering
          : exerciseDaysOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TrainingBlock with DiagnosticableTreeMixin implements _TrainingBlock {
  const _$_TrainingBlock(
      {@JsonKey(includeToJson: false) required this.id,
      required this.userId,
      required this.name,
      final Map<String, int> exerciseDaysOrdering = const {}})
      : _exerciseDaysOrdering = exerciseDaysOrdering;

  factory _$_TrainingBlock.fromJson(Map<String, dynamic> json) =>
      _$$_TrainingBlockFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  final String userId;
  @override
  final String name;
  final Map<String, int> _exerciseDaysOrdering;
  @override
  @JsonKey()
  Map<String, int> get exerciseDaysOrdering {
    if (_exerciseDaysOrdering is EqualUnmodifiableMapView)
      return _exerciseDaysOrdering;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exerciseDaysOrdering);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrainingBlock(id: $id, userId: $userId, name: $name, exerciseDaysOrdering: $exerciseDaysOrdering)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrainingBlock'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseDaysOrdering', exerciseDaysOrdering));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingBlock &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._exerciseDaysOrdering, _exerciseDaysOrdering));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name,
      const DeepCollectionEquality().hash(_exerciseDaysOrdering));

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
      {@JsonKey(includeToJson: false) required final String id,
      required final String userId,
      required final String name,
      final Map<String, int> exerciseDaysOrdering}) = _$_TrainingBlock;

  factory _TrainingBlock.fromJson(Map<String, dynamic> json) =
      _$_TrainingBlock.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  Map<String, int> get exerciseDaysOrdering;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingBlockCopyWith<_$_TrainingBlock> get copyWith =>
      throw _privateConstructorUsedError;
}
