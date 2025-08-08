part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String password;
  final String username;

  AuthSignUp({required this.password, required this.username});
}

final class AuthLogin extends AuthEvent {
  final String password;
  final String username;

  AuthLogin({required this.password, required this.username});
}

final class AuthCheckLoggedIn extends AuthEvent {}

final class AuthSignOut extends AuthEvent {}

final class AuthResetForm extends AuthEvent {}
