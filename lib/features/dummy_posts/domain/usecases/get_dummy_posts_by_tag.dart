import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_repository.dart';
import 'package:dartz/dartz.dart';

class GetDummyPostsByTagUseCase extends UseCase<
    Either<Failure, List<DummyPost>>, FilterDummyPostsReqParams> {
  final DummyPostRepository dummyPostRepository;

  GetDummyPostsByTagUseCase({required this.dummyPostRepository});
  @override
  Future<Either<Failure, List<DummyPost>>> call(
      {required FilterDummyPostsReqParams param}) async {
    if (param.tag != null) {
      return await dummyPostRepository.getDummyPostsByTag(param);
    } else {
      // Handle case when tag is null, if necessary
      return Left(Failure(message: 'Tag is required'));
    }
  }
  // Future<Either<Failure, List<DummyPost>>> call(
  //     {required FilterDummyPostsReqParams param}) async {
  //   return await dummyPostRepository.getDummyPostsByTag(param);
  // }
}
