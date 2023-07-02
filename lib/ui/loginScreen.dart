import 'package:flutter/material.dart';
import 'package:laguna/ui/widgets/credentialTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPasswordVisible = false;

  // #docregion Example
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
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
                  ? BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(
                          1.0,
                          2.5,
                        ), //Offset
                        blurRadius: 5.0,
                        spreadRadius: 0.1,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ])
                  : null,
              child: SizedBox(
                width: isWideScreen ? screenWidth * 0.3 : screenWidth * 0.9,
                height: isWideScreen ? screenHeight * 0.6 : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Laguna Prijava", style: TextStyle(fontSize: 30, color: Colors.black)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                      child: Align(
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
                                  enableValidator: true),
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
                                  enableValidator: true),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      // If the form is valid, display a Snackbar.
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text('Validation successful, '
                                              'home screen not yet implemented')));
                                    }
                                  },
                                  child: const Text('Prijava'),
                                ),
                              ),
                            ],
                          ),
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
    ));
  }
}
