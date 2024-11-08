import 'package:flutter/material.dart';

class ImageAsset extends StatelessWidget {
  const ImageAsset({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/techd.jpg',
      height: 400,
      width: 400,
    );
  }
}
