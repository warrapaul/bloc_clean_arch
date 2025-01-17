import 'package:bloc_clean_arch/core/network/auth_token_manager.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/auth/data/data_source/auth_api_service.dart';
import 'package:bloc_clean_arch/features/auth/data/data_source/auth_local_service.dart';
import 'package:bloc_clean_arch/features/auth/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/auth/data/model/signup_req_params.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService = sl<AuthApiService>();
  final AuthLocalService _authLocalService = sl<AuthLocalService>();
  final AuthTokenManager _authTokenManager = sl<AuthTokenManager>();

  @override
  Future<Either<CustomNetworkException, dynamic>> signUp(
      SignupReqParams signupReqParams) async {
    Either<CustomNetworkException, dynamic> result =
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
  Future<Either<CustomNetworkException, dynamic>> login(
      LoginReqParams loginReqParams) async {
    Either<CustomNetworkException, dynamic> result =
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
