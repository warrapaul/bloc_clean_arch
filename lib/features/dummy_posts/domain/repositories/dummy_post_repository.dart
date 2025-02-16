import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:dartz/dartz.dart';

abstract class DummyPostRepository {
  Future<Either<Failure, List<DummyPost>>> getDummyPosts(FilterDummyPostsReqParams param);
  Future<Either<Failure, List<DummyPost>>> searchDummyPosts(FilterDummyPostsReqParams param);
  Future<Either<Failure, DummyPost>> getDummyPostById(int id);
  Future<Either<Failure, List<DummyPost>>> getDummyPostsByTag(FilterDummyPostsReqParams param);

}
