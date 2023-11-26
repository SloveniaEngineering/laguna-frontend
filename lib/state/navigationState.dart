import 'package:flutter/material.dart';
import 'package:laguna/routing/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigationState.g.dart';

@riverpod
class NavigationIndex extends _$NavigationIndex {
  @override
  int build() {
    // The initial navigation index, defaults to 0.
    return 0;
  }

  /// Navigates to the specified [index].
  ///
  /// The [context] is used to push the corresponding route.
  ///
  /// Available indexes and corresponding routes:
  ///   - 0: HomeRoute
  ///   - 1: SearchRoute (Not yet implemented)
  ///   - 2: ChatRoute (Not yet implemented)
  ///   - 3: AccountRoute
  void goToIndex({required BuildContext context, required int index}) {
    state = index;
    switch (index) {
      case 0:
        // Navigates to the HomeRoute.
        const HomeRoute().go(context);
        break;
      case 1:
        // Navigates to the AccountRoute.
        const AccountRoute().go(context);
        break;
    }
  }
}
