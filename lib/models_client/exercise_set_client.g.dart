// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseSetClient _$$_ExerciseSetClientFromJson(Map<String, dynamic> json) =>
    _$_ExerciseSetClient(
      isFiller: json['isFiller'] as bool? ?? false,
      progressFactor: json['progressFactor'] as int? ?? 0,
      reps: json['reps'] as String,
      load: json['load'] as String,
    );

Map<String, dynamic> _$$_ExerciseSetClientToJson(
        _$_ExerciseSetClient instance) =>
    <String, dynamic>{
      'isFiller': instance.isFiller,
      'progressFactor': instance.progressFactor,
      'reps': instance.reps,
      'load': instance.load,
    };
