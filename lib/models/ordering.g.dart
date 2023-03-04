// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ordering _$$_OrderingFromJson(Map<String, dynamic> json) => _$_Ordering(
      id: json['id'] as String,
      userId: json['userId'] as String,
      ordering: (json['ordering'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_OrderingToJson(_$_Ordering instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'ordering': instance.ordering,
    };
