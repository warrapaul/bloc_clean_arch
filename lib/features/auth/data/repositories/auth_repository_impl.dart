import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/shared_preferences/shared_pref_exception.dart';
import 'package:bloc_clean_arch/features/auth/data/datasources/auth_datasource.dart';
import 'package:bloc_clean_arch/features/auth/data/models/login_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/data/models/signup_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({required this.authDatasource});

  @override
  Future<Either<SharedPrefException, bool>> isLoggedIn() async {
    try {
      bool isLoggedIn = await authDatasource.isLoggedIn();
      return Right(isLoggedIn);
    } catch (e) {
      return Left(e as SharedPrefException);
    }
  }

  @override
  Future<Either<SharedPrefException, bool>> logout() async {
    try {
      bool loggedOut = await authDatasource.logout();
      return Right(loggedOut);
    } catch (e) {
      return Left(e as SharedPrefException);
    }
  }

  @override
  Future<Either<ApiException, bool>> login(LoginReqDto loginReqDto) async {
    try {
      await authDatasource.login(loginReqDto);
      return const Right(true);
    } catch (e) {
      return Left(e as ApiException);
    }
  }

  @override
  Future<Either<ApiException, bool>> signUp(SignupReqDto signupReqDto) async {
    try {
      await authDatasource.signUp(signupReqDto);
      return const Right(true);
    } catch (e) {
      return Left(e as ApiException);
    }
  }
}
