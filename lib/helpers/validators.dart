import 'package:laguna/constants.dart';

/// A collection of static methods to perform various validations on user input fields.
class Validators {
  /// Validates the provided email address to ensure it is not empty, follows a valid email format,
  /// and has a proper length within the defined constraints.
  ///
  /// Returns an error message if the validation fails, otherwise returns null.
  static String? requiredEmailValidationHelper(String? input) {
    if (input == null || input.isEmpty) {
      return "Email naslov je obvezen podatek.";
    }

    // regex for email validation
    const emailRegex =
        r"[a-z0-9!#$%&‘*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&‘*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

    final result = RegExp(emailRegex).hasMatch(input.toLowerCase());
    if (!result) {
      return "Email naslov ni veljaven.";
    }

    bool properLength = input.length >= Constants.minEmailLength && input.length <= Constants.maxEmailLength;
    if (!properLength) {
      return "Email naslov mora vsebovati od ${Constants.minEmailLength} do vključno ${Constants.maxEmailLength} znakov.";
    }

    return null;
  }

  /// Validates the provided username to ensure it is not empty and has a proper length within the defined constraints.
  ///
  /// Returns an error message if the validation fails, otherwise returns null.
  static String? requiredUsernameValidationHelper(String? input) {
    if (input == null || input.isEmpty) {
      return "Uporabniško ime je obvezen podatek.";
    }

    bool properLength = input.length >= Constants.minUsernameLength && input.length <= Constants.maxUsernameLength;

    if (!properLength) {
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

    bool hasUppercase = input.contains(RegExp(r'[A-Z]'));
    bool hasDigits = input.contains(RegExp(r'[0-9]'));
    bool hasLowercase = input.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters = input.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool properLength = input.length >= Constants.minPasswordLength && input.length <= Constants.maxPasswordLength;

    List<bool> conditionsList = [];
    conditionsList.add(hasUppercase);
    conditionsList.add(hasDigits);
    conditionsList.add(hasLowercase);
    conditionsList.add(hasSpecialCharacters);

    int numOfConditionsApply = 0;
    //Check if at least three of four conditions apply
    for (int i = 0; i < conditionsList.length; i++) {
      if (conditionsList[i]) {
        numOfConditionsApply += 1;
      }
    }

    if (!properLength) {
      return "Geslo mora vsebovati od ${Constants.minPasswordLength} do vključno ${Constants.maxPasswordLength} znakov.";
    } else if (numOfConditionsApply < 3) {
      return "Geslo mora vsebovati vsaj eno veliko črko, eno malo črko, eno številko in en poseben znak.";
    }
    return null;
  }
}
