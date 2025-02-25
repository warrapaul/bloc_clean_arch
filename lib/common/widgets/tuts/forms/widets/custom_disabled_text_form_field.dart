import 'package:flutter/material.dart';

class CustomDisabledTextFormField extends StatelessWidget {
  final String value; 

  const CustomDisabledTextFormField({
    super.key,
    required this.value, // Pass the value to be displayed
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value, 
      enabled: false,
    );
  }
}
