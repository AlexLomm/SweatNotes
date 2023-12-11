// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimerSettingsStateImpl _$$TimerSettingsStateImplFromJson(
        Map<String, dynamic> json) =>
    _$TimerSettingsStateImpl(
      initialSeconds: json['initialSeconds'] as int? ?? 60,
      isMuted: json['isMuted'] as bool? ?? false,
    );

Map<String, dynamic> _$$TimerSettingsStateImplToJson(
        _$TimerSettingsStateImpl instance) =>
    <String, dynamic>{
      'initialSeconds': instance.initialSeconds,
      'isMuted': instance.isMuted,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerSettingsHash() => r'9ebcd80395fa36dc97a8e96309cc6e2e4e8bd60f';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
