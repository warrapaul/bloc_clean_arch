import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_repository.dart';
import 'package:dartz/dartz.dart';

class GetDummyPostsUseCase extends UseCase<
    Either<ApiException, List<DummyPost>>, FilterDummyPostsReqParams> {
  final DummyPostRepository dummyPostRepository;

  GetDummyPostsUseCase({required this.dummyPostRepository});
  @override
  Future<Either<ApiException, List<DummyPost>>> call(
      {required FilterDummyPostsReqParams param}) async {
    return await dummyPostRepository.getDummyPosts(param);
  }
}
