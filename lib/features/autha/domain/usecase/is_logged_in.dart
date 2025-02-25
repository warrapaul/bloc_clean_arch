import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:bloc_clean_arch/features/autha/domain/repository/autha_repository.dart';
import 'package:bloc_clean_arch/service_locator.dart';

class IsLoggedInUsecasea extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async{
    return await sl<AuthaRepository>().isLoggedIn();
  }
}
