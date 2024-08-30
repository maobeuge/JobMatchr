import 'package:jobmatchr/constants/api.dart';
import 'package:jobmatchr/domain/repositories/authentication/authentication_services.dart';

class AuthenticationRepository {
  AuthenticationServices authenticationServices = AuthenticationServices();

  Future<ResponseModel> login(final String email, final String password) async {
    return await authenticationServices.login(email, password);
  }

  Future<ResponseModel> register(
      final String email, final String password) async {
    return await authenticationServices.register(email, password);
  }
}
