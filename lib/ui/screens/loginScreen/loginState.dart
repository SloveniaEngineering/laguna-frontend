import 'dart:convert';

import 'package:laguna/constants.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/services/httpService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loginState.g.dart';

@riverpod
Future<void> login(LoginRef ref, String username, String password) async {
  print("login");
  late ResponseWrapper response;
  try {
    Map<String, String> body = {
      "username_or_email": username,
      "password": password,
    };

    response = await HttpService.postRequest(endpoint: Constants.loginEndpoint, body: jsonEncode(body));
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
  User user = User.fromJson(jsonBody);
  print(user.username);
}
