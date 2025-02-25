import 'package:bloc_clean_arch/core/shared_preferences/auth_token_manager.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/autha/data/data_source/autha_api_service.dart';
import 'package:bloc_clean_arch/features/autha/data/data_source/autha_local_service.dart';
import 'package:bloc_clean_arch/features/autha/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/autha/data/model/signup_req_params.dart';
import 'package:bloc_clean_arch/features/autha/domain/repository/autha_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthaRepositoryImpl implements AuthaRepository {
  final AuthaApiService _authApiService = sl<AuthaApiService>();
  final AuthaLocalService _authLocalService = sl<AuthaLocalService>();
  final AuthTokenManager _authTokenManager = sl<AuthTokenManager>();

  @override
  Future<Either<ApiException, dynamic>> signUp(
      SignupReqParams signupReqParams) async {
    Either<ApiException, dynamic> result =
        await _authApiService.signUp(signupReqParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      await _authTokenManager.saveToken(response.data['access_token']);
      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _authLocalService.isLoggedIn();
  }

  @override
  Future<void> logout() async {
    return await _authLocalService.logout();
  }

  @override
  Future<Either<ApiException, dynamic>> login(
      LoginReqParams loginReqParams) async {
    Either<ApiException, dynamic> result =
        await _authApiService.login(loginReqParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      await _authTokenManager.saveToken(response.data['access_token']);
      return Right(response);
    });
  }
}
