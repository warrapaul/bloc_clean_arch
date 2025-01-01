import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:dartz/dartz.dart';

abstract class DummyPostTagsRepository {
  Future<Either<Failure, List<DummyPostTag>>> getDummyPostTags();
  
}
