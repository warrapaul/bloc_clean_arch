import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/news/data/models/article_req_params.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/domain/usecases/get_articles.dart';
import 'package:bloc_clean_arch/features/news/domain/usecases/search_articles.dart';
import 'package:meta/meta.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final GetArticlesUseCase getArticlesUseCase;
  final SearchArticlesUseCase searchArticlesUseCase;

  ArticleCubit(
      {required this.searchArticlesUseCase, required this.getArticlesUseCase})
      : super(ArticleInitialState());

  Future<void> fetchArticles() async {
    emit(ArticleLoadingState());
    try {
      final result = await getArticlesUseCase();
      result.fold(
          (failure) => emit(ArticleLoadFailureState(message: failure.message)),
          (data) => emit(ArticleLoadSuccessState(articles: data)));
    } catch (e) {
      emit(ArticleLoadFailureState(message: e.toString()));
    }
  }

  Future<void> searchArticles(ArticleReqParams param) async {
    emit(ArticleLoadingState());
    try {
      final result = await searchArticlesUseCase(param: param);
      result.fold(
          (failure) => emit(ArticleLoadFailureState(message: failure.message)),
          (data) => emit(ArticleLoadSuccessState(articles: data)));
    } catch (e) {
      emit(ArticleLoadFailureState(message: e.toString()));
    }
  }
}
