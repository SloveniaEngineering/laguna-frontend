import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/dto/alreadyExistsDto/alreadyExistsDto.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/helpers/response_helper.dart';
import 'package:laguna/services/httpService.dart';

/// A class that serves as a controller to handle authentication and user registration operations.
class Controller {
  /// Performs the login operation using the provided [username] and [password].
  ///
  /// Returns a tuple containing the [User] instance and the HTTP status code as an [int].
  /// If the login is successful, [User] will contain user information; otherwise, it will be `null`.
  /// If an error occurs during the login process, the corresponding error message will be printed.
  Future<(User?, String?)> login(String username, String password) async {
    Map<String, String> body = {
      "username_or_email": username,
      "password": password,
    };
    Response response = await HttpService.postRequest(endpoint: Constants.loginEndpoint, body: jsonEncode(body));

    if (!ResponseHelper.isSuccess(response)) {
      return (null, response.body);
    }

    try {
      return (User.fromJson(jsonDecode(response.body)), null);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

    return (null, "Tovor metapodatkov uporabnika pokvarjen.");
  }

  /// Performs the user registration operation using the provided [email], [username], and [password].
  ///
  /// Returns the HTTP status code as an [int].
  /// If an error occurs during the registration process, the corresponding error message will be printed.
  Future<(AlreadyExists?, String?)> register(String email, String username, String password) async {
    Map<String, String> body = {
      "email": email,
      "username": username,
      "password": password,
    };

    Response response = await HttpService.postRequest(endpoint: Constants.registerEndpoint, body: jsonEncode(body));

    if (response.body.isEmpty) {
      return (null, null);
    }
    try {
      AlreadyExists alreadyExists = AlreadyExists.fromJson(jsonDecode(response.body));
      return (alreadyExists, alreadyExists.message);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }

    return (null, response.body);
  }
}
