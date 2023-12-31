import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/ui/spacing/spacing.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landing_button.dart';
import 'package:laguna/routing/routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(children: [
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
                    const Text(
                      "Pozabljeno geslo",
                      style: TextStyle(fontSize: 30),
                    ),
                    verticalMargin32,
                    const ForgotPasswordForm(),
                    verticalMargin12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).go(LoginRoute.path);
                            // GoRouter.of(context).pop();
                          },
                          child: const Text("Vem geslo, nazaj na prijavo"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CredentialTextField(
              mainText: "Email",
              isPassword: false,
              validatorFunction: Validators.requiredEmailValidationHelper,
              controller: emailController),
          verticalMargin20,
          LandingButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Email za ponastavitev gesla je bil uspešno poslan.')));
                  emailController.clear();
                }
              },
              text: 'Pošlji email za ponastavitev gesla'),
        ],
      ),
    );
  }
}
