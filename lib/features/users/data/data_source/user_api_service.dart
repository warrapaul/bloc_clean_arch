import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/users/data/models/update_user_req_params.dart';
import 'package:bloc_clean_arch/features/users/data/models/user_model.dart';
import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserApiService {
  Future<Either<ApiException, UserModel>> getUserProfile();
  Future<Either<ApiException, UserModel>> updateUserProfile(
      UpdateUserReqParams updateUserReqParams);
}

class UserApiServiceImpl extends UserApiService {
  @override
  Future<Either<ApiException, UserModel>> getUserProfile() async {
    try {
      Response response = await sl<DioClient>().get(
        ApiUrlsConstants.userProfileUrl,
      );
      final user = UserModel.fromJson(response.data);
      return Right(user);
    } catch (e) {
      print(e);
      return Left(e as ApiException);
    }
  }

  @override
  Future<Either<ApiException, UserModel>> updateUserProfile(
      UpdateUserReqParams updateUserReqParams) async {
    try {
      Response response = await sl<DioClient>().patch(
        ApiUrlsConstants.userUrl,
        data: updateUserReqParams.toJson(),
      );
      final updatedUser = UserModel.fromJson(response.data);
      return Right(updatedUser);
    } catch (e) {
      return Left(e as ApiException);
    }
  }
}
