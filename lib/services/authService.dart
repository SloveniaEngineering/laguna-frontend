import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/services/storageService.dart';

/// A class that provides authentication-related functionality.
class AuthService {
  /// Saves the access token and refresh token to storage.
  Future<void> saveTokensToStorage({required String accessToken, required String refreshToken}) async {
    print("Saving tokens to storage");
    print("Access token: $accessToken");
    print("Refresh token: $refreshToken");
    StorageService().writeStringToStorage(key: Constants.accessTokenKey, value: accessToken);
    StorageService().writeStringToStorage(key: Constants.refreshTokenKey, value: refreshToken);
  }

  /// Retrieves the access token from storage.
  Future<String?> getAccessToken() {
    return StorageService().readStringValueFromStorage(key: Constants.accessTokenKey);
  }

  /// Retrieves the refresh token from storage.
  Future<String?> getRefreshToken() {
    return StorageService().readStringValueFromStorage(key: Constants.refreshTokenKey);
  }

  /// Checks if a given token is expired.
  ///
  /// Returns `true` if the token is expired, otherwise `false`.
  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  /// Checks if the user is logged in.
  ///
  /// Returns `true` if the user is logged in and the access token is not expired, otherwise `false`.
  Future<bool> isUserLoggedIn() async {
    final String? accessToken = await getAccessToken();
    final String? refreshToken = await getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      return !isTokenExpired(accessToken);
    }

    return false;
  }

  /// Logs the user out by deleting the tokens from storage.
  Future<void> logout() async {
    await StorageService().deleteStorageByKey(key: Constants.accessTokenKey);
    await StorageService().deleteStorageByKey(key: Constants.refreshTokenKey);
  }
}
