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
      placement: json['placement'] as int? ?? -1,
      sets: (json['sets'] as List<dynamic>?)
              ?.map((e) => ExerciseSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ExerciseToJson(_$_Exercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'exerciseDayId': instance.exerciseDayId,
      'exerciseTypeId': instance.exerciseTypeId,
      'placement': instance.placement,
      'sets': instance.sets,
    };
