import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laguna/state/authController.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Home Screen"),
            //Logout button
            ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).logout();
                },
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
