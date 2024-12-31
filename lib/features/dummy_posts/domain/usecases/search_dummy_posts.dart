import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_repository.dart';
import 'package:dartz/dartz.dart';

class SearchDummyPostsUserCase extends UseCase<Either<Failure, List<DummyPost>>,
    FilterDummyPostsReqParams> {
  final DummyPostRepository dummyPostRepository;

  SearchDummyPostsUserCase({required this.dummyPostRepository});

  @override
  Future<Either<Failure, List<DummyPost>>> call(
      {required FilterDummyPostsReqParams param}) async {
    return await dummyPostRepository.searchDummyPosts(param);
  }
}
