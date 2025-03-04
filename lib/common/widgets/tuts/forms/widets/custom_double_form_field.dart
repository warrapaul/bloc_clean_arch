import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDoubleFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool required;

  final String? labelText;
  final String? suffixText;
  final String? Function(String?)? validator;
  final int? maxLength;
  final double? minValue;
  final double? maxValue;
  final double? initialValue;

  const CustomDoubleFormField({
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
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
      ],
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText ?? hintText,
        hintText: hintText,
        suffixText: suffixText,
        counterText: '',
      ),
      validator: (value) {
        final trimmedValue = value?.trim() ?? '';
        if (required && trimmedValue.isEmpty) {
          return 'This field is required';
        }
        if (trimmedValue.isNotEmpty) {
          final doubleValue = double.tryParse(trimmedValue);
          if (doubleValue == null) {
            return 'Please enter a valid number';
          }
          if (minValue != null && doubleValue < minValue!) {
            return 'Value must be at least $minValue';
          }
          if (maxValue != null && doubleValue > maxValue!) {
            return 'Value must not exceed $maxValue';
          }
        }
        return validator != null ? validator!(trimmedValue) : null;
      },
    );
  }
}
