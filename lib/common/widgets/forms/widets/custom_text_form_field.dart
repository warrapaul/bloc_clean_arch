import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool required;

  final String? labelText;
  final String? suffixText;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? minLength; 
  final int? maxLines; 

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.required = true,
    this.labelText,
    this.suffixText,
    this.validator,
    this.maxLength,
    this.minLength, 
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLength: maxLength,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPrimary),
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
        return validator != null ? validator!(trimmedValue) : null;
      },
    );
  }
}
