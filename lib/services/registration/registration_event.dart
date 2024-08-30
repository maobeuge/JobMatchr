part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

final class LoadRegistration extends RegistrationEvent {}

final class RegistrationUpdateEmail extends RegistrationEvent {
  final String email;

  const RegistrationUpdateEmail({required this.email});

  @override
  List<Object> get props => [email];
}

final class RegistrationUpdatePassword extends RegistrationEvent {
  final String password;

  const RegistrationUpdatePassword({required this.password});

  @override
  List<Object> get props => [password];
}

final class RegistrationObscurePassword extends RegistrationEvent {
  final bool obscureText;

  const RegistrationObscurePassword({required this.obscureText});

  @override
  List<Object> get props => [obscureText];
}

final class SendRegistration extends RegistrationEvent {}
