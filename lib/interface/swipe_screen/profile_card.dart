import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobmatchr/domain/entities/profile.dart';
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

              return GestureDetector(
                child: LayoutBuilder(builder: (context, constraints) {
                  final int milliseconds = isDragging ? 0 : 400;
                  final EdgeInsets margin =
                      isDragging ? const EdgeInsets.all(24) : EdgeInsets.zero;
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
          alignment: Alignment.centerLeft,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              profile.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
              ),
            ),
          ),
        ),
      );
}
