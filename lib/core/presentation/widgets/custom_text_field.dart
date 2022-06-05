import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  const CustomTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.onChanged,
    this.validator,
    this.textInputType,
    this.obscureText = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      keyboardType: textInputType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
