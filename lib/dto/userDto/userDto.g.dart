// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int,
      username: json['username'] as String,
      first_login: json['first_login'] as String?,
      last_login: json['last_login'] as String?,
      avatar_url: json['avatar_url'] as String?,
      role: json['role'] as String,
      behaviour: json['behaviour'] as String?,
      is_active: json['is_active'] as bool,
      has_verified_email: json['has_verified_email'] as bool,
      is_history_private: json['is_history_private'] as bool,
      is_profile_private: json['is_profile_private'] as bool,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_login': instance.first_login,
      'last_login': instance.last_login,
      'avatar_url': instance.avatar_url,
      'role': instance.role,
      'behaviour': instance.behaviour,
      'is_active': instance.is_active,
      'has_verified_email': instance.has_verified_email,
      'is_history_private': instance.is_history_private,
      'is_profile_private': instance.is_profile_private,
    };
