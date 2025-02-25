import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/autha/data/model/signup_req_params.dart';
import 'package:bloc_clean_arch/features/autha/domain/repository/autha_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignupUsecasea implements UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthaRepository>().signUp(param!);
  }
}
