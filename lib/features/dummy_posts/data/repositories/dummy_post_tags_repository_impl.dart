import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/datasources/dummy_post_tags_datasource.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/dummy_post_tag_model.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_tags_repository.dart';
import 'package:dartz/dartz.dart';

class DummyPostTagsRepositoryImpl extends DummyPostTagsRepository {
  final DummyPostTagsDatasource dummyPostTagsDatasource;

  DummyPostTagsRepositoryImpl({required this.dummyPostTagsDatasource});
  @override
  Future<Either<ApiException, List<DummyPostTag>>> getDummyPostTags() async {
    try {
      List<DummyPostTagModel> tagModels =
          await dummyPostTagsDatasource.getDummyPostTags();
      List<DummyPostTag> tags =
          tagModels.map((model) => model.toEntity()).toList();
      return Right(tags);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}


