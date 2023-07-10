import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';
import 'package:laguna/ui/widgets/landingBox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              isWideScreen: isWideScreen,
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
                            controller: emailController,
                            enableValidator: true,
                          ),
                          const SizedBox(height: 10),
                          CredentialTextField(
                            mainText: "Geslo",
                            isPassword: true,
                            controller: passController,
                            allowObscureChange: true,
                            isPasswordVisible: isPasswordVisible,
                            onVisibilityTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            enableValidator: true,
                          ),
                          const SizedBox(height: 10),
                          CredentialTextField(
                            mainText: "Potrdi geslo",
                            isPassword: true,
                            controller: confirmPassController,
                            enableValidator: true,
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
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (passController.text == confirmPassController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Registracija uspešna!'),
                                      ),
                                    );
                                    GoRouter.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Geslo in potrditev gesla se ne ujemata!'),
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
