import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:jobmatchr/domain/entities/profile.dart';

part 'swipe_state.dart';
part 'swipe_event.dart';

enum SwipeStatus { like, message, dislike }

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  Offset _position = Offset.zero;
  Offset get position => _position;
  double _angle = 0.0;
  double get angle => _angle;

  final double swipeThreshold = 100.0;

  final Size screenSize;
  final Profile profile;

  SwipeBloc({required this.profile, required this.screenSize})
      : super(const SwipeLoaded(
            position: Offset.zero, angle: 0.0, isDragging: false)) {
    on<LoadSwipe>((event, emit) {
      emit(const SwipeLoaded(
        position: Offset.zero,
        angle: 0.0,
        isDragging: false,
      ));
    });

    on<StartSwipe>((event, emit) {
      emit(const SwipeLoaded(
        position: Offset.zero,
        angle: 0.0,
        isDragging: true,
      ));
    });

    on<UpdateSwipe>((event, emit) {
      _position += event.details.delta;

      emit(SwipeLoaded(
        position: position,
        angle: angle,
        isDragging: true,
      ));
    });

    on<EndSwipe>((event, emit) async {
      SwipeStatus? status = getStatus(position, swipeThreshold);

      switch (status) {
        case SwipeStatus.like:
          _position += Offset(screenSize.width * 2, 0);
          emit(
            SwipeLoaded(
              position: position,
              angle: 45.0,
              isDragging: false,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 200));
          emit(DeleteProfile());
          break;
        case SwipeStatus.dislike:
          _position -= Offset(screenSize.width * 2, 0);
          emit(
            SwipeLoaded(
              position: position,
              angle: -45.0,
              isDragging: false,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 200));
          emit(DeleteProfile());
          break;
        case SwipeStatus.message:
          _position += Offset(0, -screenSize.height * 2);
          emit(
            SwipeLoaded(
              position: position,
              angle: angle,
              isDragging: false,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 200));
          emit(DeleteProfile());
          break;
        default:
          emit(const SwipeLoaded(
            position: Offset.zero,
            angle: 0.0,
            isDragging: false,
          ));
      }
    });
  }

  SwipeStatus? getStatus(final Offset position, final double threshold) {
    if (position.dx >= threshold) {
      return SwipeStatus.like;
    }
    if (position.dx <= -threshold) {
      return SwipeStatus.dislike;
    }
    if (position.dy <= -threshold) {
      return SwipeStatus.message;
    }
    return null;
  }
}
