import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/ui/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    initialLocation: Constants.loginRoute,
    routes: [
      GoRoute(
        path: Constants.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Laguna',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
