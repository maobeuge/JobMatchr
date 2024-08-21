import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmatchr/interface/landing_screen/nav_bar.dart';
import 'package:jobmatchr/interface/landing_screen/top_bar.dart';
import 'package:jobmatchr/interface/message_screen/message_screen.dart';
import 'package:jobmatchr/interface/profile_screen/profile_screen.dart';
import 'package:jobmatchr/interface/swipe_screen/profile_search.dart';
import 'package:jobmatchr/services/navigation/navigation_bloc.dart';

const List<Widget> screenList = [
  MessageScreen(),
  ProfileSwipeScreen(),
  ProfileScreen()
];

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageViewController =
        PageController(initialPage: NavigationIndex.swipe.index);

    return BlocProvider(
      create: (context) =>
          NavigationBloc(pageViewController: pageViewController),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationLoaded) {
              return SafeArea(
                child: Stack(
                  children: [
                    const TopBar(),
                    const AppNavBar(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70.0, top: 60.0),
                      child: PageView.builder(
                        controller: pageViewController,
                        itemCount: NavigationIndex.values.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return screenList[index];
                        },
                      ),
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
