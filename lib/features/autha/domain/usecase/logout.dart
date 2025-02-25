import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/autha/data/data_source/autha_local_service.dart';
import 'package:bloc_clean_arch/features/autha/domain/repository/autha_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';

class LogoutUsecasea extends UseCase<void, dynamic> {
  @override
  Future<void> call({dynamic param}) {
    return sl<AuthaRepository>().logout();
  }
}
