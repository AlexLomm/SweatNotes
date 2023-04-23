// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExerciseDay _$ExerciseDayFromJson(Map<String, dynamic> json) {
  return _ExerciseDay.fromJson(json);
}

/// @nodoc
mixin _$ExerciseDay {
  String get pseudoId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @Assert('weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)',
      'weekDay must either be `null` or a valid DateTime.<weekDay> day')
  int? get weekDay => throw _privateConstructorUsedError;
  @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
  Timestamp? get archivedAt => throw _privateConstructorUsedError;
  Map<String, int> get exerciseTypesOrdering =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseDayCopyWith<ExerciseDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseDayCopyWith<$Res> {
  factory $ExerciseDayCopyWith(
          ExerciseDay value, $Res Function(ExerciseDay) then) =
      _$ExerciseDayCopyWithImpl<$Res, ExerciseDay>;
  @useResult
  $Res call(
      {String pseudoId,
      String name,
      @Assert('weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)', 'weekDay must either be `null` or a valid DateTime.<weekDay> day')
          int? weekDay,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
          Timestamp? archivedAt,
      Map<String, int> exerciseTypesOrdering});
}

/// @nodoc
class _$ExerciseDayCopyWithImpl<$Res, $Val extends ExerciseDay>
    implements $ExerciseDayCopyWith<$Res> {
  _$ExerciseDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pseudoId = null,
    Object? name = null,
    Object? weekDay = freezed,
    Object? archivedAt = freezed,
    Object? exerciseTypesOrdering = null,
  }) {
    return _then(_value.copyWith(
      pseudoId: null == pseudoId
          ? _value.pseudoId
          : pseudoId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      weekDay: freezed == weekDay
          ? _value.weekDay
          : weekDay // ignore: cast_nullable_to_non_nullable
              as int?,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      exerciseTypesOrdering: null == exerciseTypesOrdering
          ? _value.exerciseTypesOrdering
          : exerciseTypesOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExerciseDayCopyWith<$Res>
    implements $ExerciseDayCopyWith<$Res> {
  factory _$$_ExerciseDayCopyWith(
          _$_ExerciseDay value, $Res Function(_$_ExerciseDay) then) =
      __$$_ExerciseDayCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String pseudoId,
      String name,
      @Assert('weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)', 'weekDay must either be `null` or a valid DateTime.<weekDay> day')
          int? weekDay,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
          Timestamp? archivedAt,
      Map<String, int> exerciseTypesOrdering});
}

/// @nodoc
class __$$_ExerciseDayCopyWithImpl<$Res>
    extends _$ExerciseDayCopyWithImpl<$Res, _$_ExerciseDay>
    implements _$$_ExerciseDayCopyWith<$Res> {
  __$$_ExerciseDayCopyWithImpl(
      _$_ExerciseDay _value, $Res Function(_$_ExerciseDay) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pseudoId = null,
    Object? name = null,
    Object? weekDay = freezed,
    Object? archivedAt = freezed,
    Object? exerciseTypesOrdering = null,
  }) {
    return _then(_$_ExerciseDay(
      pseudoId: null == pseudoId
          ? _value.pseudoId
          : pseudoId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      weekDay: freezed == weekDay
          ? _value.weekDay
          : weekDay // ignore: cast_nullable_to_non_nullable
              as int?,
      archivedAt: freezed == archivedAt
          ? _value.archivedAt
          : archivedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      exerciseTypesOrdering: null == exerciseTypesOrdering
          ? _value._exerciseTypesOrdering
          : exerciseTypesOrdering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExerciseDay extends _ExerciseDay with DiagnosticableTreeMixin {
  const _$_ExerciseDay(
      {required this.pseudoId,
      required this.name,
      @Assert('weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)', 'weekDay must either be `null` or a valid DateTime.<weekDay> day')
          required this.weekDay,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
          this.archivedAt,
      final Map<String, int> exerciseTypesOrdering = const {}})
      : _exerciseTypesOrdering = exerciseTypesOrdering,
        super._();

  factory _$_ExerciseDay.fromJson(Map<String, dynamic> json) =>
      _$$_ExerciseDayFromJson(json);

  @override
  final String pseudoId;
  @override
  final String name;
  @override
  @Assert('weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)',
      'weekDay must either be `null` or a valid DateTime.<weekDay> day')
  final int? weekDay;
  @override
  @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
  final Timestamp? archivedAt;
  final Map<String, int> _exerciseTypesOrdering;
  @override
  @JsonKey()
  Map<String, int> get exerciseTypesOrdering {
    if (_exerciseTypesOrdering is EqualUnmodifiableMapView)
      return _exerciseTypesOrdering;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exerciseTypesOrdering);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExerciseDay(pseudoId: $pseudoId, name: $name, weekDay: $weekDay, archivedAt: $archivedAt, exerciseTypesOrdering: $exerciseTypesOrdering)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExerciseDay'))
      ..add(DiagnosticsProperty('pseudoId', pseudoId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('weekDay', weekDay))
      ..add(DiagnosticsProperty('archivedAt', archivedAt))
      ..add(
          DiagnosticsProperty('exerciseTypesOrdering', exerciseTypesOrdering));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExerciseDayCopyWith<_$_ExerciseDay> get copyWith =>
      __$$_ExerciseDayCopyWithImpl<_$_ExerciseDay>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExerciseDayToJson(
      this,
    );
  }
}

abstract class _ExerciseDay extends ExerciseDay {
  const factory _ExerciseDay(
      {required final String pseudoId,
      required final String name,
      @Assert('weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)', 'weekDay must either be `null` or a valid DateTime.<weekDay> day')
          required final int? weekDay,
      @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
          final Timestamp? archivedAt,
      final Map<String, int> exerciseTypesOrdering}) = _$_ExerciseDay;
  const _ExerciseDay._() : super._();

  factory _ExerciseDay.fromJson(Map<String, dynamic> json) =
      _$_ExerciseDay.fromJson;

  @override
  String get pseudoId;
  @override
  String get name;
  @override
  @Assert('weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)',
      'weekDay must either be `null` or a valid DateTime.<weekDay> day')
  int? get weekDay;
  @override
  @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
  Timestamp? get archivedAt;
  @override
  Map<String, int> get exerciseTypesOrdering;
  @override
  @JsonKey(ignore: true)
  _$$_ExerciseDayCopyWith<_$_ExerciseDay> get copyWith =>
      throw _privateConstructorUsedError;
}
