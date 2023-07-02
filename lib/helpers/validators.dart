import 'package:laguna/constants.dart';

class Validators {
  static String? requiredEmailValidationHelper(String? input) {
    // regex for email validation
    const emailRegex =
        r"[a-z0-9!#$%&‘*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&‘*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    const nullInputText = "Email naslov je obvezen podatek.";
    const invalidRegexText = "Email naslov ni veljaven.";

    if (input == null || input.isEmpty) {
      return nullInputText;
    }

    final result = RegExp(emailRegex).hasMatch(input.toLowerCase());
    if (!result) {
      return invalidRegexText;
    }

    return null;
  }

  static String? requiredPasswordValidationHelper(String? input) {
    const nullInputText = "Geslo je obvezen podatek.";
    const lengthInputText =
        "Geslo mora vsebovati vsaj ${Constants.minPasswordLength} znakov.";
    const requirementText =
        "Geslo mora vsebovati vsaj eno veliko črko, eno malo črko, eno številko in en poseben znak.";

    if (input == null || input.isEmpty) {
      return nullInputText;
    } else {
      bool hasUppercase = input.contains(RegExp(r'[A-Z]'));
      bool hasDigits = input.contains(RegExp(r'[0-9]'));
      bool hasLowercase = input.contains(RegExp(r'[a-z]'));
      bool hasSpecialCharacters =
          input.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      bool hasMinLength = input.length >= Constants.minPasswordLength;

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

      if (hasMinLength == false) {
        return lengthInputText;
      } else if (numOfConditionsApply < 3) {
        return requirementText;
      }
    }

    return null;
  }
}
