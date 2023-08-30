import 'package:laguna/constants.dart';

/// A collection of static methods to perform various validations on user input fields.
class Validators {
  static bool checkEmpty(String input) {
    return input.trim().isEmpty;
  }

  static bool checkLengthInBounds(String input, int min, int max) {
    return input.length >= min && input.length <= max;
  }

  /// Validates the provided email address to ensure it is not empty, follows a valid email format,
  /// and has a proper length within the defined constraints.
  ///
  /// Returns an error message if the validation fails, otherwise returns null.
  static String? requiredEmailValidationHelper(String? input) {
    input ??= "";
    if (Validators.checkEmpty(input)) {
      return "Email naslov je obvezen podatek.";
    }

    // regex for email validation
    const emailRegex =
        r"[a-z0-9!#$%&‘*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&‘*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

    final result = RegExp(emailRegex).hasMatch(input.toLowerCase());
    if (!result) {
      return "Email naslov ni veljaven.";
    }

    if (!Validators.checkLengthInBounds(input, Constants.minEmailLength, Constants.maxEmailLength)) {
      return "Email naslov mora vsebovati od ${Constants.minEmailLength} do vključno ${Constants.maxEmailLength} znakov.";
    }

    return null;
  }

  /// Validates the provided username to ensure it is not empty and has a proper length within the defined constraints.
  ///
  /// Returns an error message if the validation fails, otherwise returns null.
  static String? requiredUsernameValidationHelper(String? input) {
    input ??= "";
    if (Validators.checkEmpty(input)) {
      return "Uporabniško ime je obvezen podatek.";
    }

    if (!Validators.checkLengthInBounds(input, Constants.minUsernameLength, Constants.maxUsernameLength)) {
      return "Uporabniško ime mora vsebovati od ${Constants.minUsernameLength} do vključno ${Constants.maxUsernameLength} znakov.";
    }

    return null;
  }

  /// Validates the provided password to ensure it is not empty, has a proper length within the defined constraints,
  /// and satisfies the password complexity requirements (at least three out of four: uppercase letters, lowercase letters,
  /// digits, and special characters).
  ///
  /// Returns an error message if the validation fails, otherwise returns null.
  static String? requiredPasswordValidationHelper(String? input) {
    if (input == null || input.isEmpty) {
      return "Geslo je obvezen podatek.";
    }

    if (!Validators.checkLengthInBounds(input, Constants.minPasswordLength, Constants.maxPasswordLength)) {
      return "Geslo mora vsebovati od ${Constants.minPasswordLength} do vključno ${Constants.maxPasswordLength} znakov.";
    }
    return null;
  }
}
