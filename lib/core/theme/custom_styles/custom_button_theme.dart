
import 'package:bloc_clean_arch/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum ButtonSizesEnums { small, medium, large }

enum ButtonTypeEnums { primary, secondary, disabled, loading, outlined }

enum ButtonShapeEnums { normal, rounded }

class CustomButtonTheme {
  static const double roundedRadius = 18.0;
  static const double normalRadius = 8.0;

  static ButtonStyle buttonStyle({
    Color backgroundColor = AppColors.primaryColor,
    Color foregroundColor = Colors.white,
    double borderRadius = normalRadius,
    ButtonShapeEnums shape = ButtonShapeEnums.normal,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(backgroundColor),
      foregroundColor: WidgetStateProperty.all(foregroundColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              shape == ButtonShapeEnums.rounded ? roundedRadius : borderRadius),
        ),
      ),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    );
  }

  static TextStyle _buildTextStyle(double size, FontWeight weight) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      fontFamily: 'Roboto',
    );
  }

  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: buttonStyle(),
  );

  static final TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: buttonStyle(
      backgroundColor: const Color(0xFFE0E0E0),
      foregroundColor: const Color(0xFFCE93D8),
    ),
  );

  static final OutlinedButtonThemeData outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: buttonStyle(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryColor,
    ).copyWith(
      side: WidgetStateProperty.all(const BorderSide(color: AppColors.primaryColor)),
    ),
  );

  static const EdgeInsets smallPadding =
      EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const EdgeInsets mediumPadding =
      EdgeInsets.symmetric(vertical: 14, horizontal: 20);
  static const EdgeInsets largePadding =
      EdgeInsets.symmetric(vertical: 20, horizontal: 24);

  static final TextStyle smallTextStyle = _buildTextStyle(14, FontWeight.w500);
  static final TextStyle mediumTextStyle = _buildTextStyle(16, FontWeight.w500);
  static final TextStyle largeTextStyle = _buildTextStyle(18, FontWeight.w600);
}

// import 'package:flutter/material.dart';
// import 'package:styled_widgets/core/constants/app_colors.dart';

// enum ButtonSizesEnums { small, medium, large }
// enum ButtonSTypeEnums { primary, secondary, disabled, loading }
// enum ButtonShapeEnums { normal, rounded }

// class CustomButtonTheme {
//   static const double roundedRadius = 18.0;
//   static const double normalRadius = 8.0;

//   static ButtonStyle buttonStyle({
//     Color backgroundColor = AppColors.primaryColor,
//     Color foregroundColor = Colors.white,
//     double borderRadius = 8.0,
//   }) {
//     return ButtonStyle(
//       backgroundColor: MaterialStateProperty.all(backgroundColor),
//       foregroundColor: MaterialStateProperty.all(foregroundColor),
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//       padding: MaterialStateProperty.all(EdgeInsets.zero),
//     );
//   }

//   static TextStyle _buildTextStyle(double size, FontWeight weight) {
//     return TextStyle(
//       fontSize: size,
//       fontWeight: weight,
//       fontFamily: 'Roboto',
//     );
//   }

//   static final ElevatedButtonThemeData elevatedButtonTheme =
//       ElevatedButtonThemeData(
//     style: buttonStyle(),
//   );

//   static final TextButtonThemeData textButtonTheme = TextButtonThemeData(
//     style: buttonStyle(
//       // backgroundColor: Colors.transparent,
//       // foregroundColor: AppColors.primaryColor,
//       backgroundColor:Colors.grey.shade200,
//       foregroundColor: Colors.purple.shade300,
//     ),
//   );

//   static final OutlinedButtonThemeData outlinedButtonTheme =
//       OutlinedButtonThemeData(
//     style: buttonStyle(
//       backgroundColor: Colors.transparent,
//       foregroundColor: AppColors.primaryColor,
//     ).copyWith(
//       side:
//           MaterialStateProperty.all(BorderSide(color: AppColors.primaryColor)),
//     ),
//   );

