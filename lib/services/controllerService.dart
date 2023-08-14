import 'dart:convert';

import 'package:laguna/constants.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/services/httpService.dart';

/// A class that serves as a controller to handle authentication and user registration operations.
class Controller {
  /// Performs the login operation using the provided [username] and [password].
  ///
  /// Returns a tuple containing the [User] instance and the HTTP status code as an [int].
  /// If the login is successful, [User] will contain user information; otherwise, it will be `null`.
  /// If an error occurs during the login process, the corresponding error message will be printed.
  Future<(User?, int)> login(String username, String password) async {
    Map<String, String> body = {
      "username_or_email": username,
      "password": password,
    };
    ResponseWrapper response = await HttpService.postRequest(endpoint: Constants.loginEndpoint, body: jsonEncode(body));

    if (!response.success) {
      print(response.errorMessage);
    }

    try {
      final jsonBody = jsonDecode(response.responseBody!);
      print(jsonBody);
      final User user = User.fromJson(jsonBody);
      return (user, response.statusCode);
    } catch (e, s) {
      print(e);
      print(s);
    }
    return (null, response.statusCode);
  }

  /// Performs the user registration operation using the provided [email], [username], and [password].
  ///
  /// Returns the HTTP status code as an [int].
  /// If an error occurs during the registration process, the corresponding error message will be printed.
  Future<int> register(String email, String username, String password) async {
    Map<String, String> body = {
      "email": email,
      "username": username,
      "password": password,
    };

    ResponseWrapper response =
        await HttpService.postRequest(endpoint: Constants.registerEndpoint, body: jsonEncode(body));

    if (!response.success) {
      print(response.errorMessage);
    }

    return response.statusCode;
  }
}
