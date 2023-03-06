// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseDay _$$_ExerciseDayFromJson(Map<String, dynamic> json) =>
    _$_ExerciseDay(
      id: json['id'] as String,
      exerciseTypesOrdering:
          (json['exerciseTypesOrdering'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as int),
              ) ??
              const {},
      userId: json['userId'] as String,
      trainingBlockId: json['trainingBlockId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ExerciseDayToJson(_$_ExerciseDay instance) =>
    <String, dynamic>{
      'exerciseTypesOrdering': instance.exerciseTypesOrdering,
      'userId': instance.userId,
      'trainingBlockId': instance.trainingBlockId,
      'name': instance.name,
    };
