import 'package:freezed_annotation/freezed_annotation.dart';

part 'alreadyExistsDto.freezed.dart';

part 'alreadyExistsDto.g.dart';

/// A data transfer object representing a user.
@freezed
class AlreadyExists with _$AlreadyExists {
  const factory AlreadyExists({
    required String message,
    required List<String> recommended_usernames,
  }) = _AlreadyExists;

  /// Create a User instance from a JSON map.
  factory AlreadyExists.fromJson(Map<String, Object?> json) =>
      _$AlreadyExistsFromJson(json);
}
