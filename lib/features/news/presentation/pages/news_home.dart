import 'package:bloc_clean_arch/features/news/presentation/cubit/cubit/article_cubit.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHomePage extends StatelessWidget {
  const NewsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticleCubit>()..fetchArticles(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('news'),
        ),
        body:
            BlocBuilder<ArticleCubit, ArticleState>(builder: (context, state) {
          if (state is ArticleInitialState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ArticleLoadSuccessState) {
            return Center(
              child: Text('data loaded'),
            );
          }
          if (state is ArticleLoadFailureState) {
            return Center(
              child: Text('loading error ${state.message}'),
            );
          }

          return Text('Eerro');
        }),
      ),
    );
  }
}
