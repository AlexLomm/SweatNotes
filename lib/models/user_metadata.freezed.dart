// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserMetadata _$UserMetadataFromJson(Map<String, dynamic> json) {
  return _UserMetadata.fromJson(json);
}

/// @nodoc
mixin _$UserMetadata {
  /// id of the auth user that this metadata belongs to
  @JsonKey(includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserMetadataCopyWith<UserMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMetadataCopyWith<$Res> {
  factory $UserMetadataCopyWith(
          UserMetadata value, $Res Function(UserMetadata) then) =
      _$UserMetadataCopyWithImpl<$Res, UserMetadata>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String firstName,
      String lastName});
}

/// @nodoc
class _$UserMetadataCopyWithImpl<$Res, $Val extends UserMetadata>
    implements $UserMetadataCopyWith<$Res> {
  _$UserMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserMetadataCopyWith<$Res>
    implements $UserMetadataCopyWith<$Res> {
  factory _$$_UserMetadataCopyWith(
          _$_UserMetadata value, $Res Function(_$_UserMetadata) then) =
      __$$_UserMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String id,
      String firstName,
      String lastName});
}

/// @nodoc
class __$$_UserMetadataCopyWithImpl<$Res>
    extends _$UserMetadataCopyWithImpl<$Res, _$_UserMetadata>
    implements _$$_UserMetadataCopyWith<$Res> {
  __$$_UserMetadataCopyWithImpl(
      _$_UserMetadata _value, $Res Function(_$_UserMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_$_UserMetadata(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserMetadata with DiagnosticableTreeMixin implements _UserMetadata {
  const _$_UserMetadata(
      {@JsonKey(includeToJson: false) required this.id,
      this.firstName = '',
      this.lastName = ''});

  factory _$_UserMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_UserMetadataFromJson(json);

  /// id of the auth user that this metadata belongs to
  @override
  @JsonKey(includeToJson: false)
  final String id;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserMetadata(id: $id, firstName: $firstName, lastName: $lastName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserMetadata'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserMetadata &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserMetadataCopyWith<_$_UserMetadata> get copyWith =>
      __$$_UserMetadataCopyWithImpl<_$_UserMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserMetadataToJson(
      this,
    );
  }
}

abstract class _UserMetadata implements UserMetadata {
  const factory _UserMetadata(
      {@JsonKey(includeToJson: false) required final String id,
      final String firstName,
      final String lastName}) = _$_UserMetadata;

  factory _UserMetadata.fromJson(Map<String, dynamic> json) =
      _$_UserMetadata.fromJson;

  @override

  /// id of the auth user that this metadata belongs to
  @JsonKey(includeToJson: false)
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  @JsonKey(ignore: true)
  _$$_UserMetadataCopyWith<_$_UserMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
