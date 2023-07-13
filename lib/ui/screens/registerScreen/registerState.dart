import 'dart:convert';

import 'package:laguna/constants.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/services/httpService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registerState.g.dart';

@riverpod
Future<void> register(RegisterRef ref, String email, String username, String password) async {
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
  User user = User.fromJson(jsonBody);
  print(user.username);
}
