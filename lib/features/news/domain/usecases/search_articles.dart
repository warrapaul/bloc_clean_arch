import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/news/data/models/article_req_params.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';


class SearchArticlesUseCase
    extends UseCase<Either<Failure, List<Article>>, ArticleReqParams> {
  final ArticleRepository articleRepository;

  SearchArticlesUseCase({required this.articleRepository});

  @override
  Future<Either<Failure, List<Article>>> call({required ArticleReqParams param}) async {
    return await articleRepository.searchArticles(param);
  }
}
