import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/routing/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigationState.g.dart';

@riverpod
class NavigationIndex extends _$NavigationIndex {
  @override
  int build() {
    return 0;
  }

  void goToIndex({required BuildContext context, required int index}) {
    state = index;
    switch (index) {
      case 0:
        GoRouter.of(context).go(HomeRoute.path);
        break;
      case 1:
        //Navigator.of(context).pushNamed(SearchRoute.routeName);
        break;
      case 2:
        //Navigator.of(context).pushNamed(ChatRoute.routeName);
        break;
      case 3:
        GoRouter.of(context).go(AccountRoute.path);
        break;
    }
  }
}
