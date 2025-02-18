import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:dartz/dartz.dart';

abstract class DummyPostRepository {
  Future<Either<ApiException, List<DummyPost>>> getDummyPosts(
      FilterDummyPostsReqParams param);
  Future<Either<ApiException, List<DummyPost>>> searchDummyPosts(
      FilterDummyPostsReqParams param);
  Future<Either<ApiException, DummyPost>> getDummyPostById(int id);
  Future<Either<ApiException, List<DummyPost>>> getDummyPostsByTag(
      FilterDummyPostsReqParams param);
}
