import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/autha/domain/usecase/is_logged_in.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:meta/meta.dart';

part 'autha_state.dart';

class AuthaCubit extends Cubit<AuthaState> {
  AuthaCubit() : super(AuthaInitial());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUsecasea>().call();
    if (isLoggedIn) {
      emit(AuthaenticatedState());
    } else {
      emit(UnAuthaenticatedState());
    }
  }

  void loginSuccessful() {
    emit(AuthaenticatedState());
  }

  void logout() {
    emit(UnAuthaenticatedState());
  }
}
