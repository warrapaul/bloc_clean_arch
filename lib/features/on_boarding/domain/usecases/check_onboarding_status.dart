import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/on_boarding/domain/repository/onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class CheckOnboardingStatusUseCase {
  final OnboardingRepository repository;

  CheckOnboardingStatusUseCase({required this.repository});
  Future<Either<Failure, bool>> call() async {
    return await repository.isOnboardingCompleted();
  }
}


