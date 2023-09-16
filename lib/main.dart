import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:laguna/routing/router_listenable.dart';
import 'package:laguna/routing/routes.dart';
import 'package:laguna/services/storageService.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
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

/// The root widget of the Laguna application.
class MyApp extends HookConsumerWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize the storage service for reading/writing data securely.
    ref.read(storageServiceProvider).initStorage();

    // Get the router notifier to listen for changes and refresh the router.
    final notifier = ref.watch(routerListenableProvider.notifier);

    // Use Hook to get a memoized instance of the GoRouter with dependencies.
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

    // Use MaterialApp.router to set up the application with the GoRouter.
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
