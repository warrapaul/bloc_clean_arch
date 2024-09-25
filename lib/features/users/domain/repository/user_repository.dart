import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/users/data/models/update_user_req_params.dart';
import 'package:bloc_clean_arch/features/users/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<CustomNetworkException, UserModel>>  getUserProfile();
  Future<Either<CustomNetworkException, UserModel>> updateUserProfile(UpdateUserReqParams updateUserReqParams);
}
