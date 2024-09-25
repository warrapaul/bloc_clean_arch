import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/features/auth/data/data_source/auth_api_service.dart';
import 'package:bloc_clean_arch/features/auth/data/data_source/auth_local_service.dart';
import 'package:bloc_clean_arch/core/network/auth_token_manager.dart';
import 'package:bloc_clean_arch/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecase/is_logged_in.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecase/logout.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecase/login.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecase/signup.dart';
import 'package:bloc_clean_arch/features/users/data/data_source/user_api_service.dart';
import 'package:bloc_clean_arch/features/users/data/repository/user_repository_impl.dart';
import 'package:bloc_clean_arch/features/users/domain/repository/user_repository.dart';
import 'package:bloc_clean_arch/features/users/domain/usecases/get_user_profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  // CORE
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  sl.registerSingleton<AuthTokenManager>(AuthTokenManager());
  sl.registerSingleton<DioClient>(DioClient());

  // SERVICES
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<UserApiService>(UserApiServiceImpl());

  //  REPOSITORIES
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());

  // USECASES
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  sl.registerSingleton<LogoutUsecase>(LogoutUsecase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<GetUserProfileUsecase>(GetUserProfileUsecase());
}
