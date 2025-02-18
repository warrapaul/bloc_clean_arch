import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/auth/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/auth/data/model/signup_req_params.dart';
import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthApiService {
  Future<Either<ApiException, dynamic>> signUp(
      SignupReqParams signupReqParams);
  Future<Either<ApiException, dynamic>> login(
      LoginReqParams loginReqParams);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either<ApiException, dynamic>> signUp(
      SignupReqParams signupReqParams) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrlsConstants.registerUrl,
        data: signupReqParams.toJson(),
      );
      return Right(response);
    } catch (e) {
      return Left(e as ApiException);
    }
  }

  @override
  Future<Either<ApiException, dynamic>> login(
      LoginReqParams loginReqParams) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiUrlsConstants.loginUrl, data: loginReqParams.toJson());
      return Right(response);
    } catch (e) {
      return Left(e as ApiException);
    }
  }
}
