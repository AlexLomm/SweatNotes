// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrainingBlock _$$_TrainingBlockFromJson(Map<String, dynamic> json) =>
    _$_TrainingBlock(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      exerciseDaysOrdering:
          (json['exerciseDaysOrdering'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as int),
              ) ??
              const {},
    );

Map<String, dynamic> _$$_TrainingBlockToJson(_$_TrainingBlock instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'exerciseDaysOrdering': instance.exerciseDaysOrdering,
    };
