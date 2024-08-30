import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmatchr/constants/ui_helper.dart';
import 'package:jobmatchr/services/authentication/authentication_bloc.dart';
import 'package:jobmatchr/services/registration/registration_bloc.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');

    return BlocProvider(
      create: (context) => RegistrationBloc()..add(LoadRegistration()),
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state is RegistrationCompleteWithLogIn) {
            print("logged in");
            Future.delayed(Duration.zero);
            context
                .read<AuthenticationBloc>()
                .add(LogInWithUid(uid: state.uid));
            return Container();
          }

          if (state is RegistrationComplete) {
            print("not logged in");
            Future.delayed(Duration.zero);
            context.read<AuthenticationBloc>().add(const LogInAccount());
            return Container();
          }

          if (state is RegistrationUpdated || state is RegistrationLoading) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => context
                        .read<RegistrationBloc>()
                        .add(RegistrationUpdateEmail(email: value)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Grey.swipeButton,
                      focusColor: Grey.swipeButton,
                      filled: true,
                      labelText: "Email",
                      floatingLabelStyle: GoogleFonts.outfit(
                        color: Blue.lightenedButton,
                        fontSize: 16,
                      ),
                      labelStyle: GoogleFonts.outfit(
                        fontSize: 16,
                      ),
                    ),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    cursorColor: Blue.lightenedButton.withOpacity(.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: TextFormField(
                      onChanged: (value) => context
                          .read<RegistrationBloc>()
                          .add(RegistrationUpdatePassword(password: value)),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: Grey.swipeButton,
                        focusColor: Grey.swipeButton,
                        filled: true,
                        labelText: "Mot de passe",
                        floatingLabelStyle: GoogleFonts.outfit(
                          color: Blue.lightenedButton,
                          fontSize: 16,
                        ),
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 16,
                        ),
                      ),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      cursorColor: Blue.lightenedButton.withOpacity(.5),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Mot de passe oublié",
                          style: GoogleFonts.outfit(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: state is RegistrationLoading
                        ? const Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () => context
                                .read<RegistrationBloc>()
                                .add(SendRegistration()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Blue.lightenedButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Continuer",
                                style: GoogleFonts.outfit(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            );
          }

          if (state is BadCredentials) {
            emailController.clear();
            passwordController.clear();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    onChanged: (value) => context
                        .read<RegistrationBloc>()
                        .add(RegistrationUpdateEmail(email: value)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Grey.swipeButton,
                      focusColor: Grey.swipeButton,
                      filled: true,
                      labelText: "Email",
                      floatingLabelStyle: GoogleFonts.outfit(
                        color: Blue.lightenedButton,
                        fontSize: 16,
                      ),
                      labelStyle: GoogleFonts.outfit(
                        fontSize: 16,
                      ),
                    ),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    cursorColor: Blue.lightenedButton.withOpacity(.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: TextFormField(
                      controller: passwordController,
                      onChanged: (value) => context
                          .read<RegistrationBloc>()
                          .add(RegistrationUpdatePassword(password: value)),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: Grey.swipeButton,
                        focusColor: Grey.swipeButton,
                        filled: true,
                        labelText: "Mot de passe",
                        floatingLabelStyle: GoogleFonts.outfit(
                          color: Blue.lightenedButton,
                          fontSize: 16,
                        ),
                        labelStyle: GoogleFonts.outfit(
                          fontSize: 16,
                        ),
                      ),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      cursorColor: Blue.lightenedButton.withOpacity(.5),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Mot de passe oublié",
                          style: GoogleFonts.outfit(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () => context
                          .read<RegistrationBloc>()
                          .add(SendRegistration()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Blue.lightenedButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Continuer",
                          style: GoogleFonts.outfit(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
