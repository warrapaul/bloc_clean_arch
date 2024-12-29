import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/news/presentation/pages/news_home.dart';
import 'package:go_router/go_router.dart';

class NewsRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutePaths.newsEverything,
      path: AppRoutePaths.newsEverything,
      builder: (context, state) =>  NewsHomePage(),
      )
  ];
}
