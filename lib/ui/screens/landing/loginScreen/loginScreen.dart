import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/routing/routes.dart';
import 'package:laguna/state/authController.dart';
import 'package:laguna/ui/spacing/spacing.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landingBox.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/login-bg-img.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: LandingBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/images/logo-text.svg"),
                      verticalMargin32,
                      Row(
                        children: [
                          const Text(
                            "Sign in or",
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () {
                              GoRouter.of(context).push(RegisterRoute.path);
                            },
                            child: const Text(
                              "create an account",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      verticalMargin8,
                      const LoginForm(isWideScreen: true)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  final bool isWideScreen;
  const LoginForm({super.key, required this.isWideScreen});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameOrEmailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberMe = false;
  String? Function(String?)? usernameOrEmailValidatorFunction;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CredentialTextField(
              onChanged: (String text) {
                setState(() {
                  usernameOrEmailValidatorFunction = text.contains("@")
                      ? Validators.requiredEmailValidationHelper
                      : Validators.requiredUsernameValidationHelper;
                });
              },
              mainText: "Uporabniško ime ali email",
              isPassword: false,
              controller: usernameOrEmailController,
              validatorFunction: usernameOrEmailValidatorFunction,
            ),
            verticalMargin16,
            CredentialTextField(
              mainText: "Geslo",
              isPassword: true,
              validatorFunction: Validators.requiredPasswordValidationHelper,
              controller: passController,
              allowObscureChange: true,
              isPasswordVisible: isPasswordVisible,
              onVisibilityTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            verticalMargin16,
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
                const Text("Remember me"),
              ],
            ),
            verticalMargin12,
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                GoRouter.of(context).push(ForgotPasswordRoute.path);
              },
              child: const Text(
                "Forgotten password",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            verticalMargin20,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF93FB9D)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(authControllerProvider.notifier).login(
                          context: context,
                          email: usernameOrEmailController.text,
                          password: passController.text,
                        );
                  }
                },
                child: const Text(
                  'LOG IN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
