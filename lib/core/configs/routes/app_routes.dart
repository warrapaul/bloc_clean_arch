import 'package:bloc_clean_arch/common/pages/not_found.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:bloc_clean_arch/features/auth/presentation/pages/login.dart';
import 'package:bloc_clean_arch/features/auth/presentation/pages/signup.dart';
import 'package:bloc_clean_arch/features/home/presentation/pages/home.dart';
import 'package:bloc_clean_arch/features/users/presentation/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
/**
 * pushNamed - add page to navigation stack, allowing to go back
 * goNamed - replace current page on navigation stack, does not allow users
 *            to go back - same as pushReplacement
 */
class AppRoutes {
  static const List<String> publicRoutes = [login, signup];

  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';

 
}

class AppRouter {
  static GoRouter createRouter(bool isAuthenticated) {
    return GoRouter(
      initialLocation: isAuthenticated ? AppRoutes.home : AppRoutes.login,
      errorBuilder: (context, state) => const NotFoundPage(),
      routes: [
        GoRoute(
          name: AppRoutes.home,
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: AppRoutes.login,
          path: AppRoutes.login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          name: AppRoutes.signup,
          path: AppRoutes.signup,
          builder: (context, state) => SignupPage(),
        ),
        GoRoute(
          name: AppRoutes.profile,
          path: AppRoutes.profile,
          builder: (context, state) => const UserProfilePage(),
        ),
      ],

       redirect: (BuildContext context, GoRouterState state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        final bool isAuthenticated = authCubit.state is AuthenticatedState;
        final bool isLoginRoute = state.matchedLocation == AppRoutes.login;
        final bool isSignupRoute = state.matchedLocation == AppRoutes.signup;

        // If not authenticated and trying to access a protected route
        if (!isAuthenticated &&
            !AppRoutes.publicRoutes.contains(state.matchedLocation)) {
          return AppRoutes.login;
        }

        // If authenticated and trying to access login or signup
        if (isAuthenticated && (isLoginRoute || isSignupRoute)) {
          return AppRoutes.home;
        }

        return null; // No redirection needed
      },

    );
  }
}
