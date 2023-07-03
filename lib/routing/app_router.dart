import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/ui/loginScreen.dart';

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
        builder: (context, state) => const LoginScreen(), //Change this to RegisterScreen() when implemented
      ),
      GoRoute(
        path: Constants.forgotPasswordRoute,
        builder: (context, state) => const LoginScreen(), //Change this to ForgottenPassScreen() when implemented
      ),
    ],
  );
});
