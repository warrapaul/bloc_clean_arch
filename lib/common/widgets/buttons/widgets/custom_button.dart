import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:bloc_clean_arch/core/theme/custom_button_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonSizesEnums size;
  final ButtonTypeEnums type;
  final ButtonShapeEnums shape;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.size = ButtonSizesEnums.small,
    this.type = ButtonTypeEnums.primary,
    this.shape = ButtonShapeEnums.normal,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed:
            (isLoading || type == ButtonTypeEnums.disabled) ? null : onPressed,
        style: _getButtonStyle(),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    return Padding(
      padding: _getPadding(),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  type == ButtonTypeEnums.outlined
                      ? AppColors.primaryColor
                      : Colors.white,
                ),
              ),
            )
          : Text(text, style: _getTextStyle()),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonTypeEnums.secondary:
        return CustomButtonTheme.buttonStyle(
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: Colors.white,
          shape: shape,
        );
      case ButtonTypeEnums.outlined:
        return CustomButtonTheme.buttonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primaryColor,
          shape: shape,
        ).copyWith(
          side: WidgetStateProperty.all(
              BorderSide(color: AppColors.primaryColor)),
        );
      case ButtonTypeEnums.disabled:
        return CustomButtonTheme.buttonStyle(
          backgroundColor: AppColors.disabledBackground,
          foregroundColor: AppColors.disabledForeground,
          shape: shape,
        );
      case ButtonTypeEnums.primary:
      case ButtonTypeEnums.loading:
      default:
        return CustomButtonTheme.buttonStyle(shape: shape);
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSizesEnums.small:
        return CustomButtonTheme.smallPadding;
      case ButtonSizesEnums.medium:
      default:
        return CustomButtonTheme.mediumPadding;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSizesEnums.small:
        return CustomButtonTheme.smallTextStyle;
      case ButtonSizesEnums.medium:
      default:
        return CustomButtonTheme.mediumTextStyle;
    }
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSizesEnums.small:
        return 36;
      case ButtonSizesEnums.medium:
      default:
        return 48;
    }
  }
}
