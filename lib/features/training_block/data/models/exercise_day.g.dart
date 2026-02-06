// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseDayImpl _$$ExerciseDayImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseDayImpl(
      pseudoId: json['pseudoId'] as String,
      name: json['name'] as String,
      weekDay: (json['weekDay'] as num?)?.toInt(),
      archivedAt: timestampFromJson((json['archivedAt'] as num?)?.toInt()),
      exerciseTypesOrdering:
          (json['exerciseTypesOrdering'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
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
