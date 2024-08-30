import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobmatchr/constants/api.dart';
import 'package:jobmatchr/domain/repositories/authentication/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  LoginBloc() : super(LoginInitial()) {
    String email = '';
    String password = '';
    bool obscureText = false;

    on<LoadLogin>((event, emit) {
      emit(LoginUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<LoginUpdateEmail>((event, emit) {
      email = event.email;
      emit(LoginUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<LoginUpdatePassword>((event, emit) {
      password = event.password;
      emit(LoginUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<LoginObscurePassword>((event, emit) {
      obscureText = !obscureText;
      emit(LoginUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<SendLogin>((event, emit) async {
      emit(LoginLoading());
      ResponseModel response =
          await authenticationRepository.login(email, password);
      if (response.content != null) {
        emit(LoginComplete(uid: response.content));
      } else {
        email = '';
        password = '';
        obscureText = false;
        emit(BadCredentials());
      }
    });
  }
}
