import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmatchr/constants/ui_helper.dart';
import 'package:jobmatchr/services/navigation/navigation_bloc.dart';

const List<String> iconAssets = [
  "assets/icons/chat_icon.png",
  "assets/icons/swipe_icon.png",
  "assets/icons/profile_icon.png"
];

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationLoaded) {
            final NavigationIndex actualIndex = state.index;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: NavigationIndex.values.map((index) {
                  return GestureDetector(
                    onTap: () => context
                        .read<NavigationBloc>()
                        .add(ChangeIndex(navigationIndex: index)),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          iconAssets[index.index],
                          fit: BoxFit.contain,
                          color: actualIndex == index
                              ? Blue.lightenedButton
                              : Colors.white70,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
