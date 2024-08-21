import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmatchr/constants/ui_helper.dart';
import 'package:jobmatchr/domain/entities/experience.dart';
import 'package:jobmatchr/domain/entities/profile.dart';
import 'package:jobmatchr/interface/swipe_screen/availability_tag.dart';
import 'package:jobmatchr/services/profiles/profiles_bloc.dart';
import 'package:jobmatchr/services/swipe/swipe_bloc.dart';

class ProfileCard extends StatelessWidget {
  final List<Profile> profiles;

  const ProfileCard({required this.profiles, super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: profiles
          .map(
            (profile) => profiles.last.id == profile.id
                ? buildFrontCard(profile: profile, screenSize: screenSize)
                : buildCard(profile: profile),
          )
          .toList(),
    );
  }

  Widget buildFrontCard(
          {required final Profile profile, required final Size screenSize}) =>
      BlocProvider(
        create: (context) =>
            SwipeBloc(profile: profile, screenSize: screenSize),
        child: BlocBuilder<SwipeBloc, SwipeState>(
          builder: (context, state) {
            if (state is DeleteProfile) {
              Future.delayed(const Duration(seconds: 0));
              context
                  .read<ProfilesBloc>()
                  .add(RemoveProfile(profileId: profile.id));
              context.read<SwipeBloc>().add(const LoadSwipe());
            }

            if (state is SwipeLoaded) {
              final Offset position = state.position;
              final double angle = state.angle;
              final bool isDragging = state.isDragging;

              return Stack(
                children: [
                  GestureDetector(
                    child: LayoutBuilder(builder: (context, constraints) {
                      final int milliseconds = isDragging ? 0 : 400;
                      final EdgeInsets margin = isDragging
                          ? const EdgeInsets.all(24)
                          : EdgeInsets.zero;
                      final Offset center =
                          constraints.smallest.center(Offset.zero);
                      final double convertedAngle = angle * pi / 180;
                      final rotatedMatrix = Matrix4.identity()
                        ..translate(center.dx, center.dy)
                        ..rotateZ(convertedAngle)
                        ..translate(-center.dx, -center.dy);

                      return AnimatedContainer(
                        margin: margin,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: milliseconds),
                        transform: rotatedMatrix
                          ..translate(position.dx, position.dy),
                        child: buildCard(profile: profile, isFront: true),
                      );
                    }),
                    onPanStart: (details) => context
                        .read<SwipeBloc>()
                        .add(StartSwipe(profileId: profile.id)),
                    onPanUpdate: (details) {
                      context.read<SwipeBloc>().add(
                            UpdateSwipe(details: details),
                          );
                    },
                    onPanEnd: (details) {
                      context.read<SwipeBloc>().add(const EndSwipe());
                    },
                  ),
                  Positioned(
                    bottom: 32,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => context.read<SwipeBloc>().add(
                                const EndSwipe(
                                    swipeStatus: SwipeStatus.dislike)),
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                const CircleBorder(),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Grey.swipeButton,
                              ),
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(14),
                              ),
                            ),
                            child: const Icon(
                              Icons.clear_rounded,
                              size: 36,
                              color: Colors.red,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => context.read<SwipeBloc>().add(
                                const EndSwipe(
                                    swipeStatus: SwipeStatus.message)),
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                const CircleBorder(),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Grey.swipeButton,
                              ),
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(16),
                              ),
                            ),
                            child: const Icon(
                              Icons.message,
                              size: 24,
                              color: Colors.white70,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => context.read<SwipeBloc>().add(
                                const EndSwipe(swipeStatus: SwipeStatus.like)),
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                const CircleBorder(),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Grey.swipeButton,
                              ),
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(16),
                              ),
                            ),
                            child: Icon(
                              Icons.thumb_up,
                              size: 32,
                              color: Blue.lightenedButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      );

  Widget buildCard(
          {required final Profile profile, final bool isFront = false}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage(
                  "https://thumbs.wbm.im/pw/small/39573f81d4d58261e5e1ed8f1ff890f6.jpg"),
              fit: BoxFit.cover,
              colorFilter: isFront == true
                  ? null
                  : const ColorFilter.mode(Colors.black, BlendMode.color),
              alignment: const Alignment(0, 0),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(
                      flex: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          profile.name,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            profile.lastName,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      profile.profession,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Builder(builder: (context) {
                      final List<int> experience =
                          getExprienceTime(profile.experiences);
                      final int years = experience[0];
                      final int months = experience[1];

                      return Text(
                        "$years ${years > 1 ? "ans" : "an"} et $months ${months > 1 ? "mois" : "mois"} d'expérience",
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    }),
                    JobAvailabilityTag(
                        jobAvailability: profile.jobAvailability),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

List<int> getExprienceTime(List<Experience> experiences) {
  List<int> totalExperienceTime = [0, 0];

  for (final Experience experience in experiences) {
    final int experienceTime =
        (experience.endingTime.difference(experience.startingTime).inHours /
                (24 * 30))
            .round();
    totalExperienceTime[0] += (experienceTime / 12).floor();
    totalExperienceTime[1] += experienceTime % 12;
  }

  return totalExperienceTime;
}
