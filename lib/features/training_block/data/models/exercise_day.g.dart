// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseDay _$$_ExerciseDayFromJson(Map<String, dynamic> json) =>
    _$_ExerciseDay(
      pseudoId: json['pseudoId'] as String,
      name: json['name'] as String,
      archivedAt: timestampFromJson(json['archivedAt'] as int?),
      exerciseTypesOrdering:
          (json['exerciseTypesOrdering'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as int),
              ) ??
              const {},
    );

Map<String, dynamic> _$$_ExerciseDayToJson(_$_ExerciseDay instance) =>
    <String, dynamic>{
      'pseudoId': instance.pseudoId,
      'name': instance.name,
      'archivedAt': timestampToJson(instance.archivedAt),
      'exerciseTypesOrdering': instance.exerciseTypesOrdering,
    };
