part of 'profiles_bloc.dart';

sealed class ProfilesState extends Equatable {
  const ProfilesState();

  @override
  List<Object> get props => [];
}

final class ProfilesInitial extends ProfilesState {}

final class ProfilesLoading extends ProfilesState {
  const ProfilesLoading();
}

final class ProfilesLoaded extends ProfilesState {
  final List<Profile> profiles;

  const ProfilesLoaded({required this.profiles});

  @override
  List<Object> get props => [profiles];
}
