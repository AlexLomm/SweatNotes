// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimerSettingsState _$$_TimerSettingsStateFromJson(
        Map<String, dynamic> json) =>
    _$_TimerSettingsState(
      initialSeconds: json['initialSeconds'] as int? ?? 60,
      isMuted: json['isMuted'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TimerSettingsStateToJson(
        _$_TimerSettingsState instance) =>
    <String, dynamic>{
      'initialSeconds': instance.initialSeconds,
      'isMuted': instance.isMuted,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerSettingsHash() => r'17b8f8d1cef4d5f4be27da1f6f8c68d0f9c5b6dd';

/// See also [TimerSettings].
@ProviderFor(TimerSettings)
final timerSettingsProvider =
    AutoDisposeNotifierProvider<TimerSettings, TimerSettingsState>.internal(
  TimerSettings.new,
  name: r'timerSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timerSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimerSettings = AutoDisposeNotifier<TimerSettingsState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
