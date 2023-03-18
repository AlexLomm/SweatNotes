// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseType _$$_ExerciseTypeFromJson(Map<String, dynamic> json) =>
    _$_ExerciseType(
      id: json['id'] as String,
      archivedAt: timestampFromJson(json['archivedAt'] as int?),
      trainingBlockId: json['trainingBlockId'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ExerciseTypeToJson(_$_ExerciseType instance) =>
    <String, dynamic>{
      'archivedAt': timestampToJson(instance.archivedAt),
      'trainingBlockId': instance.trainingBlockId,
      'name': instance.name,
      'unit': instance.unit,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
