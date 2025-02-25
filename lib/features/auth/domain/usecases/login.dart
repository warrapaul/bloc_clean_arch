import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/auth/data/models/login_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase extends UseCase<Either<ApiException, bool>, LoginReqDto> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});
  @override
  Future<Either<ApiException, bool>> call({required LoginReqDto param}) async {
    return await authRepository.login(param);
  }
}