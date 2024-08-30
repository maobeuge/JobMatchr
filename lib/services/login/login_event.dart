part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoadLogin extends LoginEvent {}

final class LoginUpdateEmail extends LoginEvent {
  final String email;

  const LoginUpdateEmail({required this.email});

  @override
  List<Object> get props => [email];
}

final class LoginUpdatePassword extends LoginEvent {
  final String password;

  const LoginUpdatePassword({required this.password});

  @override
  List<Object> get props => [password];
}

final class LoginObscurePassword extends LoginEvent {
  final bool obscureText;

  const LoginObscurePassword({required this.obscureText});

  @override
  List<Object> get props => [obscureText];
}

final class SendLogin extends LoginEvent {}
