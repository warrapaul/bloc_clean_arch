part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthenticatedState extends AuthState{}
final class UnAuthenticatedState extends AuthState{}

