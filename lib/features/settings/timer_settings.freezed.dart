// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimerSettingsState _$TimerSettingsStateFromJson(Map<String, dynamic> json) {
  return _TimerSettingsState.fromJson(json);
}

/// @nodoc
mixin _$TimerSettingsState {
  int get initialSeconds => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerSettingsStateCopyWith<TimerSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerSettingsStateCopyWith<$Res> {
  factory $TimerSettingsStateCopyWith(
          TimerSettingsState value, $Res Function(TimerSettingsState) then) =
      _$TimerSettingsStateCopyWithImpl<$Res, TimerSettingsState>;
  @useResult
  $Res call({int initialSeconds, bool isMuted});
}

/// @nodoc
class _$TimerSettingsStateCopyWithImpl<$Res, $Val extends TimerSettingsState>
    implements $TimerSettingsStateCopyWith<$Res> {
  _$TimerSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialSeconds = null,
    Object? isMuted = null,
  }) {
    return _then(_value.copyWith(
      initialSeconds: null == initialSeconds
          ? _value.initialSeconds
          : initialSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerSettingsStateImplCopyWith<$Res>
    implements $TimerSettingsStateCopyWith<$Res> {
  factory _$$TimerSettingsStateImplCopyWith(_$TimerSettingsStateImpl value,
          $Res Function(_$TimerSettingsStateImpl) then) =
      __$$TimerSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int initialSeconds, bool isMuted});
}

/// @nodoc
class __$$TimerSettingsStateImplCopyWithImpl<$Res>
    extends _$TimerSettingsStateCopyWithImpl<$Res, _$TimerSettingsStateImpl>
    implements _$$TimerSettingsStateImplCopyWith<$Res> {
  __$$TimerSettingsStateImplCopyWithImpl(_$TimerSettingsStateImpl _value,
      $Res Function(_$TimerSettingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialSeconds = null,
    Object? isMuted = null,
  }) {
    return _then(_$TimerSettingsStateImpl(
      initialSeconds: null == initialSeconds
          ? _value.initialSeconds
          : initialSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimerSettingsStateImpl
    with DiagnosticableTreeMixin
    implements _TimerSettingsState {
  _$TimerSettingsStateImpl({this.initialSeconds = 60, this.isMuted = false});

  factory _$TimerSettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimerSettingsStateImplFromJson(json);

  @override
  @JsonKey()
  final int initialSeconds;
  @override
  @JsonKey()
  final bool isMuted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimerSettingsState(initialSeconds: $initialSeconds, isMuted: $isMuted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimerSettingsState'))
      ..add(DiagnosticsProperty('initialSeconds', initialSeconds))
      ..add(DiagnosticsProperty('isMuted', isMuted));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerSettingsStateImpl &&
            (identical(other.initialSeconds, initialSeconds) ||
                other.initialSeconds == initialSeconds) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, initialSeconds, isMuted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerSettingsStateImplCopyWith<_$TimerSettingsStateImpl> get copyWith =>
      __$$TimerSettingsStateImplCopyWithImpl<_$TimerSettingsStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimerSettingsStateImplToJson(
      this,
    );
  }
}

abstract class _TimerSettingsState implements TimerSettingsState {
  factory _TimerSettingsState({final int initialSeconds, final bool isMuted}) =
      _$TimerSettingsStateImpl;

  factory _TimerSettingsState.fromJson(Map<String, dynamic> json) =
      _$TimerSettingsStateImpl.fromJson;

  @override
  int get initialSeconds;
  @override
  bool get isMuted;
  @override
  @JsonKey(ignore: true)
  _$$TimerSettingsStateImplCopyWith<_$TimerSettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
