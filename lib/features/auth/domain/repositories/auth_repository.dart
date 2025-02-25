import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/shared_preferences/shared_pref_exception.dart';
import 'package:bloc_clean_arch/features/auth/data/models/login_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/data/models/signup_req_dto.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<ApiException, bool>> signUp(SignupReqDto signupReqDto);
  Future<Either<ApiException, bool>> login(LoginReqDto loginReqDto);
  Future<Either<SharedPrefException, bool>>  logout();
  Future<Either<SharedPrefException, bool>>  isLoggedIn();
}
