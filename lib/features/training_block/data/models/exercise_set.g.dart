// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseSet _$$_ExerciseSetFromJson(Map<String, dynamic> json) =>
    _$_ExerciseSet(
      load: (json['load'] as num?)?.toDouble() ?? 0.0,
      reps: json['reps'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ExerciseSetToJson(_$_ExerciseSet instance) =>
    <String, dynamic>{
      'load': instance.load,
      'reps': instance.reps,
    };
