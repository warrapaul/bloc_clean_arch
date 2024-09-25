import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/users/data/models/user_model.dart';
import 'package:bloc_clean_arch/features/users/domain/repository/user_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserProfileUsecase implements UseCase<Either<CustomNetworkException, UserModel>, dynamic> {
  @override
  Future<Either<CustomNetworkException, UserModel>> call({dynamic param}) {
    return sl<UserRepository>().getUserProfile();
  }
}
