import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/state/authController.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'routes.dart';

part 'router_listenable.g.dart';

/// A [Listenable] implemented via an [AsyncNotifier].
/// [GoRouter] accepts a [Listenable] to refresh its internal state, so this is kinda mandatory.
///
/// An alternative would be to register a dependency via an Inherited Widget, but that's kinda a no-go for Riverpod.
///
/// To sync Riverpod' state with this Listener, we simply accept and call a single callback on authentication change.
///
/// This allows us to centralize global redirecting logic in one class.
///
/// SIDE NOTES.
/// This might look overcomplicated at a first glance;
/// Instead, this method aims to follow some good some good practices:
///   1. It doesn't require us to pass [Ref](s) around
///   2. It works as a complete replacement for [ChangeNotifier], as it still implements [Listenable]
///   3. It allows for listening to multiple providers, or add more logic if needed
@riverpod
class RouterListenable extends _$RouterListenable implements Listenable {
  VoidCallback? _routerListener;
  bool _isAuth = false; // Useful for our global redirect function

  @override
  Future<void> build() async {
    // One could watch more providers and write logic accordingly
    // Watches the authControllerProvider to determine if the user is authenticated
    _isAuth = await ref.watch(
      authControllerProvider.selectAsync(
        (User? data) {
          return data != null; // If we have a user, we're authenticated
        },
      ),
    );

    // Listens to changes in the state and calls the routerListener when appropriate
    ref.listenSelf((_, __) {
      // One could write more conditional logic for when to call redirection
      if (state.isLoading) return;
      _routerListener?.call();
    });
  }

  /// Redirects the user when our authentication changes
  /// Determines the appropriate redirection based on authentication status and the current route
  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) return null;

    final isSplash = state.location == SplashRoute.path;
    final isLogin = state.location == LoginRoute.path;
    final isRegister = state.location == RegisterRoute.path;
    final isForgotPass = state.location == ForgotPasswordRoute.path;

    if (isSplash) {
      return _isAuth
          ? HomeRoute.path
          : (state.location == LoginRoute.path
              ? null
              : state.location == RegisterRoute.path
                  ? null
                  : state.location == ForgotPasswordRoute.path
                      ? null
                      : LoginRoute.path);
    } else if (isLogin) {
      if (_isAuth) {
        return HomeRoute.path; // Redirect to HomeRoute - After successful login
      } else if (isRegister) {
        return null; // Allow navigation to the RegisterRoute
      } else if (isForgotPass) {
        return null; // Allow navigation to the ForgotPassRoute
      } else if (isLogin) {
        return null; // Allow navigation to the LoginRoute
      }
    } else if (isRegister || isForgotPass) {
      return null; // Allow navigation to the RegisterRoute or ForgotPassRoute
    }

    return _isAuth ? null : SplashRoute.path;
  }

  /// Adds [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method on creation to handle its
  /// internal [ChangeNotifier].
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  /// Removes [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method when disposing,
  /// so that it removes its callback when destroyed.
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }
}
