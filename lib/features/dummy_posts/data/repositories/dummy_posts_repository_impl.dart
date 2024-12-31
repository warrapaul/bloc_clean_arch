import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/datasources/dummy_posts_datasource.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/dummy_post_model.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_repository.dart';
import 'package:dartz/dartz.dart';

class DummyPostsRepositoryImpl implements DummyPostRepository {
  final DummyPostsDatasource dummyPostsDatasource;

  DummyPostsRepositoryImpl({required this.dummyPostsDatasource});

  @override
  Future<Either<Failure, List<DummyPost>>> getDummyPosts(
      FilterDummyPostsReqParams param) async {
    try {
      List<DummyPostModel> postModels =
          await dummyPostsDatasource.getDummyPosts(param);
      List<DummyPost> posts =
          postModels.map((postModel) => postModel.toEntity()).toList();
      return Right(posts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DummyPost>>> searchDummyPosts(
      FilterDummyPostsReqParams param) async {
    try {
      List<DummyPostModel> postModels =
          await dummyPostsDatasource.searchDummyPosts(param);
      List<DummyPost> posts =
          postModels.map((postModel) => postModel.toEntity()).toList();
      return Right(posts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DummyPost>> getDummyPostById(int id) async {
    try {
      DummyPostModel postModel =
          await dummyPostsDatasource.getDummyPostById(id);
      return Right(postModel.toEntity());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DummyPostTag>>> getDummyPostTags() {
    // TODO: implement getDummyPostTags
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DummyPost>>> getDummyPostsByTag() {
    // TODO: implement getDummyPostsByTag
    throw UnimplementedError();
  }
}
