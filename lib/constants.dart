class Constants {
  // Route names
  static const String dashboardRoute = '/dashboard';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';

  // App settings
  static const int minPasswordLength = 8;

  // API settings
  static const String baseUrl = 'http://127.0.0.1:6969';
  static const String loginEndpoint = '$baseUrl/api/user/auth/login';
  static const String registerEndpoint = '$baseUrl/api/user/auth/register';
}
