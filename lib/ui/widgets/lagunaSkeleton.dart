import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laguna/routing/routes.dart';
import 'package:laguna/state/navigationState.dart';

/// A skeleton widget for the Laguna app's main screen layout.
/// It uses [AdaptiveScaffold] to provide adaptive behavior for different screen sizes.
class LagunaSkeleton extends ConsumerWidget {
  /// Creates a [LagunaSkeleton] widget.
  const LagunaSkeleton({Key? key, required this.child}) : super(key: key);

  /// The child widget to be displayed as the main content.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveScaffold(
      // An option to override the default breakpoints used for small, medium, and large screens.
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),

      // Whether to use a drawer for navigation on small screens.
      useDrawer: true,

      // The currently selected index for navigation.
      selectedIndex: ref.watch(navigationIndexProvider),

      // Callback for when the selected index changes.
      onSelectedIndexChange: (int index) {
        ref
            .read(navigationIndexProvider.notifier)
            .goToIndex(context: context, index: index);
      },

      // List of navigation destinations for the bottom navigation bar.
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

      // Whether to use internal animations for adaptive transition.
      internalAnimations: false,

      // The main body content for the adaptive scaffold.
      body: (_) => SafeArea(child: child),

      // The small breakpoint body content for the adaptive scaffold.
      smallBody: (_) => SafeArea(child: child),

      // Leading widget to display on the unextended navigation rail (small screens).
      leadingUnextendedNavRail: Container(
        color: Colors.blueGrey,
        width: 50,
        height: 50,
        child: const Text("Laguna"),
      ),

      // Define a default leading widget for the extended navigation rail (medium and large screens).
      leadingExtendedNavRail: const SizedBox(
        width: 50,
        height: 50,
        child: Icon(Icons.accessible_forward_rounded),
      ),

      // Define a default secondary body content.
      secondaryBody: AdaptiveScaffold.emptyBuilder,

      // Override the default secondary body during the small breakpoint to be empty.
      // Must use AdaptiveScaffold.emptyBuilder to ensure it is properly overridden.
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}