//   static const EdgeInsets smallPadding =
//       EdgeInsets.symmetric(vertical: 8, horizontal: 16);
//   static const EdgeInsets mediumPadding =
//       EdgeInsets.symmetric(vertical: 14, horizontal: 20);
//   static const EdgeInsets largePadding =
//       EdgeInsets.symmetric(vertical: 20, horizontal: 24);

//   static final TextStyle smallTextStyle = _buildTextStyle(14, FontWeight.w500);
//   static final TextStyle mediumTextStyle = _buildTextStyle(16, FontWeight.w500);
//   static final TextStyle largeTextStyle = _buildTextStyle(18, FontWeight.w600);
// }

// class CustomButtonTheme {

//   static ButtonStyle _buildButtonStyle(
//       Color backgroundColor, Color foregroundColor) {
//     return ButtonStyle(
//       backgroundColor: WidgetStateProperty.all(backgroundColor),
//       foregroundColor: WidgetStateProperty.all(foregroundColor),
//       shape: WidgetStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//           // side: BorderSide(color: AppColors.primaryColor),
//         ),
//       ),
//       padding: WidgetStateProperty.all(EdgeInsets.zero),
//     );
//   }

//   static TextStyle _buildTextStyle(double size, FontWeight weight) {
//     return TextStyle(
//       fontSize: size,
//       fontWeight: weight,
//       fontFamily: 'Roboto',
//     );
//   }

//   static final ElevatedButtonThemeData elevatedButtonTheme =
//       ElevatedButtonThemeData(
//     style: _buildButtonStyle(AppColors.primaryColor, Colors.white),
//   );

//   static final TextButtonThemeData textButtonTheme = TextButtonThemeData(
//     style: _buildButtonStyle(Colors.transparent, AppColors.primaryColor),
//   );

//   static final OutlinedButtonThemeData outlinedButtonTheme =
//       OutlinedButtonThemeData(
//     style:
//         _buildButtonStyle(Colors.transparent, AppColors.primaryColor).copyWith(
//       side: WidgetStateProperty.all(BorderSide(color: AppColors.primaryColor)),
//     ),
//   );

//   static const EdgeInsets smallPadding =
//       EdgeInsets.symmetric(vertical: 8, horizontal: 16);
//   static const EdgeInsets mediumPadding =
//       EdgeInsets.symmetric(vertical: 14, horizontal: 20);
//   static const EdgeInsets largePadding =
//       EdgeInsets.symmetric(vertical: 20, horizontal: 24);

//   static final TextStyle smallTextStyle = _buildTextStyle(14, FontWeight.w500);
//   static final TextStyle mediumTextStyle = _buildTextStyle(16, FontWeight.w500);
//   static final TextStyle largeTextStyle = _buildTextStyle(18, FontWeight.w600);
// }


  // static TextStyle _buildButtonTextStyle(Color color, {double size = 16.0, FontWeight? weight}) {
  //   return TextStyle(
  //     color: color, 
  //     fontSize: size,
  //     fontWeight: weight,
  //     fontFamily: 'Roboto', 
  //   );
  // }

  // static OutlineInputBorder _buildButtonBorder(Color color) {
  //   return OutlineInputBorder(
  //     borderRadius: const BorderRadius.all(Radius.circular(20)),
  //     borderSide: BorderSide(color: color, width: 1.0),
  //   );
  // }


// static EdgeInsets _getButtonPadding(ButtonSizesEnums size) {
//     switch (size) {
//       case ButtonSizesEnums.small:
//         return const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
//       case ButtonSizesEnums.large:
//         return const EdgeInsets.symmetric(vertical: 20, horizontal: 24);
//       case ButtonSizesEnums.medium:
//       default:
//         return const EdgeInsets.symmetric(vertical: 14, horizontal: 20);
//     }
//   }
// static TextStyle _getButtonTextStyle(ButtonSizesEnums size) {
//     switch (size) {
//       case ButtonSizesEnums.small: TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
//       case ButtonSizesEnums.large:
//         return TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
//       case ButtonSizesEnums.medium:
//       default:
//         return TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
//     }
//   }




