import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure,List<Article>>> getArticles();
}