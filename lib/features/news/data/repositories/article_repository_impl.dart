import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/news/data/datasources/article_remote_datasource.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:bloc_clean_arch/features/news/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource articleRemoteDatasource;

  ArticleRepositoryImpl({required this.articleRemoteDatasource});
  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      final result = await articleRemoteDatasource.fetchArticles();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
