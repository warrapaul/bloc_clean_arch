import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/pages/dummy_post_details.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/pages/dummy_posts.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/pages/dummy_posts_home.dart';
import 'package:bloc_clean_arch/features/news/presentation/pages/news_home.dart';
import 'package:bloc_clean_arch/features/news/presentation/pages/news_search_home.dart';
import 'package:go_router/go_router.dart';

class NewsRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutePaths.newsEverything,
      path: AppRoutePaths.newsEverything,
      builder: (context, state) => const NewsHomePage(),
    ),
    GoRoute(
      name: AppRoutePaths.newsSearch,
      path: AppRoutePaths.newsSearch,
      builder: (context, state) => const NewsSearchHomePage(),
    ),
    GoRoute(
        path: AppRoutePaths.dummyPosts,
        name: AppRoutePaths.dummyPosts,
        builder: (context, state) => const DummyPostsPage()),
    GoRoute(
        path: AppRoutePaths.dummyPostDetail,
        name: AppRoutePaths.dummyPostDetailName,
        builder: (context, state) {
          final int postId = int.parse(state.pathParameters['id']!);
          return DummyPostDetailsPage(postId: postId);
        }),
    GoRoute(
        path: AppRoutePaths.dummyPostsHome,
        name: AppRoutePaths.dummyPostsHome,
        builder: (context, state) => const DummyPostsHomePage())

    // GoRoute(
    //   name: AppRoutePaths.dummyPosts,
    //   path: AppRoutePaths.dummyPosts,
    //   builder: (context, state) => DummyPostsPage(),
    // ),
    // GoRoute(
    //   name: AppRoutePaths.dummyPostDetail,
    //   path: AppRoutePaths.dummyPostDetail,
    //   builder: (context, state) {
    //     final postId = int.parse(state.pathParameters['id']!);
    //     return DummyPostDetailsPage(postId: postId);
    //   },
    // ),
  ];
}
