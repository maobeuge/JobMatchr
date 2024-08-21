import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

enum NavigationIndex { message, swipe, profile }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(const NavigationLoaded(index: NavigationIndex.swipe)) {
    on<LoadNavigation>((event, emit) {
      emit(const NavigationLoaded(index: NavigationIndex.swipe));
    });

    on<ChangeIndex>((event, emit) {
      emit(NavigationLoaded(index: event.navigationIndex));
    });
  }
}
