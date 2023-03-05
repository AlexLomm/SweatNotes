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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Map<String, int> get exerciseTypesOrdering =>
      throw _privateConstructorUsedError;
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
      {String id,
      String name,
      Map<String, int> exerciseTypesOrdering,
      List<ExerciseTypeClient> exerciseTypes});
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
    Object? exerciseTypesOrdering = null,
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
      exerciseTypesOrdering: null == exerciseTypesOrdering
          ? _value.exerciseTypesOrdering
          : exerciseTypesOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
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
  $Res call(
      {String id,
      String name,
      Map<String, int> exerciseTypesOrdering,
      List<ExerciseTypeClient> exerciseTypes});
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
    Object? exerciseTypesOrdering = null,
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
      exerciseTypesOrdering: null == exerciseTypesOrdering
          ? _value._exerciseTypesOrdering
          : exerciseTypesOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      exerciseTypes: null == exerciseTypes
          ? _value._exerciseTypes
          : exerciseTypes // ignore: cast_nullable_to_non_nullable
              as List<ExerciseTypeClient>,
    ));
  }
}

/// @nodoc

class _$_ExerciseDayClient
    with DiagnosticableTreeMixin
    implements _ExerciseDayClient {
  const _$_ExerciseDayClient(
      {required this.id,
      required this.name,
      required final Map<String, int> exerciseTypesOrdering,
      required final List<ExerciseTypeClient> exerciseTypes})
      : _exerciseTypesOrdering = exerciseTypesOrdering,
        _exerciseTypes = exerciseTypes;

  @override
  final String id;
  @override
  final String name;
  final Map<String, int> _exerciseTypesOrdering;
  @override
  Map<String, int> get exerciseTypesOrdering {
    if (_exerciseTypesOrdering is EqualUnmodifiableMapView)
      return _exerciseTypesOrdering;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exerciseTypesOrdering);
  }

  final List<ExerciseTypeClient> _exerciseTypes;
  @override
  List<ExerciseTypeClient> get exerciseTypes {
    if (_exerciseTypes is EqualUnmodifiableListView) return _exerciseTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseTypes);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseDayClient(id: $id, name: $name, exerciseTypesOrdering: $exerciseTypesOrdering, exerciseTypes: $exerciseTypes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseDayClient'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('exerciseTypesOrdering', exerciseTypesOrdering))
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
                .equals(other._exerciseTypesOrdering, _exerciseTypesOrdering) &&
            const DeepCollectionEquality()
                .equals(other._exerciseTypes, _exerciseTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_exerciseTypesOrdering),
      const DeepCollectionEquality().hash(_exerciseTypes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseDayClientCopyWith<_$_ExerciseDayClient> get copyWith =>
      __$$_ExerciseDayClientCopyWithImpl<_$_ExerciseDayClient>(
          this, _$identity);
}

abstract class _ExerciseDayClient implements ExerciseDayClient {
  const factory _ExerciseDayClient(
          {required final String id,
          required final String name,
          required final Map<String, int> exerciseTypesOrdering,
          required final List<ExerciseTypeClient> exerciseTypes}) =
      _$_ExerciseDayClient;

  @override
  String get id;
  @override
  String get name;
  @override
  Map<String, int> get exerciseTypesOrdering;
  @override
  List<ExerciseTypeClient> get exerciseTypes;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseDayClientCopyWith<_$_ExerciseDayClient> get copyWith =>
      throw _privateConstructorUsedError;
}
