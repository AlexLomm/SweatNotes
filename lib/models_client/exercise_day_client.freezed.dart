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

ExerciseDayClient _$ExerciseDayClientFromJson(Map<String, dynamic> json) {
  return _ExerciseDayClient.fromJson(json);
}

/// @nodoc
mixin _$ExerciseDayClient {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ExerciseTypeClient> get exerciseTypes =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
  $Res call({String id, String name, List<ExerciseTypeClient> exerciseTypes});
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
    Object? id = null,
    Object? name = null,
    Object? exerciseTypes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
}

/// @nodoc
abstract class _$$_ExerciseDayClientCopyWith<$Res>
    implements $ExerciseDayClientCopyWith<$Res> {
  factory _$$_ExerciseDayClientCopyWith(_$_ExerciseDayClient value,
          $Res Function(_$_ExerciseDayClient) then) =
      __$$_ExerciseDayClientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, List<ExerciseTypeClient> exerciseTypes});
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
    Object? id = null,
    Object? name = null,
    Object? exerciseTypes = null,
  }) {
    return _then(_$_ExerciseDayClient(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
@JsonSerializable()
class _$_ExerciseDayClient
    with DiagnosticableTreeMixin
    implements _ExerciseDayClient {
  const _$_ExerciseDayClient(
      {required this.id,
      required this.name,
      final List<ExerciseTypeClient> exerciseTypes = const []})
      : _exerciseTypes = exerciseTypes;

  factory _$_ExerciseDayClient.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseDayClientFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<ExerciseTypeClient> _exerciseTypes;
  @override
  @JsonKey()
  List<ExerciseTypeClient> get exerciseTypes {
    if (_exerciseTypes is EqualUnmodifiableListView) return _exerciseTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseTypes);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseDayClient(id: $id, name: $name, exerciseTypes: $exerciseTypes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseDayClient'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseTypes', exerciseTypes));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExerciseDayClient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._exerciseTypes, _exerciseTypes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_exerciseTypes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseDayClientCopyWith<_$_ExerciseDayClient> get copyWith =>
      __$$_ExerciseDayClientCopyWithImpl<_$_ExerciseDayClient>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseDayClientToJson(
      this,
    );
  }
}

abstract class _ExerciseDayClient implements ExerciseDayClient {
  const factory _ExerciseDayClient(
      {required final String id,
      required final String name,
      final List<ExerciseTypeClient> exerciseTypes}) = _$_ExerciseDayClient;

  factory _ExerciseDayClient.fromJson(Map<String, dynamic> json) =
      _$_ExerciseDayClient.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<ExerciseTypeClient> get exerciseTypes;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseDayClientCopyWith<_$_ExerciseDayClient> get copyWith =>
      throw _privateConstructorUsedError;
}
