import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  //execute the usecase on button click
  void execute({dynamic params, required UseCase usecase}) async {
    try {
      emit(ButtonLoading());
      // await Future.delayed(const Duration(seconds: 3));
      Either<CustomNetworkException, dynamic> result =
          await usecase.call(param: params);
      result.fold((error) {
        // emit(ButtonFailure(errorMessage: error.message));
        emit(ButtonFailure(errorMessage: error.message));

      }, (data) {
        emit(ButtonSucess());
      });
    } catch (e) {
      emit(ButtonFailure(errorMessage: e.toString()));
    }
  }
}
