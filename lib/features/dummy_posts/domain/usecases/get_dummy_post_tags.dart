import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_tags_repository.dart';
import 'package:dartz/dartz.dart';

class GetDummyPostTagsUseCase
    extends UseCase<Either<ApiException, List<DummyPostTag>>, dynamic> {
  final DummyPostTagsRepository dummyPostTagsRepository;

  GetDummyPostTagsUseCase({required this.dummyPostTagsRepository});
  @override
  Future<Either<ApiException, List<DummyPostTag>>> call({dynamic param}) {
    return dummyPostTagsRepository.getDummyPostTags();
  }
}
