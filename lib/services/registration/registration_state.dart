part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationUpdated extends RegistrationState {
  final String email;
  final String password;
  final bool obscureText;

  const RegistrationUpdated(
      {required this.email, required this.password, required this.obscureText});

  @override
  List<Object> get props => [email, password, obscureText];
}

final class RegistrationLoading extends RegistrationState {}

final class RegistrationComplete extends RegistrationState {}

final class RegistrationCompleteWithLogIn extends RegistrationState {
  final String uid;

  const RegistrationCompleteWithLogIn({required this.uid});

  @override
  List<Object> get props => [uid];
}

final class BadCredentials extends RegistrationState {}
