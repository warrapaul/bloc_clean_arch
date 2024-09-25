import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/auth/data/model/signup_req_params.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase implements UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signUp(param!);
  }
}
