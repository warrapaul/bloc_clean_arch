import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/shared_preferences/auth_token_manager.dart';
import 'package:bloc_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:bloc_clean_arch/features/auth/data/models/login_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/data/models/signup_req_dto.dart';
import 'package:dio/dio.dart';

abstract class AuthDatasource {
  Future<AuthModel> signUp(SignupReqDto signupReqDto);
  Future<AuthModel> login(LoginReqDto loginReqDto);
  Future<bool> logout();
  Future<bool> isLoggedIn();
  Future<bool> saveToken(AuthModel authModel);
}

class AuthDatasourceImpl extends AuthDatasource {
  final DioClient dioClient;
  final AuthTokenManager authTokenManager;

  AuthDatasourceImpl({required this.dioClient, required this.authTokenManager});
  @override
  Future<bool> isLoggedIn() async {
    try {
      return await authTokenManager.hasToken();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await authTokenManager.deleteToken();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveToken(AuthModel authModel) async {
    try {
      return await authTokenManager.saveToken(authModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthModel> login(LoginReqDto loginReqDto) async {
    try {
      Response response = await dioClient.post(
        ApiUrlsConstants.loginUrl,
        data: loginReqDto.toJson(),
      );
      AuthModel authModel = AuthModel.fromJson(response.data);
      await saveToken(authModel);
      return authModel;
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(message: 'Error during login: ${e.toString()}');
    }
  }

  @override
  Future<AuthModel> signUp(SignupReqDto signupReqDto) async {
    try {
      Response response = await dioClient.post(
        ApiUrlsConstants.registerUrl,
        data: signupReqDto.toJson(),
      );
      AuthModel authModel = AuthModel.fromJson(response.data);
      await saveToken(authModel);
      return authModel;
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(message: 'Error during signUp: ${e.toString()}');
    }
  }
}
