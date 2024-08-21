part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

final class LoadNavigation extends NavigationEvent {
  const LoadNavigation();

  @override
  List<Object> get props => [];
}

final class ChangeIndex extends NavigationEvent {
  final NavigationIndex navigationIndex;

  const ChangeIndex({required this.navigationIndex});

  @override
  List<Object> get props => [navigationIndex];
}
