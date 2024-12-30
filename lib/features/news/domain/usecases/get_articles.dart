import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class GetArticlesUseCase extends UseCase<Either<Failure,List<Article>>, dynamic>{
  final ArticleRepository articleRepository;

  GetArticlesUseCase({required this.articleRepository});

  @override
  Future<Either<Failure, List<Article>>> call({dynamic param}) async {
    return await articleRepository.getArticles();
  }
}
