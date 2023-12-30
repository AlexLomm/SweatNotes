// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TutorialSettingsStateImpl _$$TutorialSettingsStateImplFromJson(
        Map<String, dynamic> json) =>
    _$TutorialSettingsStateImpl(
      isCreateTrainingBlockSeen:
          json['isCreateTrainingBlockSeen'] as bool? ?? false,
      isSeeArchivedTrainingBlocksSeen:
          json['isSeeArchivedTrainingBlocksSeen'] as bool? ?? false,
      isSettingsSeen: json['isSettingsSeen'] as bool? ?? false,
      isTrainingBlockListSeen:
          json['isTrainingBlockListSeen'] as bool? ?? false,
      isCreateExerciseDaySeen:
          json['isCreateExerciseDaySeen'] as bool? ?? false,
      isEditModeSeen: json['isEditModeSeen'] as bool? ?? false,
      isMoreOptionsMenuSeen: json['isMoreOptionsMenuSeen'] as bool? ?? false,
      isExerciseDaySeen: json['isExerciseDaySeen'] as bool? ?? false,
      isCreateExerciseTypeSeen:
          json['isCreateExerciseTypeSeen'] as bool? ?? false,
      isExerciseTypeSeen: json['isExerciseTypeSeen'] as bool? ?? false,
    );

Map<String, dynamic> _$$TutorialSettingsStateImplToJson(
        _$TutorialSettingsStateImpl instance) =>
    <String, dynamic>{
      'isCreateTrainingBlockSeen': instance.isCreateTrainingBlockSeen,
      'isSeeArchivedTrainingBlocksSeen':
          instance.isSeeArchivedTrainingBlocksSeen,
      'isSettingsSeen': instance.isSettingsSeen,
      'isTrainingBlockListSeen': instance.isTrainingBlockListSeen,
      'isCreateExerciseDaySeen': instance.isCreateExerciseDaySeen,
      'isEditModeSeen': instance.isEditModeSeen,
      'isMoreOptionsMenuSeen': instance.isMoreOptionsMenuSeen,
      'isExerciseDaySeen': instance.isExerciseDaySeen,
      'isCreateExerciseTypeSeen': instance.isCreateExerciseTypeSeen,
      'isExerciseTypeSeen': instance.isExerciseTypeSeen,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tutorialSettingsHash() => r'd25edfc333321d2f2480cfe4e4e0b73e0f427486';

/// See also [TutorialSettings].
@ProviderFor(TutorialSettings)
final tutorialSettingsProvider = AutoDisposeNotifierProvider<TutorialSettings,
    TutorialSettingsState>.internal(
  TutorialSettings.new,
  name: r'tutorialSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tutorialSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TutorialSettings = AutoDisposeNotifier<TutorialSettingsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
