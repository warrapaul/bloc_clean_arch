import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:dartz/dartz.dart';

abstract class DummyPostRepository {
  Future<Either<Failure, List<DummyPost>>> getDummyPosts(FilterDummyPostsReqParams param);
  Future<Either<Failure, List<DummyPost>>> searchDummyPosts(FilterDummyPostsReqParams param);
  Future<Either<Failure, DummyPost>> getDummyPostById(int id);
  Future<Either<Failure, List<DummyPostTag>>> getDummyPostTags();
  Future<Either<Failure, List<DummyPost>>> getDummyPostsByTag();

  // 'https://dummyjson.com/posts/tag/life'
  // 'https://dummyjson.com/posts/user/5'   //getDummyPostsByUser
  // 'https://dummyjson.com/posts/1/comments'  //getDummyPostComments
  // CRUD POSTS
}
