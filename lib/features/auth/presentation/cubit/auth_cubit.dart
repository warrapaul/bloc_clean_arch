import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/auth/data/models/login_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/data/models/signup_req_dto.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/is_logged_in.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/login.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/logout.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/signup.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsLoggedInUsecase isLoggedInUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final SignupUsecase signupUsecase;
  AuthCubit({
    required this.isLoggedInUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.signupUsecase,
  }) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    final result = await isLoggedInUsecase(param: null);
    result.fold(
      (failure) => emit(AuthenticationError(message: failure.toString())),
      (isLoggedIn) =>
          isLoggedIn ? emit(Authenticated()) : emit(UnAuthenticated()),
    );
  }

  Future<void> login(LoginReqDto loginReqDto) async {
    emit(AuthLoading());
    final result = await loginUsecase(param: loginReqDto);
    result.fold(
        (failure) => emit(AuthenticationError(message: failure.message)),
        (_) => emit(Authenticated()));
  }

  Future<void> signup(SignupReqDto signupReqDto) async {
    emit(AuthLoading());
    final result = await signupUsecase(param: signupReqDto);
    result.fold(
        (failure) => emit(AuthenticationError(message: failure.message)),
        (_) => emit(Authenticated()));
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await logoutUsecase(param: null);
    result.fold(
      (failure) => emit(AuthenticationError(message: failure.toString())),
      (_) => emit(UnAuthenticated()),
    );
  }
}
