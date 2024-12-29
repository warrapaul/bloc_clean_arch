import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/features/news/domain/entities/article.dart';
import 'package:dio/dio.dart';

abstract class ArticleRemoteDatasource {
  Future<List<Article>> fetchArticles();
}

class ArticleRemoteDatasourceImpl extends ArticleRemoteDatasource {
  final DioClient _dioClient;

  ArticleRemoteDatasourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;
  @override
  Future<List<Article>> fetchArticles() async {
    try {
      Response response = await _dioClient.get(ApiUrlsConstants.newsEverything);
      print(response);
      return [];
    } catch (e) {
      throw Exception('Error fetching articles: ${e.toString()}');
    }
  }
}
