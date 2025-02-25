part of 'autha_cubit.dart';

@immutable
sealed class AuthaState {}

final class AuthaInitial extends AuthaState {}
final class AuthaenticatedState extends AuthaState{}
final class UnAuthaenticatedState extends AuthaState{}

