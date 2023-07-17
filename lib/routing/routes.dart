import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/ui/screens/landing/forgotPassScreen/forgotPassScreen.dart';
import 'package:laguna/ui/screens/landing/loginScreen/loginScreen.dart';
import 'package:laguna/ui/screens/landing/registerScreen/registerScreen.dart';
import 'package:laguna/ui/screens/main/homeScreen.dart';
import 'package:laguna/ui/screens/splashScreen.dart';

part 'routes.g.dart';

@TypedGoRoute<LoginRoute>(path: LoginRoute.path)
class LoginRoute extends GoRouteData {
  const LoginRoute();
  static const path = '/prijava';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<RegisterRoute>(path: RegisterRoute.path)
class RegisterRoute extends GoRouteData {
  const RegisterRoute();
  static const path = '/registracija';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}

@TypedGoRoute<ForgotPasswordRoute>(path: ForgotPasswordRoute.path)
class ForgotPasswordRoute extends GoRouteData {
  const ForgotPasswordRoute();
  static const path = '/pozabiljeno-geslo';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ForgotPasswordScreen();
  }
}

@TypedGoRoute<SplashRoute>(path: SplashRoute.path)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const path = '/loading';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<HomeRoute>(path: HomeRoute.path)
class HomeRoute extends GoRouteData {
  const HomeRoute();
  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}
