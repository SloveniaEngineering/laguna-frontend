import 'package:go_router/go_router.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/ui/screens/forgotPassScreen/forgotPassScreen.dart';
import 'package:laguna/ui/screens/loginScreen/loginScreen.dart';
import 'package:laguna/ui/screens/registerScreen/registerScreen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
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
}
