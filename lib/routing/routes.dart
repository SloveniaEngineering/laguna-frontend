import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/ui/screens/landing/forgotPassScreen/forgotPassScreen.dart';
import 'package:laguna/ui/screens/landing/loginScreen/loginScreen.dart';
import 'package:laguna/ui/screens/landing/registerScreen/registerScreen.dart';
import 'package:laguna/ui/screens/main/accountScreen.dart';
import 'package:laguna/ui/screens/main/homeScreen.dart';
import 'package:laguna/ui/screens/splashScreen.dart';
import 'package:laguna/ui/widgets/lagunaSkeleton.dart';

part 'routes.g.dart';

/// TypedGoRoute for the Login screen.
@TypedGoRoute<LoginRoute>(path: LoginRoute.path, name: LoginRoute.pageName)
class LoginRoute extends GoRouteData {
  const LoginRoute();
  static const pageName = 'Prijava';
  static const path = '/prijava';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

/// TypedGoRoute for the Register screen.
@TypedGoRoute<RegisterRoute>(path: RegisterRoute.path, name: RegisterRoute.pageName)
class RegisterRoute extends GoRouteData {
  const RegisterRoute();
  static const pageName = 'Registracija';
  static const path = '/registracija';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}

/// TypedGoRoute for the Forgot Password screen.
@TypedGoRoute<ForgotPasswordRoute>(path: ForgotPasswordRoute.path, name: ForgotPasswordRoute.pageName)
class ForgotPasswordRoute extends GoRouteData {
  const ForgotPasswordRoute();
  static const pageName = 'Pozabljeno geslo';
  static const path = '/pozabiljeno-geslo';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ForgotPasswordScreen();
  }
}

/// TypedGoRoute for the Splash screen.
@TypedGoRoute<SplashRoute>(path: SplashRoute.path, name: SplashRoute.pageName)
class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const pageName = 'Loading';
  static const path = '/loading';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

/// TypedShellRoute for the main shell route that holds Home and Account routes.
@TypedShellRoute<MyShellRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: HomeRoute.path),
    TypedGoRoute<AccountRoute>(path: AccountRoute.path),
  ],
)
class MyShellRouteData extends ShellRouteData {
  const MyShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return LagunaSkeleton(child: navigator);
  }
}

/// TypedGoRoute for the Home screen.
@TypedGoRoute<HomeRoute>(path: HomeRoute.path, name: HomeRoute.pageName)
class HomeRoute extends GoRouteData {
  const HomeRoute();
  static const pageName = 'Home';
  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

/// TypedGoRoute for the Account screen.
@TypedGoRoute<AccountRoute>(path: AccountRoute.path, name: AccountRoute.pageName)
class AccountRoute extends GoRouteData {
  const AccountRoute();
  static const pageName = 'My Account';
  static const path = '/account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountScreen();
  }
}
