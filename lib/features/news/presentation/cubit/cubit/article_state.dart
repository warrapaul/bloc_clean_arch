part of 'article_cubit.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitialState extends ArticleState {}

final class ArticleLoadingState extends ArticleState {}

final class ArticleLoadSuccessState extends ArticleState {
  final List<Article> articles;

  ArticleLoadSuccessState({required this.articles});
}

final class ArticleLoadFailureState extends ArticleState {
  final String message;

  ArticleLoadFailureState({required this.message});
}
