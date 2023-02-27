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

ExerciseClient _$ExerciseClientFromJson(Map<String, dynamic> json) {
  return _ExerciseClient.fromJson(json);
}

/// @nodoc
mixin _$ExerciseClient {
  String get id => throw _privateConstructorUsedError;
  String get exerciseDayId => throw _privateConstructorUsedError;
  bool get isFiller => throw _privateConstructorUsedError;
  int get placement => throw _privateConstructorUsedError;
  List<ExerciseSetClient> get exerciseSets =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {String id,
      String exerciseDayId,
      bool isFiller,
      int placement,
      List<ExerciseSetClient> exerciseSets});
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
    Object? id = null,
    Object? exerciseDayId = null,
    Object? isFiller = null,
    Object? placement = null,
    Object? exerciseSets = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDayId: null == exerciseDayId
          ? _value.exerciseDayId
          : exerciseDayId // ignore: cast_nullable_to_non_nullable
              as String,
      isFiller: null == isFiller
          ? _value.isFiller
          : isFiller // ignore: cast_nullable_to_non_nullable
              as bool,
      placement: null == placement
          ? _value.placement
          : placement // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseSets: null == exerciseSets
          ? _value.exerciseSets
          : exerciseSets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSetClient>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExerciseClientCopyWith<$Res>
    implements $ExerciseClientCopyWith<$Res> {
  factory _$$_ExerciseClientCopyWith(
          _$_ExerciseClient value, $Res Function(_$_ExerciseClient) then) =
      __$$_ExerciseClientCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String exerciseDayId,
      bool isFiller,
      int placement,
      List<ExerciseSetClient> exerciseSets});
}

/// @nodoc
class __$$_ExerciseClientCopyWithImpl<$Res>
    extends _$ExerciseClientCopyWithImpl<$Res, _$_ExerciseClient>
    implements _$$_ExerciseClientCopyWith<$Res> {
  __$$_ExerciseClientCopyWithImpl(
      _$_ExerciseClient _value, $Res Function(_$_ExerciseClient) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseDayId = null,
    Object? isFiller = null,
    Object? placement = null,
    Object? exerciseSets = null,
  }) {
    return _then(_$_ExerciseClient(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseDayId: null == exerciseDayId
          ? _value.exerciseDayId
          : exerciseDayId // ignore: cast_nullable_to_non_nullable
              as String,
      isFiller: null == isFiller
          ? _value.isFiller
          : isFiller // ignore: cast_nullable_to_non_nullable
              as bool,
      placement: null == placement
          ? _value.placement
          : placement // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseSets: null == exerciseSets
          ? _value._exerciseSets
          : exerciseSets // ignore: cast_nullable_to_non_nullable
              as List<ExerciseSetClient>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExerciseClient extends _ExerciseClient with DiagnosticableTreeMixin {
  const _$_ExerciseClient(
      {required this.id,
      required this.exerciseDayId,
      this.isFiller = false,
      this.placement = -1,
      final List<ExerciseSetClient> exerciseSets = const []})
      : _exerciseSets = exerciseSets,
        super._();

  factory _$_ExerciseClient.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseClientFromJson(json);

  @override
  final String id;
  @override
  final String exerciseDayId;
  @override
  @JsonKey()
  final bool isFiller;
  @override
  @JsonKey()
  final int placement;
  final List<ExerciseSetClient> _exerciseSets;
  @override
  @JsonKey()
  List<ExerciseSetClient> get exerciseSets {
    if (_exerciseSets is EqualUnmodifiableListView) return _exerciseSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseSets);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseClient(id: $id, exerciseDayId: $exerciseDayId, isFiller: $isFiller, placement: $placement, exerciseSets: $exerciseSets)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseClient'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('exerciseDayId', exerciseDayId))
      ..add(DiagnosticsProperty('isFiller', isFiller))
      ..add(DiagnosticsProperty('placement', placement))
      ..add(DiagnosticsProperty('exerciseSets', exerciseSets));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExerciseClient &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseDayId, exerciseDayId) ||
                other.exerciseDayId == exerciseDayId) &&
            (identical(other.isFiller, isFiller) ||
                other.isFiller == isFiller) &&
            (identical(other.placement, placement) ||
                other.placement == placement) &&
            const DeepCollectionEquality()
                .equals(other._exerciseSets, _exerciseSets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, exerciseDayId, isFiller,
      placement, const DeepCollectionEquality().hash(_exerciseSets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseClientCopyWith<_$_ExerciseClient> get copyWith =>
      __$$_ExerciseClientCopyWithImpl<_$_ExerciseClient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseClientToJson(
      this,
    );
  }
}

abstract class _ExerciseClient extends ExerciseClient {
  const factory _ExerciseClient(
      {required final String id,
      required final String exerciseDayId,
      final bool isFiller,
      final int placement,
      final List<ExerciseSetClient> exerciseSets}) = _$_ExerciseClient;
  const _ExerciseClient._() : super._();

  factory _ExerciseClient.fromJson(Map<String, dynamic> json) =
      _$_ExerciseClient.fromJson;

  @override
  String get id;
  @override
  String get exerciseDayId;
  @override
  bool get isFiller;
  @override
  int get placement;
  @override
  List<ExerciseSetClient> get exerciseSets;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseClientCopyWith<_$_ExerciseClient> get copyWith =>
      throw _privateConstructorUsedError;
}
