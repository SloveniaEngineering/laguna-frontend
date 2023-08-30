import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/routing/routes.dart';
import 'package:laguna/state/authController.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landingBox.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          bool isWideScreen = screenWidth > 700;
          if (screenHeight < 550) {
            return SingleChildScrollView(
                child: LoginForm(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              isWideScreen: isWideScreen,
            ));
          }
          return LoginForm(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            isWideScreen: isWideScreen,
          );
        },
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isWideScreen;
  const LoginForm({super.key, required this.screenWidth, required this.screenHeight, required this.isWideScreen});

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
      child: LandingBox(
        screenWidth: widget.screenWidth,
        screenHeight: widget.screenHeight,
        isWideScreen: widget.isWideScreen,
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
                  width: widget.isWideScreen ? 400 : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      const SizedBox(height: 10),
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
                              GoRouter.of(context).push(ForgotPasswordRoute.path);
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
                              ref.read(authControllerProvider.notifier).login(
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
                              GoRouter.of(context).push(RegisterRoute.path);
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
    ;
  }
}
