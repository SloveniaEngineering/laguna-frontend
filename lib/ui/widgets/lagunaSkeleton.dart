import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laguna/routing/routes.dart';
import 'package:laguna/state/navigationState.dart';

class LagunaSkeleton extends ConsumerWidget {
  const LagunaSkeleton({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveScaffold(
      // An option to override the default breakpoints used for small, medium,
      // and large.
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
      useDrawer: true,
      selectedIndex: ref.watch(navigationIndexProvider),
      onSelectedIndexChange: (int index) {
        ref.read(navigationIndexProvider.notifier).goToIndex(context: context, index: index);
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: HomeRoute.pageName,
          tooltip: HomeRoute.pageName,
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_outlined),
          selectedIcon: Icon(Icons.chat),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(CupertinoIcons.person),
          selectedIcon: Icon(Icons.person),
          label: AccountRoute.pageName,
          tooltip: AccountRoute.pageName,
        ),
      ],
      internalAnimations: false,
      body: (_) => SafeArea(child: child),
      smallBody: (_) => SafeArea(child: child),
      leadingUnextendedNavRail: Container(
        color: Colors.blueGrey,
        width: 50,
        height: 50,
        child: const Text("Laguna"),
      ),
      // Define a default leading widget.
      leadingExtendedNavRail: const SizedBox(
        width: 50,
        height: 50,
        child: Icon(Icons.accessible_forward_rounded),
      ),
      // Define a default secondaryBody.
      secondaryBody: AdaptiveScaffold.emptyBuilder,
      // Override the default secondaryBody during the smallBreakpoint to be
      // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
      // overridden.
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}
