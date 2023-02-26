// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseClient _$$_ExerciseClientFromJson(Map<String, dynamic> json) =>
    _$_ExerciseClient(
      id: json['id'] as String,
      exerciseDayId: json['exerciseDayId'] as String,
      isFiller: json['isFiller'] as bool? ?? false,
      placement: json['placement'] as int? ?? -1,
      exerciseSets: (json['exerciseSets'] as List<dynamic>?)
              ?.map(
                  (e) => ExerciseSetClient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ExerciseClientToJson(_$_ExerciseClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseDayId': instance.exerciseDayId,
      'isFiller': instance.isFiller,
      'placement': instance.placement,
      'exerciseSets': instance.exerciseSets,
    };
