import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/dto/alreadyExistsDto/alreadyExistsDto.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/state/authController.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landingBox.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          bool isWideScreen = screenWidth > 700;

          if (screenHeight < 660) {
            return SingleChildScrollView(
                child: RegisterForm(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    isWideScreen: isWideScreen));
          }
          return RegisterForm(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              isWideScreen: isWideScreen);
        },
      ),
    );
  }
}

class RegisterForm extends ConsumerStatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isWideScreen;

  const RegisterForm(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.isWideScreen});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  List<String> usernameRecommendations = List.empty();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: LandingBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Laguna Registracija",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CredentialTextField(
                    mainText: "Email",
                    isPassword: false,
                    controller: emailController,
                    validatorFunction: Validators.requiredEmailValidationHelper,
                  ),
                  const SizedBox(height: 10),
                  CredentialTextField(
                      mainText: "Username",
                      isPassword: false,
                      controller: usernameController,
                      // TODO: Make it so that user can tap on recommended username and that auto-fills it into the field.
                      errorText: usernameRecommendations.isEmpty
                          ? null
                          : "Uporabniško ime že obstaja."
                              "Tukaj je nekaj podobnih, med katerimi lahko izbirate: ${usernameRecommendations.join(", ")}",
                      validatorFunction:
                          Validators.requiredUsernameValidationHelper),
                  const SizedBox(height: 10),
                  CredentialTextField(
                    mainText: "Geslo",
                    isPassword: true,
                    controller: passController,
                    validatorFunction:
                        Validators.requiredPasswordValidationHelper,
                    allowObscureChange: true,
                    isPasswordVisible: isPasswordVisible,
                    onVisibilityTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CredentialTextField(
                    mainText: "Potrdi geslo",
                    isPassword: true,
                    controller: confirmPassController,
                    validatorFunction:
                        Validators.requiredPasswordValidationHelper,
                    allowObscureChange: true,
                    isPasswordVisible: isConfirmPasswordVisible,
                    onVisibilityTap: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (passController.text ==
                              confirmPassController.text) {
                            AlreadyExists? alreadyExists;
                            bool success;
                            (alreadyExists, success) = await ref
                                .read(authControllerProvider.notifier)
                                .register(
                                  context: context,
                                  email: emailController.text,
                                  username: usernameController.text,
                                  password: passController.text,
                                );
                            if (alreadyExists != null) {
                              setState(() {
                                usernameRecommendations =
                                    alreadyExists!.recommended_usernames;
                              });
                            }
                            if (success) GoRouter.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Geslo in potrditev gesla se ne ujemata!'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Registracija'),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Že imate račun?",
                        style: TextStyle(color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        child: const Text("Prijava"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
