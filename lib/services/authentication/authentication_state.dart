part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoaded extends AuthenticationState {}

final class AuthenticationRegistration extends AuthenticationState {}

final class AuthenticationLogin extends AuthenticationState {}

final class LoggedIn extends AuthenticationState {
  final String uid;

  const LoggedIn({required this.uid});

  @override
  List<Object> get props => [uid];
}
