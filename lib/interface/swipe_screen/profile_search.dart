import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmatchr/domain/entities/profile.dart';
import 'package:jobmatchr/services/profiles/profiles_bloc.dart';
import 'profile_card.dart';

class ProfileSwipeScreen extends StatelessWidget {
  const ProfileSwipeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ProfilesBloc()..add(LoadProfiles()),
          child: BlocBuilder<ProfilesBloc, ProfilesState>(
            builder: (context, state) {
              if (state is ProfilesLoaded) {
                final List<Profile> profiles = state.profiles;
                if (state.profiles.isNotEmpty) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Stack(
                          children: profiles.map((profile) {
                            return ProfileCard(profiles: profiles);
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text(
                    "No more profiles to swipe!",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
