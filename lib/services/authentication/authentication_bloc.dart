import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<LoadAuthentication>((event, emit) {
      emit(AuthenticationLogin());
    });

    on<LogInAccount>((event, emit) {
      emit(AuthenticationLogin());
    });

    on<CreateAccount>((event, emit) {
      emit(AuthenticationRegistration());
    });

    on<LogInWithUid>((event, emit) {
      emit(LoggedIn(uid: event.uid));
    });
  }
}
