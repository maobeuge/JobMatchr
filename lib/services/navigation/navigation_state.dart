part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class NavigationInitial extends NavigationState {}

final class NavigationLoaded extends NavigationState {
  final NavigationIndex index;

  const NavigationLoaded({required this.index});

  @override
  List<Object> get props => [index];
}
