import 'package:flutter/material.dart';

class CustomEmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool required;

  final String? labelText;
  final String? suffixText;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? minLength;

  const CustomEmailFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.required = true,
    this.labelText,
    this.suffixText,
    this.validator,
    this.maxLength,
    this.minLength,
  });

  bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    return RegExp(pattern).hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText ?? hintText,
        hintText: hintText,
        suffixText: suffixText,
      ),
      validator: (value) {
        final trimmedValue = value?.trim() ?? '';
        if (required && trimmedValue.isEmpty) {
          return 'This field is required';
        }
        if (minLength != null && trimmedValue.length < minLength!) {
          return 'Input must be at least $minLength characters long';
        }
        if (maxLength != null && trimmedValue.length > maxLength!) {
          return 'Input must not exceed $maxLength characters';
        }
        if (trimmedValue.isNotEmpty && !isValidEmail(trimmedValue)) {
          return 'Please enter a valid email address';
        }
        return validator != null ? validator!(trimmedValue) : null;
      },
    );
  }
}
