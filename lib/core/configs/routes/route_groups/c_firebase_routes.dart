import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/core/firebase/screens/notifications_page.dart';
import 'package:go_router/go_router.dart';

class CFirebaseRoutes {
  static List<GoRoute> routes = [
    GoRoute(
        name: AppRoutePaths.notifications,
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
        }),
  ];
}
