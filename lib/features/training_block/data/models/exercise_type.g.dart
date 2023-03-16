// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseType _$$_ExerciseTypeFromJson(Map<String, dynamic> json) =>
    _$_ExerciseType(
      id: json['id'] as String,
      trainingBlockId: json['trainingBlockId'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      exercises: json['exercises'] == null
          ? const []
          : _exercisesFromJson(json['exercises'] as List),
    );

Map<String, dynamic> _$$_ExerciseTypeToJson(_$_ExerciseType instance) =>
    <String, dynamic>{
      'trainingBlockId': instance.trainingBlockId,
      'name': instance.name,
      'unit': instance.unit,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
