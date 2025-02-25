import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/auth/data/models/signup_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase extends UseCase<Either<ApiException, bool>, SignupReqDto> {
  final AuthRepository authRepository;

  SignupUsecase({required this.authRepository});
  @override
  Future<Either<ApiException, bool>> call({required SignupReqDto param}) async {
    return await authRepository.signUp(param);
  }
}
