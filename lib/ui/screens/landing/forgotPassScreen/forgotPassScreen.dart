import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/helpers/validators.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landingBox.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Pozabljeno geslo",
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
                              mainText: "Email",
                              isPassword: false,
                              validatorFunction: Validators.requiredEmailValidationHelper,
                              controller: emailController),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // TODO: Implement reset password logic
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Email za ponastavitev gesla je bil poslan.'),
                                    ),
                                  );

                                  // Clear the email field
                                  emailController.clear();
                                }
                              },
                              child: const Text('Pošlji email'),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Se spomnite gesla?",
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
