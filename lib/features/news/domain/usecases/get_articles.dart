import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/news/data/repositories/article_repository_impl.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class GetArticlesUseCase {
  final ArticleRepository articleRepository;

  GetArticlesUseCase({required this.articleRepository});
  Future<Either<Failure, List<Article>>> call() async {
    return await articleRepository.getArticles();
  }
}
