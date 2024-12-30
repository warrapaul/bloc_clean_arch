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
import 'package:bloc_clean_arch/features/news/data/datasources/article_remote_datasource.dart';
import 'package:bloc_clean_arch/features/news/data/repositories/article_repository_impl.dart';
import 'package:bloc_clean_arch/features/news/domain/repositories/article_repository.dart';
import 'package:bloc_clean_arch/features/news/domain/usecases/get_articles.dart';
import 'package:bloc_clean_arch/features/news/domain/usecases/search_articles.dart';
import 'package:bloc_clean_arch/features/news/presentation/cubit/cubit/article_cubit.dart';
import 'package:bloc_clean_arch/features/on_boarding/data/data_sources/onboarding_local_datasource.dart';
import 'package:bloc_clean_arch/features/on_boarding/data/repository/onboarding_repository_impl.dart';
import 'package:bloc_clean_arch/features/on_boarding/domain/repository/onboarding_repository.dart';
import 'package:bloc_clean_arch/features/on_boarding/domain/usecases/check_onboarding_status.dart';
import 'package:bloc_clean_arch/features/on_boarding/domain/usecases/complete_onboarding.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/cubit/onboarding_cubit.dart';
import 'package:bloc_clean_arch/features/users/data/data_source/user_api_service.dart';
import 'package:bloc_clean_arch/features/users/data/repository/user_repository_impl.dart';
import 'package:bloc_clean_arch/features/users/domain/repository/user_repository.dart';
import 'package:bloc_clean_arch/features/users/domain/usecases/get_user_profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void setUpServiceLocator(
    {required SharedPreferences sharedPreferences,
    required FlutterSecureStorage secureStorage}) {
  // CORE
  // ********* Register SharedPreferences with the initialized instance
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  sl.registerSingleton<AuthTokenManager>(AuthTokenManager());
  sl.registerSingleton<DioClient>(DioClient());

  // SERVICES

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<UserApiService>(UserApiServiceImpl());
  // TO DO: pass dependencies via constructor
  // sl.registerSingleton<AuthApiService>(
  //   AuthApiServiceImpl(
  //     dioClient: sl<DioClient>(),
  //   ),
  // );

  // sl.registerSingleton<UserApiService>(
  //   UserApiServiceImpl(
  //     dioClient: sl<DioClient>(),
  //   ),
  // );

  // DATASOURCES
  sl.registerSingleton<OnboardingLocalDataSource>(OnboardingLocalDataSourceImpl(
    sharedPreferences: sl<SharedPreferences>(),
  ));

  //  REPOSITORIES
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<OnboardingRepository>(OnboardingRepositoryImpl(
      localDataSource: sl<OnboardingLocalDataSource>()));

  //================ USECASES
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  sl.registerSingleton<LogoutUsecase>(LogoutUsecase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<GetUserProfileUsecase>(GetUserProfileUsecase());
  // onboarding usecases
  sl.registerSingleton<CheckOnboardingStatusUseCase>(
    CheckOnboardingStatusUseCase(
      repository: sl<OnboardingRepository>(),
    ),
  );

  sl.registerSingleton<CompleteOnboardingUseCase>(
    CompleteOnboardingUseCase(
      repository: sl<OnboardingRepository>(),
    ),
  );

  // ============= CUBITS
  sl.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(
      checkOnboardingStatus: sl<CheckOnboardingStatusUseCase>(),
      completeOnboarding: sl<CompleteOnboardingUseCase>(),
    ),
  );


  // ************ NEWS FEATURE *****************************

  sl.registerSingleton<ArticleRemoteDatasource>(
      ArticleRemoteDatasourceImpl(dioClient: sl<DioClient>()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(
      articleRemoteDatasource: sl<ArticleRemoteDatasource>()));

  sl.registerSingleton<GetArticlesUseCase>(
      GetArticlesUseCase(articleRepository: sl<ArticleRepository>()));
  
  sl.registerSingleton<SearchArticlesUseCase>(
      SearchArticlesUseCase(articleRepository: sl<ArticleRepository>()));  

  sl.registerFactory<ArticleCubit>(()=>ArticleCubit(
    getArticlesUseCase: sl<GetArticlesUseCase>(),
    searchArticlesUseCase: sl<SearchArticlesUseCase>(),
  ));
}
