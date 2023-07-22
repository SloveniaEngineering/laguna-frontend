// userDto.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laguna/services/authService.dart';

part 'userDto.freezed.dart';
part 'userDto.g.dart';

/// A data transfer object representing a user.
@freezed
class User with _$User {
  const factory User({
    /// The unique identifier of the user.
    required String id,

    /// The username of the user.
    required String username,

    /// The date of the user's first login, if available.
    required String? first_login,

    /// The date of the user's last login, if available.
    required String? last_login,

    /// The URL of the user's avatar, if available.
    required String? avatar_url,

    /// The role of the user (e.g., admin, regular user).
    required String role,

    /// The behavior??? of the user, if available - weird, i know
    required String? behaviour,

    /// Indicates if the user is currently active.
    required bool is_active,

    /// Indicates if the user's email has been verified.
    required bool has_verified_email,

    /// Indicates if the user's history is private.
    required bool is_history_private,

    /// Indicates if the user's profile is private.
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
