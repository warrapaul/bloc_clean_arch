import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class OnboardingRepository {
  Future<Either<Failure,bool>> isOnboardingCompleted();
  Future<Either<Failure, void>> setOnboardingCompleted();
}
