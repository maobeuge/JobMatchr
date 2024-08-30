part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginUpdated extends LoginState {
  final String email;
  final String password;
  final bool obscureText;

  const LoginUpdated(
      {required this.email, required this.password, required this.obscureText});

  @override
  List<Object> get props => [email, password, obscureText];
}

final class LoginLoading extends LoginState {}

final class LoginComplete extends LoginState {
  final String uid;

  const LoginComplete({required this.uid});

  @override
  List<Object> get props => [uid];
}

final class BadCredentials extends LoginState {}
