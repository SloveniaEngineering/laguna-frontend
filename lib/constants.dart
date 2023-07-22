/// A class that contains various constant values used in the application.
class Constants {
  // App settings

  /// The minimum length allowed for a password.
  static const int minPasswordLength = 6;

  /// The maximum length allowed for a password.
  static const int maxPasswordLength = 100;

  /// The minimum length allowed for a username.
  static const int minUsernameLength = 6;

  /// The maximum length allowed for a username.
  static const int maxUsernameLength = 30;

  /// The minimum length allowed for an email address.
  static const int minEmailLength = 5;

  /// The maximum length allowed for an email address.
  static const int maxEmailLength = 50;

  // API settings

  /// The base URL for the API endpoints.
  static const String baseUrl = 'http://127.0.0.1:6969';

  /// The endpoint for the login API.
  static const String loginEndpoint = '$baseUrl/api/user/auth/login';

  /// The endpoint for the register API.
  static const String registerEndpoint = '$baseUrl/api/user/auth/register';

  // Storage keys

  /// The key used to store the access token in the storage.
  static const String accessTokenKey = 'X-Access-Token-Key';

  /// The key used to store the refresh token in the storage.
  static const String refreshTokenKey = 'X-Refresh-Token-Key';

  /// The key used to store the "Remember Me" option in the storage.
  static const String rememberMeKey = 'rememberMeKey';

  /// The key used to store the username in the storage.
  static const String usernameKey = 'usernameKey';

  /// The key used to store the password in the storage.
  static const String passwordKey = 'passwordKey';
}
