part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {}

final class UnAuthenticated extends AuthState {}

final class AuthenticationError extends AuthState {
  final String message;

  AuthenticationError({required this.message});
}
