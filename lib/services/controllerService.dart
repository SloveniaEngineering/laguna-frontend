import 'dart:convert';

import 'package:laguna/constants.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/services/httpService.dart';

class Controller {
  Future<User> login(String username, String password) async {
    late ResponseWrapper response;
    try {
      Map<String, String> body = {
        "username_or_email": username,
        "password": password,
      };
      await Future.delayed(const Duration(seconds: 2));
      response = await HttpService.postRequest(endpoint: Constants.loginEndpoint, body: jsonEncode(body));
    } catch (e, s) {
      print(e);
      print(s);
    }

    if (!response.success) {
      print(response.errorMessage);
      throw Exception(response.errorMessage);
    }

    try {
      final jsonBody = jsonDecode(response.responseBody!);
      print(jsonBody['LoginSuccess']['user']);
      final User user = User.fromJson(jsonBody['LoginSuccess']['user']);
      return user;
    } catch (e, s) {
      print(e);
      print(s);
    }
    throw Exception('Something went wrong');
  }

  Future<User> register(String email, String username, String password) async {
    late ResponseWrapper response;
    try {
      Map<String, String> body = {
        "email": email,
        "username": username,
        "password": password,
      };

      response = await HttpService.postRequest(endpoint: Constants.registerEndpoint, body: jsonEncode(body));
    } catch (e, s) {
      print(e);
      print(s);
    }

    if (!response.success) {
      print(response.errorMessage);
      throw Exception(response.errorMessage);
    }

    final jsonBody = jsonDecode(response.responseBody!);
    print(jsonBody);
    return User.fromJson(jsonBody);
  }
}
