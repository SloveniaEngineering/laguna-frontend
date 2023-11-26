import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laguna/dto/userDto/userDto.dart';
import 'package:laguna/state/authController.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<User?> user = ref.watch(authControllerProvider);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Account Screen'),
          const SizedBox(
            height: 20,
          ),
          Text("User: ${user.value?.username ?? 'Error'}"),
          Text("Verified email: ${user.value?.has_verified_email ?? 'Error'}"),
          Text(
              "Email confirm hash: ${user.value?.email_confirm_hash ?? 'Error'}"),
          Text(
              "Email confirm expiry: ${user.value?.email_confirm_expiry ?? 'Error'}"),
          Text("Role: ${user.value?.role ?? 'Error'}"),
          Text("First login: ${user.value?.first_login ?? 'Error'}"),
          Text("Last login: ${user.value?.last_login ?? 'Error'}"),
          Text("Behaviour: ${user.value?.behaviour ?? 'Error'}"),
          ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logout();
              },
              child: const Text('Logout')),
        ]);
  }
}
