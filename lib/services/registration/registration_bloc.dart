import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobmatchr/constants/api.dart';
import 'package:jobmatchr/domain/repositories/authentication/authentication_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  RegistrationBloc() : super(RegistrationInitial()) {
    String email = '';
    String password = '';
    bool obscureText = false;

    on<LoadRegistration>((event, emit) {
      emit(RegistrationUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<RegistrationUpdateEmail>((event, emit) {
      email = event.email;
      emit(RegistrationUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<RegistrationUpdatePassword>((event, emit) {
      password = event.password;
      emit(RegistrationUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<RegistrationObscurePassword>((event, emit) {
      obscureText = !obscureText;
      emit(RegistrationUpdated(
          email: email, password: password, obscureText: obscureText));
    });

    on<SendRegistration>((event, emit) async {
      if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(email) &&
          RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
              .hasMatch(password)) {
        emit(RegistrationLoading());
        final ResponseModel responseModel =
            await authenticationRepository.register(email, password);
        if (responseModel.content != null) {
          final ResponseModel loginResponse =
              await authenticationRepository.login(email, password);
          if (loginResponse.content != null) {
            emit(RegistrationCompleteWithLogIn(uid: loginResponse.content));
          } else {
            emit(RegistrationComplete());
          }
        } else {
          emit(BadCredentials());
        }
      } else {
        emit(BadCredentials());
      }
    });
  }
}
