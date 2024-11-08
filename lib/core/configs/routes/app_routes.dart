import 'package:bloc_clean_arch/common/pages/not_found.dart';
import 'package:bloc_clean_arch/common/pages/tests/test1.dart';
import 'package:bloc_clean_arch/common/pages/tests/test2.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/auth_routes.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/c_firebase_routes.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/c_widget_routes.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/user_routes.dart';
import 'package:bloc_clean_arch/core/firebase/screens/notifications_page.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:bloc_clean_arch/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/**
 * pushNamed - add page to navigation stack, allowing to go back
 * goNamed - replace current page on navigation stack, does not allow users
 *            to go back - same as pushReplacement
 */

class AppRoutePaths {

  // Auth Routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Home Routes
  static const String home = '/';
  static const String dashboard = '/dashboard';

  // User Routes
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String editProfile = '/profile/edit';

  // List of public routes that don't require authentication
  static const List<String> publicRoutes = [login, signup, forgotPassword, notifications];

  // c widgets
  static const cWidgets = '/cWidgets';
  static const basicForm1 = '/basicForm1';
  static const testOne = '/testOne';
  static const dialogHome = '/dialogHome';
  static const buttonHome = '/buttonHome';
  static const customBadge = '/customBadge';
  static const basicTabBars = '/basicTabBars';
  static const imagesHome = '/imagesHome';
  static const bottomSheetHome = '/bottomSheetHome';
  static const shimmerHome = '/shimmerHome';
  static const crouselSlider = '/crouselSlider';

  //firebase
  static const notifications = '/notifications';

  //tests
  static const test1 = '/test1';
  static const test2 = '/test2';
}






class AppRouter {
  static GoRouter? _router;
  static GoRouter get router {
      if (_router == null) {
        throw Exception('Router has not been initialized!');
      }
      return _router!;
    }

  static void initializeRouter(bool? isAuthenticated) {
     _router = GoRouter(
      // initialLocation:isAuthenticated ? AppRoutePaths.home : AppRoutePaths.login,
      initialLocation: isAuthenticated == true ? AppRoutePaths.home : AppRoutePaths.login,

      errorBuilder: (context, state) => const NotFoundPage(),
      routes: <GoRoute>[
        GoRoute(
          path: '/test1',
          builder: (BuildContext context, GoRouterState state) => const Test1(),
        ),
        GoRoute(
          path: '/test2/:id',
          builder: (BuildContext context, GoRouterState state) => Test2(
            id: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          // name: AppRoutePaths.notifications,
          path: AppRoutePaths.notifications,
          builder: (context, state) {
            final arguments = state.extra as Map<String, dynamic>? ?? {};
            final title = arguments['title'] as String?;
            final body = arguments['body'] as String?;
            final data = arguments['data'] as Map<String, dynamic>?;

            return NotificationsPage(
              title: title,
              body: body,
              data: data,
            );
          },
        ),
        GoRoute(
          name: AppRoutePaths.home,
          path: AppRoutePaths.home,
          builder: (context, state) => const HomePage(),
        ),
        ...AuthRoutes.routes,
        ...CWidgetRoutes.routes,
        ...UserRoutes.routes,
        ...CFirebaseRoutes.routes
      ],
      
      redirect: (BuildContext context, GoRouterState state) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        final bool isAuthenticated = authCubit.state is AuthenticatedState;
        final bool isLoginRoute = state.matchedLocation == AppRoutePaths.login;
        final bool isSignupRoute =
            state.matchedLocation == AppRoutePaths.signup;

        if (!isAuthenticated &&
            !AppRoutePaths.publicRoutes.contains(state.matchedLocation)) {
          return AppRoutePaths.login;
        }

        if (isAuthenticated && (isLoginRoute || isSignupRoute)) {
          return AppRoutePaths.home;
        }

        return null;
      },
    );
  }
}
