import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/users/data/models/user_model.dart';
import 'package:bloc_clean_arch/features/users/domain/usecases/get_user_profile.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  void displayUserProfile() async {
    emit(UserProfileInitial());
    
    var result = await sl<GetUserProfileUsecase>().call();
    result.fold((error) {
      emit(UserProfileFailure(errorMessage: error.message));
    }, (data) {
      emit(UserProfileLoaded(user: data));
    });
  }
}
