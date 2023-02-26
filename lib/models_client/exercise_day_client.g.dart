// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_day_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseDayClient _$$_ExerciseDayClientFromJson(Map<String, dynamic> json) =>
    _$_ExerciseDayClient(
      id: json['id'] as String,
      name: json['name'] as String,
      exerciseTypes: (json['exerciseTypes'] as List<dynamic>?)
              ?.map(
                  (e) => ExerciseTypeClient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ExerciseDayClientToJson(
        _$_ExerciseDayClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exerciseTypes': instance.exerciseTypes,
    };
