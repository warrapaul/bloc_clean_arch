import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/auth/data/model/login_req_params.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase extends UseCase<Either, LoginReqParams> {
  @override
  Future<Either> call({LoginReqParams? param}) async {
    return await sl<AuthRepository>().login(param!);
  }
}
