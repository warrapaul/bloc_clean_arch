import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/users/data/data_source/user_api_service.dart';
import 'package:bloc_clean_arch/features/users/data/models/update_user_req_params.dart';
import 'package:bloc_clean_arch/features/users/data/models/user_model.dart';
import 'package:bloc_clean_arch/features/users/domain/repository/user_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiService _userApiService = sl<UserApiService>();

  @override
  Future<Either<CustomNetworkException, UserModel>> getUserProfile() async {
    return await _userApiService.getUserProfile();
  }

  @override
  Future<Either<CustomNetworkException, UserModel>> updateUserProfile(
      UpdateUserReqParams updateUserReqParams) async {
    return await _userApiService.updateUserProfile(updateUserReqParams);
  }
}
