import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/dummy_post_tag_model.dart';
import 'package:dio/dio.dart';

abstract class DummyPostTagsDatasource {
  Future<List<DummyPostTagModel>> getDummyPostTags();
}

class DummyPostTagsDatasourceImpl extends DummyPostTagsDatasource {
  final DioClient dioClient;

  DummyPostTagsDatasourceImpl({required this.dioClient});
  @override
  Future<List<DummyPostTagModel>> getDummyPostTags() async {
    try {
      Response response = await dioClient.get(ApiUrlsConstants.dummyPostTags);
      List<dynamic> data = response.data;
      List<DummyPostTagModel> tagModel =
          data.map((json) => DummyPostTagModel.fromJson(json)).toList();
      return tagModel;
    } catch (e) {
      throw Exception('Error fetching tags ${e.toString()}');
    }
  }
}
