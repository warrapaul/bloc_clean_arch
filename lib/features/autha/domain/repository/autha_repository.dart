import 'package:bloc_clean_arch/features/autha/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/autha/data/model/signup_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthaRepository {
  Future<Either> signUp(SignupReqParams signupReqParams);
  Future<bool> isLoggedIn();
  Future<void> logout();
  Future<Either> login(LoginReqParams loginReqParams);
}
