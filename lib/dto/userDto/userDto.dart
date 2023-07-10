import 'package:freezed_annotation/freezed_annotation.dart';

part 'userDto.freezed.dart';
part 'userDto.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,
    required String? first_login,
    required String? last_login,
    required String? avatar_url,
    required String role,
    required String? behaviour,
    required bool is_active,
    required bool has_verified_email,
    required bool is_history_private,
    required bool is_profile_private,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
