// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ordering.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ordering _$OrderingFromJson(Map<String, dynamic> json) {
  return _Ordering.fromJson(json);
}

/// @nodoc
mixin _$Ordering {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  Map<String, int> get ordering => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderingCopyWith<Ordering> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderingCopyWith<$Res> {
  factory $OrderingCopyWith(Ordering value, $Res Function(Ordering) then) =
      _$OrderingCopyWithImpl<$Res, Ordering>;
  @useResult
  $Res call({String id, String userId, Map<String, int> ordering});
}

/// @nodoc
class _$OrderingCopyWithImpl<$Res, $Val extends Ordering>
    implements $OrderingCopyWith<$Res> {
  _$OrderingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? ordering = null,
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
      ordering: null == ordering
          ? _value.ordering
          : ordering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderingCopyWith<$Res> implements $OrderingCopyWith<$Res> {
  factory _$$_OrderingCopyWith(
          _$_Ordering value, $Res Function(_$_Ordering) then) =
      __$$_OrderingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userId, Map<String, int> ordering});
}

/// @nodoc
class __$$_OrderingCopyWithImpl<$Res>
    extends _$OrderingCopyWithImpl<$Res, _$_Ordering>
    implements _$$_OrderingCopyWith<$Res> {
  __$$_OrderingCopyWithImpl(
      _$_Ordering _value, $Res Function(_$_Ordering) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? ordering = null,
  }) {
    return _then(_$_Ordering(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      ordering: null == ordering
          ? _value._ordering
          : ordering // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ordering with DiagnosticableTreeMixin implements _Ordering {
  const _$_Ordering(
      {required this.id,
      required this.userId,
      final Map<String, int> ordering = const {}})
      : _ordering = ordering;

  factory _$_Ordering.fromJson(Map<String, dynamic> json) =>
      _$$_OrderingFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  final Map<String, int> _ordering;
  @override
  @JsonKey()
  Map<String, int> get ordering {
    if (_ordering is EqualUnmodifiableMapView) return _ordering;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ordering);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Ordering(id: $id, userId: $userId, ordering: $ordering)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Ordering'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('ordering', ordering));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ordering &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._ordering, _ordering));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, const DeepCollectionEquality().hash(_ordering));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderingCopyWith<_$_Ordering> get copyWith =>
      __$$_OrderingCopyWithImpl<_$_Ordering>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderingToJson(
      this,
    );
  }
}

abstract class _Ordering implements Ordering {
  const factory _Ordering(
      {required final String id,
      required final String userId,
      final Map<String, int> ordering}) = _$_Ordering;

  factory _Ordering.fromJson(Map<String, dynamic> json) = _$_Ordering.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  Map<String, int> get ordering;
  @override
  @JsonKey(ignore: true)
  _$$_OrderingCopyWith<_$_Ordering> get copyWith =>
      throw _privateConstructorUsedError;
}
