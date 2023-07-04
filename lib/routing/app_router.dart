import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/ui/forgotPassScreen.dart';
import 'package:laguna/ui/loginScreen.dart';
import 'package:laguna/ui/registerScreen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: Constants.loginRoute,
    routes: [
      GoRoute(
        path: Constants.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Constants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Constants.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  );
});
