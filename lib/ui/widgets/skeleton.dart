import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/routing/routes.dart';

class LagunaSkeleton extends StatefulWidget {
  final List<Widget> children;
  const LagunaSkeleton({super.key, required this.children});

  @override
  State<LagunaSkeleton> createState() => _LagunaSkeletonState();
}

class _LagunaSkeletonState extends State<LagunaSkeleton> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      // An option to override the default breakpoints used for small, medium,
      // and large.
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
      useDrawer: true,
      selectedIndex: _selectedTab,
      onSelectedIndexChange: (int index) {
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

        setState(() {
          _selectedTab = index;
        });
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: HomeRoute.pageName,
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
        ),
      ],
      body: (_) => GridView.count(crossAxisCount: 2, children: widget.children),
      smallBody: (_) => ListView.builder(
        itemCount: widget.children.length,
        itemBuilder: (_, int idx) => widget.children[idx],
      ),
      // Define a default secondaryBody.
      secondaryBody: (_) => Container(
        color: const Color.fromARGB(255, 234, 158, 192),
      ),
      // Override the default secondaryBody during the smallBreakpoint to be
      // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
      // overridden.
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}
