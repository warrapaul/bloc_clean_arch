import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/features/news/data/models/article_model.dart';
import 'package:bloc_clean_arch/features/news/data/models/article_req_params.dart';
import 'package:dio/dio.dart';

abstract class ArticleRemoteDatasource {
  Future<List<ArticleModel>> fetchArticles({String? searchPhrase});
  Future<List<ArticleModel>> searchArticles({required ArticleReqParams params});
}

class ArticleRemoteDatasourceImpl extends ArticleRemoteDatasource {
  final DioClient _dioClient;
  static const String defaultSearchPhrase = 'bitcoin';

  ArticleRemoteDatasourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;
  @override
  Future<List<ArticleModel>> fetchArticles({String? searchPhrase}) async {
    try {

      // q param is required
      final Map<String, dynamic> queryParams = {
        'q': searchPhrase ?? defaultSearchPhrase,
      };

      Response response = await _dioClient.get(
        ApiUrlsConstants.newsEverything,
        queryParameters: queryParams,
      );

      final List<dynamic> articlesJson = response.data['articles'];
      final List<ArticleModel> data =
          articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      return data;
    } catch (e) {
      throw Exception('Error fetching articles: ${e.toString()}');
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles({required ArticleReqParams params}) async {
    try {

      final Map<String, dynamic> queryParams = {
        'q': params.searchPhrase,
        'from': params.from,
        'to': params.to,
        'sortBy': params.sortBy,
        'page': params.page,
        'pageSize': params.pageSize,
      }..removeWhere(
          (key, value) => value == null); // Remove keys with null values

      Response response = await _dioClient.get(ApiUrlsConstants.newsEverything,
          queryParameters: queryParams);
      final List<dynamic> articlesJson = response.data['articles'];
      final List<ArticleModel> data =
          articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      return data;
    } catch (e) {
      throw Exception('Error searching articles: ${e.toString()}');
    }
  }
}
