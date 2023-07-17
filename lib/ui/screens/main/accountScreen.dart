import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laguna/state/authController.dart';
import 'package:laguna/ui/widgets/skeleton.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LagunaSkeleton(children: [
      const Text('Account Screen'),
      ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider.notifier).logout();
          },
          child: const Text('Logout'))
    ]);
  }
}
