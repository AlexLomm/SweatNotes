// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExerciseDay _$$_ExerciseDayFromJson(Map<String, dynamic> json) =>
    _$_ExerciseDay(
      name: json['name'] as String,
      exerciseTypesOrdering:
          (json['exerciseTypesOrdering'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as int),
              ) ??
              const {},
    );

Map<String, dynamic> _$$_ExerciseDayToJson(_$_ExerciseDay instance) =>
    <String, dynamic>{
      'name': instance.name,
      'exerciseTypesOrdering': instance.exerciseTypesOrdering,
    };
