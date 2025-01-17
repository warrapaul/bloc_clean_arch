import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/core/theme/custom_theme_data.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_post_tags/dummy_post_tags_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts/dummy_posts_cubit.dart';
import 'package:bloc_clean_arch/features/news/presentation/cubit/cubit/article_cubit.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..appStarted(),
        ),
        BlocProvider(
          create: (context) => sl<OnboardingCubit>()..checkStatus(),
        ),
        BlocProvider(
          create: (context) => sl<DummyPostsCubit>()..getDummyPosts(FilterDummyPostsReqParams()),
        ),
        BlocProvider(create: (context)=> sl<DummyPostTagsCubit>()..getDummyPostTags(),),

        BlocProvider(create: (context)=> sl<ArticleCubit>(),)
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData.themeData,
        routerConfig: AppRouter.router, // Just use the static router instance
      ),
    );
  }
}
