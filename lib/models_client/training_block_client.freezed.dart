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
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, int> get exerciseDaysOrdering =>
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
      {@JsonKey(includeToJson: false) String id,
      String userId,
      String name,
      Map<String, int> exerciseDaysOrdering});
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
abstract class _$$_TrainingBlockClientCopyWith<$Res>
    implements $TrainingBlockClientCopyWith<$Res> {
  factory _$$_TrainingBlockClientCopyWith(_$_TrainingBlockClient value,
          $Res Function(_$_TrainingBlockClient) then) =
      __$$_TrainingBlockClientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String userId,
      String name,
      Map<String, int> exerciseDaysOrdering});
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
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? exerciseDaysOrdering = null,
  }) {
    return _then(_$_TrainingBlockClient(
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

class _$_TrainingBlockClient
    with DiagnosticableTreeMixin
    implements _TrainingBlockClient {
  const _$_TrainingBlockClient(
      {@JsonKey(includeToJson: false) required this.id,
      required this.userId,
      required this.name,
      required final Map<String, int> exerciseDaysOrdering})
      : _exerciseDaysOrdering = exerciseDaysOrdering;

  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  final String userId;
  @override
  final String name;
  final Map<String, int> _exerciseDaysOrdering;
  @override
  Map<String, int> get exerciseDaysOrdering {
    if (_exerciseDaysOrdering is EqualUnmodifiableMapView)
      return _exerciseDaysOrdering;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exerciseDaysOrdering);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TrainingBlockClient(id: $id, userId: $userId, name: $name, exerciseDaysOrdering: $exerciseDaysOrdering)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TrainingBlockClient'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseDaysOrdering', exerciseDaysOrdering));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingBlockClient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._exerciseDaysOrdering, _exerciseDaysOrdering));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name,
      const DeepCollectionEquality().hash(_exerciseDaysOrdering));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingBlockClientCopyWith<_$_TrainingBlockClient> get copyWith =>
      __$$_TrainingBlockClientCopyWithImpl<_$_TrainingBlockClient>(
          this, _$identity);
}

abstract class _TrainingBlockClient implements TrainingBlockClient {
  const factory _TrainingBlockClient(
          {@JsonKey(includeToJson: false) required final String id,
          required final String userId,
          required final String name,
          required final Map<String, int> exerciseDaysOrdering}) =
      _$_TrainingBlockClient;

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
  _$$_TrainingBlockClientCopyWith<_$_TrainingBlockClient> get copyWith =>
      throw _privateConstructorUsedError;
}
