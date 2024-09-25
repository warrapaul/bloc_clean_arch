import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;


  const AuthInputField({
    super.key, required this.hintText, required this.controller,
  });
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ),
    );
  }
}
