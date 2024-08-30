import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmatchr/constants/ui_helper.dart';
import 'package:jobmatchr/interface/authentication_screen/login_form.dart';
import 'package:jobmatchr/interface/authentication_screen/registration_form.dart';
import 'package:jobmatchr/interface/authentication_screen/third_party_registration.dart';
import 'package:jobmatchr/services/authentication/authentication_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationRegistration) {
            return SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    children: [
                      Text(
                        "Créer ton compte",
                        style: GoogleFonts.outfit(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tu as déjà un compte?",
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: TextButton(
                                onPressed: () => context
                                    .read<AuthenticationBloc>()
                                    .add(const LogInAccount()),
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    minimumSize: const Size(40, 30)),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Blue.lightenedButton,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const RegistrationForm(),
                  const ThirdPartyRegistration(),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            );
          }

          if (state is AuthenticationLogin) {
            return SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    children: [
                      Text(
                        "Connecte toi à ton compte",
                        style: GoogleFonts.outfit(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tu n'as pas de compte?",
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: TextButton(
                                onPressed: () => context
                                    .read<AuthenticationBloc>()
                                    .add(const CreateAccount()),
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    minimumSize: const Size(40, 30)),
                                child: Text(
                                  "Créer le",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Blue.lightenedButton,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const LoginForm(),
                  const ThirdPartyRegistration(
                    isLogin: true,
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
