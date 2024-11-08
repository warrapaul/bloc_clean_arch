import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/users/presentation/pages/user_profile.dart';
import 'package:go_router/go_router.dart';

class UserRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      name: 'profile',
      path: AppRoutePaths.profile,
      builder: (context, state) => const UserProfilePage(),
      // routes: [
      //   // Nested route for edit profile
      //   GoRoute(
      //     name: 'editProfile',
      //     path: 'edit',
      //     builder: (context, state) => const EditProfilePage(),
      //   ),
      // ],
    ),
    // GoRoute(
    //   name: 'settings',
    //   path: AppRoutePaths.settings,
    //   builder: (context, state) => const SettingsPage(),
    // ),
  ];
}
