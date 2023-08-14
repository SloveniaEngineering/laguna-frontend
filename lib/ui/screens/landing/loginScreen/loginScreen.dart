import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/routing/routes.dart';
import 'package:laguna/state/authController.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landingBox.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameOrEmailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberMe = false;
  String? Function(String?)? usernameOrEmailValidatorFunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          bool isWideScreen = screenWidth > 700;
          return Form(
            key: formKey,
            child: LandingBox(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              isWideScreen: isWideScreen,
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Laguna Prijava",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    const SizedBox(height: 35),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        width: isWideScreen ? screenWidth * 0.25 : null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CredentialTextField(
                              onChanged: (String text) {
                                setState(() {
                                  usernameOrEmailValidatorFunction = text
                                          .contains("@")
                                      ? Validators.requiredEmailValidationHelper
                                      : Validators
                                          .requiredUsernameValidationHelper;
                                });
                              },
                              mainText: "Uporabniško ime ali email",
                              isPassword: false,
                              controller: usernameOrEmailController,
                              validatorFunction:
                                  usernameOrEmailValidatorFunction,
                            ),
                            const SizedBox(height: 10),
                            CredentialTextField(
                              mainText: "Geslo",
                              isPassword: true,
                              validatorFunction:
                                  Validators.requiredPasswordValidationHelper,
                              controller: passController,
                              allowObscureChange: true,
                              isPasswordVisible: isPasswordVisible,
                              onVisibilityTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: rememberMe,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          rememberMe = value!;
                                        });
                                      },
                                    ),
                                    const Text("Zapomni si me"),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    GoRouter.of(context)
                                        .push(ForgotPasswordRoute.path);
                                  },
                                  child: const Text("Pozabljeno geslo?"),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ref
                                        .read(authControllerProvider.notifier)
                                        .login(
                                          context: context,
                                          email: usernameOrEmailController.text,
                                          password: passController.text,
                                        );
                                  }
                                },
                                child: const Text('Prijava'),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Nimate računa?",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                TextButton(
                                  onPressed: () {
                                    GoRouter.of(context)
                                        .push(RegisterRoute.path);
                                  },
                                  child: const Text("Registracija"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
