import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/dummy_post_model.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/dummy_post_tag_model.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:dio/dio.dart';

abstract class DummyPostsDatasource {
  Future<List<DummyPostModel>> getDummyPosts(FilterDummyPostsReqParams param);
  Future<List<DummyPostModel>> searchDummyPosts(
      FilterDummyPostsReqParams param);
  Future<DummyPostModel> getDummyPostById(int id);
  Future<List<DummyPostModel>> getDummyPostsByTag(
      FilterDummyPostsReqParams param);
}

class DummyPostsDatasourceImpl implements DummyPostsDatasource {
  final DioClient dioClient;
  DummyPostsDatasourceImpl({required this.dioClient});

  @override
  Future<List<DummyPostModel>> getDummyPosts(
      FilterDummyPostsReqParams param) async {
    try {
      Map<String, dynamic> parameters = {
        'limit': param.pageSize,
        'skip': param.page,
        'sortBy': param.sortBy,
        'order': param.sortOrder,
      }..removeWhere((key, value) => value == null);

      Response response = await dioClient.get(ApiUrlsConstants.dummyPosts,
          queryParameters: parameters);
      List<dynamic> jsonData = response.data['posts'];
      List<DummyPostModel> dummyPostModels =
          jsonData.map((json) => DummyPostModel.fromJson(json)).toList();
      return dummyPostModels;
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
          message: 'Error fetching dummy posts: ${e.toString()}');
    }
  }

  @override
  Future<List<DummyPostModel>> searchDummyPosts(
      FilterDummyPostsReqParams param) async {
    try {
      Map<String, dynamic> parameters = {
        'limit': param.pageSize,
        'skip': param.page,
        'sortBy': param.sortBy,
        'order': param.sortOrder,
        'q': param.searchPhrase,
      }..removeWhere((key, value) => value == null);
      Response response = await dioClient.get(
        ApiUrlsConstants.searchDummyPosts,
        queryParameters: parameters,
      );
      List<dynamic> jsonData = response.data['posts'];
      List<DummyPostModel> dummyPostModels =
          jsonData.map((json) => DummyPostModel.fromJson(json)).toList();
      return dummyPostModels;
    } catch (e) {
      throw Exception('Error searching dummy posts ${e.toString()}');
    }
  }

  @override
  Future<DummyPostModel> getDummyPostById(int id) async {
    try {
      Response response =
          await dioClient.get('${ApiUrlsConstants.dummyPosts}/$id');
      return DummyPostModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error fetching dummy post by id: ${e.toString()}');
    }
  }

  @override
  Future<List<DummyPostModel>> getDummyPostsByTag(
      FilterDummyPostsReqParams param) async {
    try {
      Map<String, dynamic> parameters = {
        'limit': param.pageSize,
        'skip': param.page,
        'sortBy': param.sortBy,
        'order': param.sortOrder,
      }..removeWhere((key, value) => value == null);

      Response response = await dioClient.get(
          '${ApiUrlsConstants.dummyPostByTag}/${Uri.encodeComponent(param.tag ?? '')}',
          queryParameters: parameters);
      List<dynamic> jsonData = response.data['posts'];
      List<DummyPostModel> dummyPostModels =
          jsonData.map((json) => DummyPostModel.fromJson(json)).toList();
      return dummyPostModels;
    } catch (e) {
      throw Exception('Error fetching posts by tag: ${e.toString()}');
    }
  }
}
