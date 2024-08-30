part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class LoadAuthentication extends AuthenticationEvent {
  const LoadAuthentication();

  @override
  List<Object> get props => [];
}

final class CreateAccount extends AuthenticationEvent {
  const CreateAccount();

  @override
  List<Object> get props => [];
}

final class LogInAccount extends AuthenticationEvent {
  const LogInAccount();

  @override
  List<Object> get props => [];
}

final class LogInWithUid extends AuthenticationEvent {
  final String uid;

  const LogInWithUid({required this.uid});

  @override
  List<Object> get props => [uid];
}
