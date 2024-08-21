part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class LoadSwipe extends SwipeEvent {
  const LoadSwipe();
}

class StartSwipe extends SwipeEvent {
  final String profileId;

  const StartSwipe({required this.profileId});

  @override
  List<Object> get props => [profileId];
}

class UpdateSwipe extends SwipeEvent {
  final DragUpdateDetails details;

  const UpdateSwipe({required this.details});

  @override
  List<Object> get props => [details];
}

class EndSwipe extends SwipeEvent {
  final SwipeStatus? swipeStatus;

  const EndSwipe({this.swipeStatus});

  @override
  List<Object> get props => [];
}
