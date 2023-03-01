// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wheel_selector_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WheelSelectorValue<T> {
  String get label => throw _privateConstructorUsedError;
  T get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WheelSelectorValueCopyWith<T, WheelSelectorValue<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WheelSelectorValueCopyWith<T, $Res> {
  factory $WheelSelectorValueCopyWith(WheelSelectorValue<T> value,
          $Res Function(WheelSelectorValue<T>) then) =
      _$WheelSelectorValueCopyWithImpl<T, $Res, WheelSelectorValue<T>>;
  @useResult
  $Res call({String label, T value});
}

/// @nodoc
class _$WheelSelectorValueCopyWithImpl<T, $Res,
        $Val extends WheelSelectorValue<T>>
    implements $WheelSelectorValueCopyWith<T, $Res> {
  _$WheelSelectorValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WheelSelectorValueCopyWith<T, $Res>
    implements $WheelSelectorValueCopyWith<T, $Res> {
  factory _$$_WheelSelectorValueCopyWith(_$_WheelSelectorValue<T> value,
          $Res Function(_$_WheelSelectorValue<T>) then) =
      __$$_WheelSelectorValueCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String label, T value});
}

/// @nodoc
class __$$_WheelSelectorValueCopyWithImpl<T, $Res>
    extends _$WheelSelectorValueCopyWithImpl<T, $Res, _$_WheelSelectorValue<T>>
    implements _$$_WheelSelectorValueCopyWith<T, $Res> {
  __$$_WheelSelectorValueCopyWithImpl(_$_WheelSelectorValue<T> _value,
      $Res Function(_$_WheelSelectorValue<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = freezed,
  }) {
    return _then(_$_WheelSelectorValue<T>(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_WheelSelectorValue<T>
    with DiagnosticableTreeMixin
    implements _WheelSelectorValue<T> {
  const _$_WheelSelectorValue({required this.label, required this.value});

  @override
  final String label;
  @override
  final T value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WheelSelectorValue<$T>(label: $label, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WheelSelectorValue<$T>'))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WheelSelectorValue<T> &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, label, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WheelSelectorValueCopyWith<T, _$_WheelSelectorValue<T>> get copyWith =>
      __$$_WheelSelectorValueCopyWithImpl<T, _$_WheelSelectorValue<T>>(
          this, _$identity);
}

abstract class _WheelSelectorValue<T> implements WheelSelectorValue<T> {
  const factory _WheelSelectorValue(
      {required final String label,
      required final T value}) = _$_WheelSelectorValue<T>;

  @override
  String get label;
  @override
  T get value;
  @override
  @JsonKey(ignore: true)
  _$$_WheelSelectorValueCopyWith<T, _$_WheelSelectorValue<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
