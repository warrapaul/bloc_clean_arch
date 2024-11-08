import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/auth/presentation/pages/login.dart';
import 'package:bloc_clean_arch/features/auth/presentation/pages/signup.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutePaths.login,
      path: AppRoutePaths.login,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: AppRoutePaths.signup,
      path: AppRoutePaths.signup,
      builder: (context, state) => SignupPage(),
    ),
    // GoRoute(
    //   name: AppRoutePaths.forgotPassword,
    //   path: AppRoutePaths.forgotPassword,
    //   builder: (context, state) => ForgotPasswordPage(),
    // ),
  ];
}
