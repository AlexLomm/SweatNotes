// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrainingBlock _$$_TrainingBlockFromJson(Map<String, dynamic> json) =>
    _$_TrainingBlock(
      id: json['id'] as String,
      archivedAt: timestampFromJson(json['archivedAt'] as int?),
      startedAt: timestampFromJson(json['startedAt'] as int?),
      exerciseDaysOrdering:
          (json['exerciseDaysOrdering'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as int),
              ) ??
              const {},
      name: json['name'] as String,
      exerciseDays: (json['exerciseDays'] as List<dynamic>?)
              ?.map((e) => ExerciseDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TrainingBlockToJson(_$_TrainingBlock instance) =>
    <String, dynamic>{
      'archivedAt': timestampToJson(instance.archivedAt),
      'startedAt': timestampToJson(instance.startedAt),
      'exerciseDaysOrdering': instance.exerciseDaysOrdering,
      'name': instance.name,
      'exerciseDays': instance.exerciseDays.map((e) => e.toJson()).toList(),
    };
