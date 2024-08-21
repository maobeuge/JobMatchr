part of 'profiles_bloc.dart';

sealed class ProfilesEvent extends Equatable {
  const ProfilesEvent();

  @override
  List<Object> get props => [];
}

final class LoadProfiles extends ProfilesEvent {}

final class RemoveProfile extends ProfilesEvent {
  final String profileId;

  const RemoveProfile({required this.profileId});

  @override
  List<Object> get props => [profileId];
}
