import 'dart:convert';

import 'package:laguna/constants.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/services/httpService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loginState.g.dart';

@riverpod
Future<User> login(LoginRef ref, String username, String password) async {
  ResponseWrapper response = await HttpService.postRequest(endpoint: Constants.loginEndpoint, body: {
    "username_or_email": username,
    "password": password,
  });

  if (!response.success) {
    throw Exception(response.errorMessage);
  }

  final jsonBody = jsonDecode(response.responseBody!);
  return User.fromJson(jsonBody);
}
