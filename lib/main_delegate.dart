import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmatchr/firebase_options.dart';
import 'package:jobmatchr/interface/authentication_screen/authentication_screen.dart';
import 'package:jobmatchr/interface/landing_screen/landing_screen.dart';
import 'package:jobmatchr/services/authentication/authentication_bloc.dart';

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) =>
            AuthenticationBloc()..add(const LoadAuthentication()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is LoggedIn) {
              return const LandingScreen();
            }
            return const AuthenticationScreen();
          },
        ),
      ),
    );
  }
}
