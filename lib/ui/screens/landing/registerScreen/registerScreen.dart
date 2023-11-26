import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/dto/alreadyExistsDto/alreadyExistsDto.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/state/authController.dart';
import 'package:laguna/ui/spacing/spacing.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landing_button.dart';
import 'package:laguna/routing/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
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
                  const Text("Registracija novega računa", style: TextStyle(fontSize: 30)),
                  verticalMargin32,
                  const RegisterForm(),
                  verticalMargin12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go(LoginRoute.path);
                        },
                        child: const Text("Že imam račun, nazaj na prijavo"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({
    super.key,
  });

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                verticalMargin16,
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
                verticalMargin16,
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
                verticalMargin16,
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
                verticalMargin20,
                LandingButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (passController.text == confirmPassController.text) {
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
                    text: "Registriraj me"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
