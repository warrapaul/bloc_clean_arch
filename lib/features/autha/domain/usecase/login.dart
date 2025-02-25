import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/autha/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/autha/domain/repository/autha_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';

class LoginUsecasea extends UseCase<Either, LoginReqParams> {
  @override
  Future<Either> call({required LoginReqParams param}) async {
    return await sl<AuthaRepository>().login(param);
  }
}
