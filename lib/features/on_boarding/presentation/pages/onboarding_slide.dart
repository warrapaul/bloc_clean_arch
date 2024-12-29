import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
           // Image.asset(imagePath,fit: BoxFit.contain,)

          ),
          const SizedBox(height: 32.0),
          Text(
            title,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}

