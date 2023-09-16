import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/services/storageService.dart';

/// A class that provides authentication-related functionality.
class AuthService {
  /// Saves the access token and refresh token to storage.
  ///
  /// The [accessToken] and [refreshToken] are saved to the device's storage for future use.
  /// This method is typically called after successful authentication or token refresh.
  Future<void> saveTokensToStorage(
      {required String accessToken, required String refreshToken}) async {
    print("Saving tokens to storage");
    print("Access token: $accessToken");
    print("Refresh token: $refreshToken");
    StorageService().writeStringToStorage(
        key: Constants.accessTokenKey, value: accessToken);
    StorageService().writeStringToStorage(
        key: Constants.refreshTokenKey, value: refreshToken);
  }

  /// Retrieves the access token from storage.
  ///
  /// Returns the access token as a [String] if it exists in storage, otherwise returns `null`.
  Future<String?> getAccessToken() {
    return StorageService()
        .readStringValueFromStorage(key: Constants.accessTokenKey);
  }

  /// Retrieves the refresh token from storage.
  ///
  /// Returns the refresh token as a [String] if it exists in storage, otherwise returns `null`.
  Future<String?> getRefreshToken() {
    return StorageService()
        .readStringValueFromStorage(key: Constants.refreshTokenKey);
  }

  /// Checks if a given token is expired.
  ///
  /// Returns `true` if the [token] is expired, otherwise `false`.
  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  /// Checks if the user is logged in.
  ///
  /// Returns `true` if the user is logged in and the access token is not expired, otherwise `false`.
  /// This method checks if both access and refresh tokens exist in storage and if the access token is not expired.
  Future<bool> isUserLoggedIn() async {
    final String? accessToken = await getAccessToken();
    final String? refreshToken = await getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      return !isTokenExpired(accessToken);
    }

    return false;
  }

  /// Logs the user out by deleting the tokens from storage.
  ///
  /// Removes both the access token and the refresh token from the device's storage.
  /// This method is typically called when the user logs out of the application.
  Future<void> logout() async {
    await StorageService().deleteStorageByKey(key: Constants.accessTokenKey);
    await StorageService().deleteStorageByKey(key: Constants.refreshTokenKey);
  }
}
