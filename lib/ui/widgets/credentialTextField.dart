import 'package:flutter/material.dart';
import 'package:laguna/helpers/validators.dart';

// TODO(zigapovhe): Do we need this?
class CredentialTextField extends StatefulWidget {
  final bool isPassword;
  final String mainText;
  final bool allowObscureChange;
  final bool isPasswordVisible;
  final AutovalidateMode autovalidateMode;
  final TextEditingController controller;
  final String? Function(String?)? validatorFunction;
  final Function()? onVisibilityTap;
  final Function(String)? onChanged;
  final bool enableValidator;

  const CredentialTextField({
    Key? key,
    required this.mainText,
    required this.isPassword,
    required this.validatorFunction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.allowObscureChange = false,
    this.isPasswordVisible = false,
    required this.controller,
    this.onVisibilityTap,
    this.onChanged,
    required this.enableValidator,
  }) : super(key: key);

  @override
  State<CredentialTextField> createState() => _CredentialTextFieldState();
}

class _CredentialTextFieldState extends State<CredentialTextField> {
  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (widget.isPasswordVisible) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }

    String? Function(String? input)? validatorFunction;
    if (widget.enableValidator == false) {
      validatorFunction = null;
    }

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextFormField(
        keyboardType: widget.isPassword
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        obscureText: widget.allowObscureChange && !widget.isPasswordVisible,
        autofillHints: widget.isPassword
            ? <String>[AutofillHints.password]
            : <String>[AutofillHints.email],
        autofocus: false,
        autocorrect: false,
        onChanged: widget.onChanged,
        controller: widget.controller,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            fillColor: Colors.black,
            labelText: widget.mainText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: const OutlineInputBorder(),
            suffixIcon:
                widget.onVisibilityTap != null && widget.allowObscureChange
                    ? IconButton(
                        onPressed: widget.onVisibilityTap,
                        icon: Icon(icon),
                      )
                    : null,
            errorStyle: const TextStyle(fontWeight: FontWeight.bold),
            errorMaxLines: 3),
        validator: widget.validatorFunction,
        autovalidateMode: widget.autovalidateMode,
      ),
    );
  }
}
