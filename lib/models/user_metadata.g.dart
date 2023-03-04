// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserMetadata _$$_UserMetadataFromJson(Map<String, dynamic> json) =>
    _$_UserMetadata(
      id: json['id'] as String,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
    );

Map<String, dynamic> _$$_UserMetadataToJson(_$_UserMetadata instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
