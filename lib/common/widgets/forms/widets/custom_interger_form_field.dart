import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomIntegerFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool required;

  final String? labelText;
  final String? suffixText;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? minValue;
  final int? maxValue;

  const CustomIntegerFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.required = true,
    this.labelText,
    this.suffixText,
    this.validator,
    this.maxLength,
    this.minValue,
    this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText ?? hintText,
        hintText: hintText,
        suffixText: suffixText,
        counterText: ''
      ),
      
       validator: (value) {
        final trimmedValue = value?.trim() ?? '';
        if (required && trimmedValue.isEmpty) {
          return 'This field is required';
        }
        if (trimmedValue.isNotEmpty) {
          final intValue = int.tryParse(trimmedValue);
          if (intValue == null) {
            return 'Please enter a valid integer';
          }
          if (minValue != null && intValue < minValue!) {
            return 'Value must be at least $minValue';
          }
          if (maxValue != null && intValue > maxValue!) {
            return 'Value must not exceed $maxValue';
          }
        }
        return validator != null ? validator!(trimmedValue) : null;
      },
    );
  }
}
