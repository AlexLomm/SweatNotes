// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_type_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseTypeClient _$$_ExerciseTypeClientFromJson(
        Map<String, dynamic> json) =>
    _$_ExerciseTypeClient(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => ExerciseClient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ExerciseTypeClientToJson(
        _$_ExerciseTypeClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
      'exercises': instance.exercises,
    };
