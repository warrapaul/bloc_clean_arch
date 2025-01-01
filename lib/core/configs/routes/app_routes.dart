import 'package:bloc_clean_arch/common/pages/not_found.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/auth_routes.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/c_firebase_routes.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/c_widget_routes.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/news_routes.dart';
import 'package:bloc_clean_arch/core/configs/routes/route_groups/user_routes.dart';
import 'package:bloc_clean_arch/core/firebase/screens/notifications_page.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:bloc_clean_arch/features/home/presentation/pages/home.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/cubit/onboarding_state.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/**
 * pushNamed - add page to navigation stack, allowing to go back
 * goNamed - replace current page on navigation stack, does not allow users
 *            to go back - same as pushReplacement
 */

class AppRoutePaths {
  static const String onBoarding = '/onBoarding';

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
  static const List<String> publicRoutes = [
    login,
    signup,
    forgotPassword,
    notifications,
    onBoarding,

    // all news screens are public
    newsEverything,
    newsSearch,
    dummyPosts,
    dummyPostDetail,

  ];

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
  static const gridViewHome = '/gridViewHome';

  //firebase
  static const notifications = '/notifications';


  // newsApi routes
  static const newsEverything = '/everything';
  static const newsSearch = '/newsSearch';
  // dummy posts
  static const dummyPosts = '/dummy-posts';
  static const dummyPostDetail = '/dummy-posts/:id';
  static const dummyPostDetailName = 'dummy-posts-id';
  static const dummyPostsHome = '/dummy-posts-home';



  //home
  static const String initialRoute = dummyPostsHome; // home;

}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutePaths.initialRoute,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: <GoRoute>[
      GoRoute(
        name: AppRoutePaths.onBoarding,
        path: AppRoutePaths.onBoarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: AppRoutePaths.home,
        path: AppRoutePaths.home,
        builder: (context, state) => const HomePage(),
      ),
      ...AuthRoutes.routes,
      ...CWidgetRoutes.routes,
      ...UserRoutes.routes,
      ...CFirebaseRoutes.routes,
      //news api and dummy posts 
      ...NewsRoutes.routes,
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   final authCubit = context.read<AuthCubit>();
    //   final onboardingCubit = context.read<OnboardingCubit>();

    //   final bool isAuthenticated = authCubit.state is AuthenticatedState;
    //   final bool hasCompletedOnboarding =
    //       onboardingCubit.state is OnboardingCompleted;

    //   final bool isOnboardingRoute =
    //       state.matchedLocation == AppRoutePaths.onBoarding;
    //   final bool isLoginRoute = state.matchedLocation == AppRoutePaths.login;
    //   final bool isSignupRoute = state.matchedLocation == AppRoutePaths.signup;
    //   final bool isPublicRoute =
    //       AppRoutePaths.publicRoutes.contains(state.matchedLocation);

    //   // // TO DO: DELETE THIS GLOBAL OVERRIDE
    //   // return AppRoutePaths.initialRoute;

    //   // check onboarding status
    //   if (!hasCompletedOnboarding && !isOnboardingRoute) {
    //     return AppRoutePaths.onBoarding;
    //   }

    //   // CONTROL SCREENS THAT UNAUTHENTICATED USER CAN ACCESS (AuthInterceptor for routes)
    //   if (!isAuthenticated) {
    //     if (isPublicRoute) {
    //       // Allow access to public routes
    //       return null;
    //     }
    //     return AppRoutePaths.login; // Redirect to login for non-public routes
    //   }

    //   // Redirect authenticated users away from login/signup
    //   if (isAuthenticated && (isLoginRoute || isSignupRoute)) {
    //     return AppRoutePaths.initialRoute;
    //   }

    //   return null;
    // },
  );
}
