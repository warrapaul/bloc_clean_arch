import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/auth/data/data_source/auth_local_service.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';

class LogoutUsecase extends UseCase<void, dynamic> {
  @override
  Future<void> call({dynamic param}) {
    return sl<AuthRepository>().logout();
  }
}
