import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color loadingColor;
  final double? width;
  final double height;
  final Widget? icon;
  final BorderRadius borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isRounded;

  // Predefined padding constants
  static const EdgeInsets smallPadding = EdgeInsets.symmetric(vertical: 5);
  static const EdgeInsets mediumPadding =
      EdgeInsets.symmetric(vertical: 4, horizontal: 16);
  static const EdgeInsets largePadding =
      EdgeInsets.symmetric(vertical: 20, horizontal: 24);

  const AppLoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.backgroundColor = AppColors.primaryColor,
    this.foregroundColor = Colors.white,
    this.loadingColor = Colors.white,
    this.width,
    this.height = 40.0,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.isRounded = true,
  });

  @override
  Widget build(BuildContext context) {
    // Determine padding based on isRounded
    final EdgeInsets padding = isRounded ? mediumPadding : smallPadding;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: isRounded
                ? BorderRadius.circular(height /2) // Fully rounded (pill shape)   - BorderRadius.circular(20)
                : borderRadius, // Custom rounded corners
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: loadingColor,
                  strokeWidth: 2.0,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) icon!,
                  if (icon != null) const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      fontFamily: 'Roboto',
                      color: foregroundColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
