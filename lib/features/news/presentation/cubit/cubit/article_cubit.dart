import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/domain/usecases/get_articles.dart';
import 'package:meta/meta.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;
  ArticleCubit({required this.getArticlesUseCase})
      : super(ArticleInitialState());

  Future<void> fetchArticles() async {
    try {
      final result = await getArticlesUseCase();
      result.fold(
          (failure) => emit(ArticleLoadFailureState(message: failure.message)),
          (data) => emit(ArticleLoadSuccessState(articles: data)));
    } catch (e) {
      emit(ArticleLoadFailureState(message: e.toString()));
    }
  }
}
