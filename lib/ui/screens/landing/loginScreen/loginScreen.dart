import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/routing/routes.dart';
import 'package:laguna/state/authController.dart';
import 'package:laguna/ui/spacing/spacing.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landing_button.dart';

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
                "../assets/images/login-bg-img.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  constraints: const BoxConstraints(
                    maxWidth: 450,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("../assets/images/logo.svg"),
                      const Text("Prijava", style: TextStyle(fontSize: 30),),
                      verticalMargin32,
                      const LoginForm(isWideScreen: true),
                      verticalMargin12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(ForgotPasswordRoute.path);
                            },
                            child: const Text(
                              "Pozabil sem geslo",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(RegisterRoute.path);
                            },
                            child: const Text(
                              "Registriraj nov račun",
                            ),)
                        ],
                      ),
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
                const Text("Zapomni si me"),
              ],
            ),
            verticalMargin20,
            LandingButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(authControllerProvider.notifier).login(
                          context: context,
                          email: usernameOrEmailController.text,
                          password: passController.text,
                        );
                  }
                },
                text: 'Vpiši me'),
          ],
        ),
      ),
    );
  }
}
