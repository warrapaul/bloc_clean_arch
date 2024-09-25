import 'package:bloc_clean_arch/features/auth/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/auth/data/model/signup_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignupReqParams signupReqParams);
  Future<bool> isLoggedIn();
  Future<void> logout();
  Future<Either> login(LoginReqParams loginReqParams);
}
