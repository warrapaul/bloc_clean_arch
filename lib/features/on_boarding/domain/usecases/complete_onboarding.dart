import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/on_boarding/domain/repository/onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository repository;

  CompleteOnboardingUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.setOnboardingCompleted();
  }
}
