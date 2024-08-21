import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmatchr/interface/landing_screen/nav_bar.dart';
import 'package:jobmatchr/interface/landing_screen/top_bar.dart';
import 'package:jobmatchr/interface/profile_screen/profile_search.dart';
import 'package:jobmatchr/services/navigation/navigation_bloc.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationLoaded) {
              return const SafeArea(
                child: Stack(
                  children: [
                    TopBar(),
                    AppNavBar(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 70.0, top: 60.0),
                      child: ProfileSwipeScreen(),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
