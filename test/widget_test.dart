// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/helpers/validators.dart';

void main() {
  group("Validation", () {
    group("Email Validation", () {
      test('Invalid email formats', () {
        List<String> invalidEmails = [
          'plainaddress', // Missing '@' and domain.
          '@missingusername.com', // Missing username.
          'username@.com', // Missing domain name.
          'username@domain..com', // Double dots after domain.
          'username@domain.com.', // Trailing dot at the end.
          '.username@domain.com', // Leading dot in address.
          'username@.domain.com', // Leading dot in domain.
          'username@domain..com', // Double dots in domain.
          'username@domain.com.', // Trailing dot in domain.
          'username@domain#com', // Using invalid characters.
          'username@domain,com', // Using commas.
          'username@domain..co.uk', // Double dots before domain extension.
          'username@doma..in.com', // Double dots in domain name.
          'username@dom-ain..com', // Double dots in domain.
          'username@domain..com.', // Double dots and trailing dot.
          'username@do..main.com', // Double dots in domain name.
          'username@.domain..com', // Leading and double dots in domain.
          'username@server@domain.com' // Multiple '@' characters.
        ];

        for (var email in invalidEmails) {
          String? errorText = Validators.requiredEmailValidationHelper(email);
          expect(errorText, "Email naslov ni veljaven.",
              reason: 'Expected $email to be invalid');
        }
      });
      test('Valid email formats', () {
        List<String> validEmails = [
          'john.doe@example.com',
          'alice.smith@company.net',
          'charlie.brown@web.org',
          'david.jones@mywebsite.co.uk',
          'elizabeth.white@domain.info',
          'frank.miller@service.io',
          'grace.lee@platform.biz',
          'harry.wilson@site.cc',
          'isabella.johnson@webpage.tv',
          'jack.moore@portal.us'
        ];

        for (var email in validEmails) {
          String? errorText = Validators.requiredEmailValidationHelper(email);
          expect(errorText, null, reason: 'Expected $email to be valid');
        }
      });
      test('Empty email', () {
        String? empty = Validators.requiredEmailValidationHelper("");
        expect(empty, "Email naslov je obvezen podatek.");
      });
    });
  });
  group("Username validation", () {
    test("Empty username", () {
      String? empty = Validators.requiredUsernameValidationHelper("");
      expect(empty, "Uporabniško ime je obvezen podatek.");
    });
    test("Valid username", () {
      List<String> validUsernames = [
        'JohnDoe123',
        'AliceSmith45',
        'CharlieBrown678',
        'DavidJones90',
        'ElizabethW12'
      ];
      for (var username in validUsernames) {
        String? errorText =
            Validators.requiredUsernameValidationHelper(username);
        expect(errorText, null, reason: 'Expected $username to be invalid');
      }
    });
    test("Invalid username", () {
      List<String> invalidUsernames = [
        'John', // Less than 6 characters
        'Al', // Less than 6 characters
        'Char', // Less than 6 characters
        'DavidJonesDavidJonesDavidJonesDavidJones', // More than 30 characters
        'ElizabethWhiteElizabethWhiteElizabethWhite' // More than 30 characters
      ];

      for (var username in invalidUsernames) {
        String? errorText =
            Validators.requiredUsernameValidationHelper(username);
        expect(errorText,
            "Uporabniško ime mora vsebovati od ${Constants.minUsernameLength} do vključno ${Constants.maxUsernameLength} znakov.",
            reason: 'Expected $username to be valid');
      }
    });
  });
}
