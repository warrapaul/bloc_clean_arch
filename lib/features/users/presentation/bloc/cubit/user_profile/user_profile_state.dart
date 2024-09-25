part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  final UserModel user;

  UserProfileLoaded({required this.user});
}

final class UserProfileFailure extends UserProfileState {
  final String errorMessage;

  UserProfileFailure({required this.errorMessage});
}
