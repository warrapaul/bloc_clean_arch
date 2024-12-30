import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/presentation/cubit/cubit/article_cubit.dart';
import 'package:bloc_clean_arch/features/news/presentation/widgets/news_card.dart';
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
          return switch (state) {
            ArticleLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            ArticleLoadSuccessState() => ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, int index) {
                  final Article article = state.articles[index];
                  return NewsCard(
                    article: article,
                  );
                },
              ),
            ArticleLoadFailureState() =>  Center(
                child: Text('loading error ${state.message}'),
              ),
              _ => const SizedBox()
          };

         
        }),
      ),
    );
  }
}
