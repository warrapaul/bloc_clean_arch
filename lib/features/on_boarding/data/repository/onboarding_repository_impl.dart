import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/features/on_boarding/data/data_sources/onboarding_local_datasource.dart';
import 'package:bloc_clean_arch/features/on_boarding/domain/repository/onboarding_repository.dart';
import 'package:dartz/dartz.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});


  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      final result =
          await localDataSource.isOnboardingCompleted();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setOnboardingCompleted() async {
    try {
      await localDataSource.setOnboardingCompleted();
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
