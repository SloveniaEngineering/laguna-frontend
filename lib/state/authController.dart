import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/dto/alreadyExistsDto/alreadyExistsDto.dart';
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

  /// Attempts to register a new user with the provided [email], [username], and [password].
  ///
  /// Returns a [Future] that resolves to `true` if the registration is successful, otherwise `false`.
  Future<(AlreadyExists?, bool)> register(
      {required BuildContext context,
      required String email,
      required String username,
      required String password}) async {
    AlreadyExists? alreadyExists;
    String? errorMessage;
    (alreadyExists, errorMessage) = await Controller().register(email, username, password);
    if (errorMessage != null) _showMessage(context, errorMessage);
    return (alreadyExists, errorMessage == null);
  }

  /// Attempts to log in the user with the provided [email] and [password].
  ///
  /// Displays a snack bar with an error message if the login fails.
  ///
  /// Returns a [Future] that resolves to `void`.
  Future<void> login({required BuildContext context, required String email, required String password}) async {
    String? errorMessage;
    AsyncValue<User?> value = await AsyncValue.guard<User?>(() async {
      User? user;
      (user, errorMessage) = await Controller().login(email, password);
      return user;
    });

    if (value is AsyncError) {
      debugPrint(value.error.toString());
    } else if (value is AsyncData) {
      debugPrint("setting state");
      debugPrint(value.hasValue.toString());
      state = value;
    }

    if (errorMessage != null) _showMessage(context, errorMessage!);
  }

  /// Attempts to log in the user with the saved access and refresh tokens.
  ///
  /// Returns a [Future] that resolves to the [User] if the login is successful, otherwise `null`.
  Future<User?> _loginWithSavedTokens() async {
    debugPrint("Test1");
    final String? accessToken =
        await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.accessTokenKey);
    final String? refreshToken =
        await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.refreshTokenKey);
    if (accessToken == null || refreshToken == null) return null;
    if (JwtDecoder.isExpired(accessToken)) {
      debugPrint('Access token expired, forcing user to re-login');
      //return await _loginWithSavedCredentials();
      return null;
    } else {
      debugPrint('Attempting to login with saved tokens');
      User user = User.fromJson(JwtDecoder.decode(refreshToken));
      state = AsyncValue<User?>.data(user);
      return user;
    }
  }

  /// Displays a [SnackBar] with the provided [message].
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /// Logs out the user and clears the access and refresh tokens from storage.
  Future<void> logout() async {
    debugPrint('Logging out user');
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

  /// Internal method used to listen to authentication state changes.
  /// When the auth object is in a loading state, nothing happens.
  /// When the auth object is in an error state, the access and refresh tokens are removed from storage.
  /// Otherwise, we expect the current auth value to be reflected in our persistence API.
  void _persistenceRefreshLogic() async {
    ref.listenSelf((_, next) async {
      if (next.isLoading) return;
      if (next.hasError) {
        debugPrint('hasErrorMethodCalled');
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.accessTokenKey);
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.refreshTokenKey);
      }

      if (await next.value.isLoggedIn()) {
        debugPrint('isLoggedInMethodCalled');
      } else if (await next.value.isLoggedOut()) {
        debugPrint('isLoggedOutMethodCalled');
      }
    });
  }
}
