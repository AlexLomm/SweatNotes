// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseDayImpl _$$ExerciseDayImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseDayImpl(
      pseudoId: json['pseudoId'] as String,
      name: json['name'] as String,
      weekDay: json['weekDay'] as int?,
      archivedAt: timestampFromJson(json['archivedAt'] as int?),
      exerciseTypesOrdering:
          (json['exerciseTypesOrdering'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as int),
              ) ??
              const {},
    );

Map<String, dynamic> _$$ExerciseDayImplToJson(_$ExerciseDayImpl instance) =>
    <String, dynamic>{
      'pseudoId': instance.pseudoId,
      'name': instance.name,
      'weekDay': instance.weekDay,
      'archivedAt': timestampToJson(instance.archivedAt),
      'exerciseTypesOrdering': instance.exerciseTypesOrdering,
    };
