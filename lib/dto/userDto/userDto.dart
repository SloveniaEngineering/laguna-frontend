// userDto.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laguna/dtoEnums/behaviour.dart';
import 'package:laguna/dtoEnums/role.dart';
import 'package:laguna/services/authService.dart';

part 'userDto.freezed.dart';
part 'userDto.g.dart';

/// A data transfer object representing a user.
@freezed
class User with _$User {
  const factory User(
      {required String id,
      required String username,
      required DateTime first_login,
      required DateTime? last_login,
      required String? avatar_url,
      required Role role,
      required Behaviour behaviour,
      required bool is_enabled,
      required bool is_donator,
      required bool has_verified_email,
      required bool is_profile_private,
      required String? email_confirm_hash,
      required DateTime? email_confirm_expiry}) = _User;

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
