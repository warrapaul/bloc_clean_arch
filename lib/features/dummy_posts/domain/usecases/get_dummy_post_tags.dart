import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_tags_repository.dart';
import 'package:dartz/dartz.dart';

class GetDummyPostTagsUseCase
    extends UseCase<Either<Failure, List<DummyPostTag>>, dynamic> {
  final DummyPostTagsRepository dummyPostTagsRepository;

  GetDummyPostTagsUseCase({required this.dummyPostTagsRepository});
  @override
  Future<Either<Failure, List<DummyPostTag>>> call({dynamic param}) {
    return dummyPostTagsRepository.getDummyPostTags();
  }
}
