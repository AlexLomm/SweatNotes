// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Exercise _$$_ExerciseFromJson(Map<String, dynamic> json) => _$_Exercise(
      id: json['id'] as String,
      userId: json['userId'] as String,
      exerciseDayId: json['exerciseDayId'] as String,
      exerciseTypeId: json['exerciseTypeId'] as String,
      trainingBlockId: json['trainingBlockId'] as String,
      placement: json['placement'] as int? ?? 0,
      sets: (json['sets'] as List<dynamic>?)
              ?.map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ExerciseToJson(_$_Exercise instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'exerciseDayId': instance.exerciseDayId,
      'exerciseTypeId': instance.exerciseTypeId,
      'trainingBlockId': instance.trainingBlockId,
      'placement': instance.placement,
      'sets': instance.sets.map((e) => e.toJson()).toList(),
    };
