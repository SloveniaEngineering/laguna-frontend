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
    return _loginWithSavedCredentials();
  }

  Future<void> register(String email, String username, String password) async {
    state = await AsyncValue.guard<User?>(() async {
      return Controller().register(email, username, password);
    });
  }

  Future<void> login(String email, String password) async {
    state = await AsyncValue.guard<User?>(() async {
      return Controller().login(email, password);
    });
  }

  Future<User?> _loginWithSavedCredentials() async {
    return state.value;
    final String? username =
        await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.usernameKey);
    final String? password =
        await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.passwordKey);

    if (username != null && password != null) {
      return Controller().login(username, password);
    }
    return null;
    throw const UnauthorizedException('Session expired');
  }

  Future<void> logout() async {
    state = const AsyncValue<User?>.data(null);
  }

  /// Tries to perform a login with the saved token on the persistant storage.
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<User?> _loginRecoveryAttempt() async {
    try {
      final String? savedToken =
          await ref.read(storageServiceProvider).readStringValueFromStorage(key: Constants.accessTokenKey);
      if (savedToken == null) throw const UnauthorizedException('No auth token found');

      //If user had remember me checked, then we try to login with the saved credentials
      return await _loginWithSavedCredentials();
    } catch (_, __) {
      return null;
    }
  }

  /// Internal method used to listen authentication state changes.
  /// When the auth object is in a loading state, nothing happens.
  /// When the auth object is in a error state, we choose to remove the token
  /// Otherwise, we expect the current auth value to be reflected in our persistence API
  void _persistenceRefreshLogic() {
    ref.listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.accessTokenKey);
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.refreshTokenKey);
      }

      if (next.value.isLoggedIn()) {
        print('isLoggedInMethodCalled');
      } else if (next.value.isLoggedOut()) {
        print('isLoggedOutMethodCalled');
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.accessTokenKey);
        ref.read(storageServiceProvider).deleteStorageByKey(key: Constants.refreshTokenKey);
      }
    });
  }
}

/// Simple mock of a 401 exception
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}

//TODO: Add state for access token and refresh token
