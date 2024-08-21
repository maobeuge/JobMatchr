part of 'swipe_bloc.dart';

abstract class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeInitial extends SwipeState {}

class SwipeLoaded extends SwipeState {
  final Offset position;
  final double angle;
  final bool isDragging;

  const SwipeLoaded({
    required this.position,
    required this.angle,
    required this.isDragging,
  });

  @override
  List<Object> get props => [position, angle, isDragging];
}

class DeleteProfile extends SwipeState {}
