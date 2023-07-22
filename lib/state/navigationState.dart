import 'package:flutter/material.dart';
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
        const HomeRoute().go(context);
        break;
      case 1:
        //const SearchRoute().go(context);
        break;
      case 2:
        //const ChatRoute().go(context);
        break;
      case 3:
        const AccountRoute().go(context);
        break;
    }
  }
}
