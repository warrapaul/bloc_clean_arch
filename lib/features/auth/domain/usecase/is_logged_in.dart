import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';

class IsLoggedInUsecase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async{
    return await sl<AuthRepository>().isLoggedIn();
  }
}
