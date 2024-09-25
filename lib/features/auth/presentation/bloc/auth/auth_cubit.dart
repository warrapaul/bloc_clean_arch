import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecase/is_logged_in.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUsecase>().call();
    if (isLoggedIn) {
      emit(AuthenticatedState());
    } else {
      emit(UnAuthenticatedState());
    }
  }

  void loginSuccessful() {
    emit(AuthenticatedState());
  }

  void logout() {
    emit(UnAuthenticatedState());
  }
}
