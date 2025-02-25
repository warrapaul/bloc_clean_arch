import 'package:bloc_clean_arch/core/network/dio_client.dart';
import 'package:bloc_clean_arch/core/network/socket_io_client.dart';
import 'package:bloc_clean_arch/core/theme/cubit/theme_cubit.dart';
import 'package:bloc_clean_arch/core/theme/repository/theme_repository.dart';
import 'package:bloc_clean_arch/features/auth/data/datasources/auth_datasource.dart';
import 'package:bloc_clean_arch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloc_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/is_logged_in.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/login.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/logout.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/signup.dart';
import 'package:bloc_clean_arch/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bloc_clean_arch/core/shared_preferences/auth_token_manager.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/datasources/chat_message_datasource.dart';
import 'package:bloc_clean_arch/features/chat_messaging/data/repositories/chat_message_repository_impl.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/repositories/chat_message_repository.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/connect_chat_message_socket.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/disconnect_chat_message_socket.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/fetch_previous_chat_messages.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/initialize_socket_connection.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/listen_to_chat_messages.dart';
import 'package:bloc_clean_arch/features/chat_messaging/domain/usecases/send_chat_message.dart';
import 'package:bloc_clean_arch/features/chat_messaging/presentation/bloc/chat_socket_bloc.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/datasources/dummy_post_tags_datasource.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/datasources/dummy_posts_datasource.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/repositories/dummy_post_tags_repository_impl.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/repositories/dummy_posts_repository_impl.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_repository.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/repositories/dummy_post_tags_repository.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_post_by_id.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_post_tags.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_posts.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_posts_by_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/search_dummy_posts.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/bloc/dummy_posts_search_bloc.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_post_tags/dummy_post_tags_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts/dummy_posts_cubit.dart';
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

  // ************ THEME *****************************
  sl.registerFactory<ThemeRepository>(
      () => ThemeRepository(sharedPreferences: sl<SharedPreferences>()));
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl<ThemeRepository>()));



  // ************ ONBOARDING FEATURE *****************************
  sl.registerSingleton<OnboardingLocalDataSource>(OnboardingLocalDataSourceImpl(
    sharedPreferences: sl<SharedPreferences>()));
  sl.registerSingleton<OnboardingRepository>(OnboardingRepositoryImpl(
      localDataSource: sl<OnboardingLocalDataSource>()));

  sl.registerSingleton<CheckOnboardingStatusUseCase>(
    CheckOnboardingStatusUseCase(repository: sl<OnboardingRepository>()));
  sl.registerSingleton<CompleteOnboardingUseCase>(
    CompleteOnboardingUseCase(repository: sl<OnboardingRepository>()));

  sl.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(
      checkOnboardingStatus: sl<CheckOnboardingStatusUseCase>(),
      completeOnboarding: sl<CompleteOnboardingUseCase>(),
    ),
  );

  // ************ AUTH FEATURE *****************************
  sl.registerSingleton<AuthDatasource>(AuthDatasourceImpl(
      dioClient: sl<DioClient>(), authTokenManager: sl<AuthTokenManager>()));
  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authDatasource: sl<AuthDatasource>()));

  sl.registerSingleton<IsLoggedInUsecase>(
      IsLoggedInUsecase(authRepository: sl<AuthRepository>()));
  sl.registerSingleton<LoginUsecase>(
      LoginUsecase(authRepository: sl<AuthRepository>()));
  sl.registerSingleton<LogoutUsecase>(
      LogoutUsecase(authRepository: sl<AuthRepository>()));
  sl.registerSingleton<SignupUsecase>(
      SignupUsecase(authRepository: sl<AuthRepository>()));

  sl.registerFactory<AuthCubit>(() => AuthCubit(
        isLoggedInUsecase: sl<IsLoggedInUsecase>(),
        loginUsecase: sl<LoginUsecase>(),
        logoutUsecase: sl<LogoutUsecase>(),
        signupUsecase: sl<SignupUsecase>(),
      ));




  //  REPOSITORIES
  sl.registerSingleton<UserApiService>(UserApiServiceImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<GetUserProfileUsecase>(GetUserProfileUsecase());

  // ************ NEWS FEATURE *****************************

  sl.registerSingleton<ArticleRemoteDatasource>(
      ArticleRemoteDatasourceImpl(dioClient: sl<DioClient>()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(
      articleRemoteDatasource: sl<ArticleRemoteDatasource>()));

  sl.registerSingleton<GetArticlesUseCase>(
      GetArticlesUseCase(articleRepository: sl<ArticleRepository>()));
  sl.registerSingleton<SearchArticlesUseCase>(
      SearchArticlesUseCase(articleRepository: sl<ArticleRepository>()));

  sl.registerFactory<ArticleCubit>(() => ArticleCubit(
        getArticlesUseCase: sl<GetArticlesUseCase>(),
        searchArticlesUseCase: sl<SearchArticlesUseCase>(),
      ));

  // ************ DUMMY POSTS FEATURE *****************************
  sl.registerSingleton<DummyPostsDatasource>(
      DummyPostsDatasourceImpl(dioClient: sl<DioClient>()));
  sl.registerSingleton<DummyPostRepository>(DummyPostsRepositoryImpl(
      dummyPostsDatasource: sl<DummyPostsDatasource>()));

  sl.registerSingleton<GetDummyPostsUseCase>(
      GetDummyPostsUseCase(dummyPostRepository: sl<DummyPostRepository>()));
  sl.registerSingleton<SearchDummyPostsUserCase>(
      SearchDummyPostsUserCase(dummyPostRepository: sl<DummyPostRepository>()));
  sl.registerSingleton<GetDummyPostByIdUseCase>(
      GetDummyPostByIdUseCase(dummyPostRepository: sl<DummyPostRepository>()));
  sl.registerSingleton<GetDummyPostsByTagUseCase>(GetDummyPostsByTagUseCase(
      dummyPostRepository: sl<DummyPostRepository>()));

  sl.registerFactory<DummyPostsCubit>(() => DummyPostsCubit(
        getDummyPostsUseCase: sl<GetDummyPostsUseCase>(),
        searchDummyPostsUserCase: sl<SearchDummyPostsUserCase>(),
        getDummyPostByIdUseCase: sl<GetDummyPostByIdUseCase>(),
        getDummyPostsByTagUseCase: sl<GetDummyPostsByTagUseCase>(),
      ));

  sl.registerFactory<DummyPostsSearchBloc>(() => DummyPostsSearchBloc(
        searchDummyPostsUserCase: sl<SearchDummyPostsUserCase>(),
      ));

  // ----------------dummy post tags
  sl.registerSingleton<DummyPostTagsDatasource>(
      DummyPostTagsDatasourceImpl(dioClient: sl<DioClient>()));
  sl.registerSingleton<DummyPostTagsRepository>(DummyPostTagsRepositoryImpl(
      dummyPostTagsDatasource: sl<DummyPostTagsDatasource>()));

  sl.registerSingleton<GetDummyPostTagsUseCase>(GetDummyPostTagsUseCase(
      dummyPostTagsRepository: sl<DummyPostTagsRepository>()));

  sl.registerFactory<DummyPostTagsCubit>(() => DummyPostTagsCubit(
        getDummyPostTagsUseCase: sl<GetDummyPostTagsUseCase>()));

  // ---------------- chat messages & sockets
  sl.registerSingleton<SocketIoClient>(
      SocketIoClient(tokenManager: sl<AuthTokenManager>()));

  sl.registerSingleton<ChatMessageDatasource>(ChatMessageDatasourceImpl(
      socketIoClient: sl<SocketIoClient>(), dioClient: sl<DioClient>()));

  sl.registerSingleton<ChatMessageRepository>(ChatMessageRepositoryImpl(
      chatMessageDatasource: sl<ChatMessageDatasource>()));

  sl.registerSingleton<ConnectChatMessageSocketUsecase>(
      ConnectChatMessageSocketUsecase(
          chatMessageRepository: sl<ChatMessageRepository>()));
  sl.registerSingleton<DisconnectChatMessageSocketUsecase>(
      DisconnectChatMessageSocketUsecase(
          chatMessageRepository: sl<ChatMessageRepository>()));
  sl.registerSingleton<FetchPreviousChatMessagesUsecase>(
      FetchPreviousChatMessagesUsecase(
          chatMessageRepository: sl<ChatMessageRepository>()));
  sl.registerSingleton<SendChatMessageSocketUsecase>(
      SendChatMessageSocketUsecase(
          chatMessageRepository: sl<ChatMessageRepository>()));
  sl.registerSingleton<ListenToChatMessagesUsecase>(ListenToChatMessagesUsecase(
      chatMessageRepository: sl<ChatMessageRepository>()));
  sl.registerSingleton<InitializeSocketConnectionUsecase>(
      InitializeSocketConnectionUsecase(
          chatMessageRepository: sl<ChatMessageRepository>()));

  sl.registerFactory<ChatSocketBloc>(() => ChatSocketBloc(
        sendChatMessageUsecase: sl<SendChatMessageSocketUsecase>(),
        disconnectChatMessageSocketUsecase:
            sl<DisconnectChatMessageSocketUsecase>(),
        connectChatMessageSocketUsecase: sl<ConnectChatMessageSocketUsecase>(),
        fetchPreviousChatMessagesUsecase:
            sl<FetchPreviousChatMessagesUsecase>(),
        listenToChatMessagesUsecase: sl<ListenToChatMessagesUsecase>(),
        initializeSocketConnectionUsecase:
            sl<InitializeSocketConnectionUsecase>(),
      ));
}
