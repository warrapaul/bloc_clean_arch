import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(
          "https://plus.unsplash.com/premium_photo-1663840243136-825f46d64881?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
    );
  }
}
