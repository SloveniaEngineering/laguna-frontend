class Constants {
  // App settings
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 100;
  static const int minUsernameLength = 6;
  static const int maxUsernameLength = 30;
  static const int minEmailLength = 5;
  static const int maxEmailLength = 50;

  // API settings
  static const String baseUrl = 'http://127.0.0.1:6969';
  static const String loginEndpoint = '$baseUrl/api/user/auth/login';
  static const String registerEndpoint = '$baseUrl/api/user/auth/register';

  // Storage keys
  static const String accessTokenKey = 'X-Access-Token-Key';
  static const String refreshTokenKey = 'X-Refresh-Token-Key';
  static const String rememberMeKey = 'rememberMeKey';
  static const String usernameKey = 'usernameKey';
  static const String passwordKey = 'passwordKey';
}
