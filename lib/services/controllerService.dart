import 'dart:convert';

import 'package:laguna/constants.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/services/httpService.dart';

class Controller {
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
      print(jsonBody['LoginSuccess']['user']);
      final User user = User.fromJson(jsonBody['LoginSuccess']['user']);
      return (user, response.statusCode);
    } catch (e, s) {
      print(e);
      print(s);
    }
    return (null, response.statusCode);
  }

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
