import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/services/controllerService.dart';
import 'package:laguna/services/storageService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authController.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<User?> build() async {
    _persistenceRefreshLogic();
    return _loginWithSavedTokens();
  }

  Future<bool> register(
      {required BuildContext context,
      required String email,
      required String username,
      required String password}) async {
    int statusCode = await Controller().register(email, username, password);
    String message;
    switch (statusCode) {
      case 200:
        message = 'Registracija uspešna';
        break;
      case 208:
        message = 'Račun s tem e-poštnim naslovom ali uporabniškim imenom že obstaja.';
        break;
      case 400:
        message = 'Registracija neuspešna. Prosimo, poskusite znova.';
        break;
      default:
        message = 'Registracija neuspešna. Prosimo, poskusite znova.';
        break;
    }

    _showMessage(context, message);

    return statusCode == 200;
  }

  Future<void> login({required BuildContext context, required String email, required String password}) async {
    int? statusCode;
    AsyncValue<User?> value = await AsyncValue.guard<User?>(() async {
      User? user;
      (user, statusCode) = await Controller().login(email, password);
      return user;
    });

    if (value is AsyncError) {
      print(value.error);
    } else if (value is AsyncData) {
      print("setting state");
      print(value.hasValue);
      state = value;
    }

    String? message;
    switch (statusCode) {
      case 401:
        message = 'Napačno uporabniško ime ali geslo';
        break;
    }

    if (message != null) _showMessage(context, message);
  }

  Future<User?> _loginWithSavedTokens() async {
    print("Test1");
    final String? accessToken =
        await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.accessTokenKey);
    final String? refreshToken =
        await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.refreshTokenKey);
    if (accessToken == null || refreshToken == null) return null;
    if (JwtDecoder.isExpired(accessToken)) {
      print('Access token expired, forcing user to re-login');
      //return await _loginWithSavedCredentials();
      return null;
    } else {
      print('Attempting to login with saved tokens');
      User user = User.fromJson(JwtDecoder.decode(refreshToken));
      state = AsyncValue<User?>.data(user);
      return user;
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> logout() async {
    print('Logging out user');
    await ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.accessTokenKey);
    await ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.refreshTokenKey);
    state = const AsyncValue<User?>.data(null);
  }

  /// Tries to perform a login with the saved token on the persistant storage.
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<User?> _loginRecoveryAttempt() async {
    try {
      final String? savedToken =
          await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.accessTokenKey);
      //if (savedToken == null) throw const UnauthorizedException('No auth token found');

      //If user had remember me checked, then we try to login with the saved credentials
      return null;
      //return await _loginWithSavedCredentials();
    } catch (_, __) {
      return null;
    }
  }

  /// Internal method used to listen authentication state changes.
  /// When the auth object is in a loading state, nothing happens.
  /// When the auth object is in a error state, we choose to remove the token
  /// Otherwise, we expect the current auth value to be reflected in our persistence API
  void _persistenceRefreshLogic() async {
    ref.listenSelf((_, next) async {
      if (next.isLoading) return;
      if (next.hasError) {
        print('hasErrorMethodCalled');
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.accessTokenKey);
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.refreshTokenKey);
      }

      if (await next.value.isLoggedIn()) {
        print('isLoggedInMethodCalled');
      } else if (await next.value.isLoggedOut()) {
        print('isLoggedOutMethodCalled');
      }
    });
  }
}
