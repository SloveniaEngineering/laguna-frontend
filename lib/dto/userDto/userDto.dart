// userDto.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laguna/services/authService.dart';

part 'userDto.freezed.dart';
part 'userDto.g.dart';

/// A data transfer object representing a user.
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String username,
    required String first_login,
    required String? last_login,
    required String? avatar_url,
    required String role,
    required String behaviour,
    required bool is_enabled,
    required bool is_donator,
    required bool has_verified_email,
    required bool is_profile_private,
  }) = _User;

  /// Create a User instance from a JSON map.
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

/// Extension methods for the User class.
extension UserExtension on User? {
  /// Checks if the user is logged out by verifying if the user's tokens in storage are null.
  /// Returns `true` if the user is logged out, otherwise `false`.
  Future<bool> isLoggedOut() async {
    return await AuthService().isUserLoggedIn() == false;
  }

  /// Checks if the user is logged in by verifying if the user's tokens in storage are not null.
  /// Returns `true` if the user is logged in, otherwise `false`.
  Future<bool> isLoggedIn() async {
    return await AuthService().isUserLoggedIn();
  }
}
