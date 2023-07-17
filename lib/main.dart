import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:laguna/routing/router_listenable.dart';
import 'package:laguna/routing/routes.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(routerListenableProvider.notifier);

    final key = useRef(GlobalKey<NavigatorState>(debugLabel: 'routerKey'));
    final router = useMemoized(
      () => GoRouter(
        navigatorKey: key.value,
        refreshListenable: notifier,
        initialLocation: SplashRoute.path,
        debugLogDiagnostics: true,
        routes: $appRoutes,
        redirect: notifier.redirect,
      ),
      [notifier],
    );
    return MaterialApp.router(
      title: 'Laguna',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
