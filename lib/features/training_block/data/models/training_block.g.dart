// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrainingBlock _$$_TrainingBlockFromJson(Map<String, dynamic> json) =>
    _$_TrainingBlock(
      id: json['id'] as String,
      archivedAt: _archivedAtFromJson(json['archivedAt'] as int?),
      name: json['name'] as String,
      exerciseDays: (json['exerciseDays'] as List<dynamic>?)
              ?.map((e) => ExerciseDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TrainingBlockToJson(_$_TrainingBlock instance) =>
    <String, dynamic>{
      'archivedAt': _archivedAtToJson(instance.archivedAt),
      'name': instance.name,
      'exerciseDays': instance.exerciseDays.map((e) => e.toJson()).toList(),
    };
