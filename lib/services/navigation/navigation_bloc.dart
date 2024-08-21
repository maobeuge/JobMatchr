import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

enum NavigationIndex { message, swipe, profile }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final PageController pageViewController;

  NavigationBloc({required this.pageViewController})
      : super(const NavigationLoaded(index: NavigationIndex.swipe)) {
    on<LoadNavigation>((event, emit) {
      emit(const NavigationLoaded(index: NavigationIndex.swipe));
    });

    on<ChangeIndex>((event, emit) {
      pageViewController.animateToPage(
        event.navigationIndex.index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      emit(NavigationLoaded(index: event.navigationIndex));
    });
  }
}
