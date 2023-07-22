import 'package:flutter/material.dart';

/// A custom text field widget used for inputting credentials (email and password).
class CredentialTextField extends StatefulWidget {
  /// Indicates whether the field is for entering a password.
  final bool isPassword;

  /// The main text or label displayed above the text field.
  final String mainText;

  /// Allows changing the obscure text state of the password field.
  final bool allowObscureChange;

  /// Indicates whether the password is currently visible or hidden.
  final bool isPasswordVisible;

  /// Determines when validation is triggered for the text field.
  final AutovalidateMode autovalidateMode;

  /// The controller for the text field, used to interact with its value.
  final TextEditingController controller;

  /// The function that validates the input value of the text field.
  final String? Function(String?)? validatorFunction;

  /// The function called when the visibility icon is tapped (applicable for password fields).
  final Function()? onVisibilityTap;

  /// The function called when the text in the text field changes.
  final Function(String)? onChanged;

  /// Creates a [CredentialTextField] widget.
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
  }) : super(key: key);

  @override
  State<CredentialTextField> createState() => _CredentialTextFieldState();
}

class _CredentialTextFieldState extends State<CredentialTextField> {
  @override
  Widget build(BuildContext context) {
    // Determine the visibility icon based on the [isPasswordVisible] property.
    IconData icon;
    if (widget.isPasswordVisible) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextFormField(
        // Set the keyboard type based on [isPassword].
        keyboardType: widget.isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,

        // Set the obscureText property based on [allowObscureChange] and [isPasswordVisible].
        obscureText: widget.allowObscureChange && !widget.isPasswordVisible,

        // Set the autofill hints based on [isPassword].
        autofillHints: widget.isPassword ? <String>[AutofillHints.password] : <String>[AutofillHints.email],

        // Set other text field properties.
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
            suffixIcon: widget.onVisibilityTap != null && widget.allowObscureChange
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
