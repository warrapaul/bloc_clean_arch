import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_repository.dart';
import 'package:dartz/dartz.dart';

class GetDummyPostByIdUseCase extends UseCase<Either<Failure, DummyPost>, int> {
  final DummyPostRepository dummyPostRepository;

  GetDummyPostByIdUseCase({required this.dummyPostRepository});
  @override
  Future<Either<Failure, DummyPost>> call({required int param}) async {
    return dummyPostRepository.getDummyPostById(param);
  }
}
