import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laguna/constants.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';

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
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: isWideScreen
                    ? BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(
                              1.0,
                              2.5,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 0.1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      )
                    : null,
                child: SizedBox(
                  width: isWideScreen ? screenWidth * 0.3 : screenWidth * 0.9,
                  height: isWideScreen ? screenHeight * 0.55 : null,
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
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (passController.text ==
                                          confirmPassController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Registracija uspešna!'),
                                          ),
                                        );
                                        GoRouter.of(context)
                                            .push(Constants.loginRoute);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                      GoRouter.of(context)
                                          .push(Constants.loginRoute);
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
              ),
            ),
          );
        },
      ),
    );
  }
}
