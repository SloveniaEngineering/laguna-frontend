import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/state/authController.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<User?> user = ref.watch(authControllerProvider);
    return Column(children: [
      const Text('Account Screen'),
      const SizedBox(
        height: 20,
      ),
      Text("User: ${user.value?.username ?? 'Error'}"),
      ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider.notifier).logout();
          },
          child: const Text('Logout')),
    ]);
  }
}
