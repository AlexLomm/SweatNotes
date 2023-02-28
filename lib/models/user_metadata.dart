import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_metadata.freezed.dart';

part 'user_metadata.g.dart';

@freezed
class UserMetadata with _$UserMetadata {
  const factory UserMetadata({
    /// id of the auth user that this metadata belongs to
    required String id,
    @Default('') String firstName,
    @Default('') String lastName,
  }) = _UserMetadata;

  factory UserMetadata.fromJson(Map<String, Object?> json) =>
      _$UserMetadataFromJson(json);
}