import 'package:bloc_clean_arch/core/shared_preferences/shared_pref_exception.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase extends UseCase<Either<SharedPrefException, bool>, dynamic> {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});
  @override
  Future<Either<SharedPrefException, bool>> call({required dynamic param}) async {
    return await authRepository.logout();
  }
}
