import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  final String? labelText;
  final bool required;
  final int? minLength;

  const CustomPasswordFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.labelText,
    this.required = true,
    this.minLength = 8,
  });

  @override
  State<CustomPasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator:  widget.validator ?? _validatePassword,
      obscureText: _obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          labelText: widget.labelText ?? widget.hintText,
          helperText: '',
          hintText: widget.hintText,
          suffixIcon: IconButton(
              onPressed: _togglePasswordVisibility,
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ))),
    );
  }

  String? _validatePassword(String? value) {
    final trimmedValue = value?.trim() ?? '';
    if (widget.required && trimmedValue.isEmpty) {
      return 'This field is required';
    }
    if (widget.minLength != null && trimmedValue.length < widget.minLength!) {
      return 'Password must be at least ${widget.minLength} characters long';
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}
