import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/news/data/datasources/article_remote_datasource.dart';
import 'package:bloc_clean_arch/features/news/data/models/article_req_params.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource articleRemoteDatasource;

  ArticleRepositoryImpl({required this.articleRemoteDatasource});

  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      final articlesModels = await articleRemoteDatasource.fetchArticles();

      final List<Article> articles =
          articlesModels.map((model) => model.toEntity()).toList();

      return Right(articles);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchArticles(
      ArticleReqParams params) async {
    try {
      final articlesModels =
          await articleRemoteDatasource.searchArticles(params: params);
      final List<Article> articles =
          articlesModels.map((model) => model.toEntity()).toList();
      return Right(articles);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
