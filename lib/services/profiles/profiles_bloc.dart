import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobmatchr/domain/entities/experience.dart';
import 'package:jobmatchr/domain/entities/profile.dart';

part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  ProfilesBloc() : super(const ProfilesLoading()) {
    on<LoadProfiles>(_onLoadProfiles);
    on<RemoveProfile>(_onRemoveProfile);
  }

  void _onLoadProfiles(LoadProfiles event, Emitter<ProfilesState> emit) {
    List<Profile> profiles = [
      Profile(
        id: '0',
        name: 'Romain',
        lastName: 'Floriani',
        profession: 'Développeur Flutter',
        city: 'Seoul',
        introduction:
            "Passionate about development for over 3 years, I have collaborated withIT service companies, startups, and large enterprises to create high performing mobile applications. Eager for exciting new challenges, I am ready to bring my expertise and creativity to realize new projects abroad.",
        experiences: [
          Experience(
            position: "Lead tech Flutter",
            startingTime: DateTime.parse("2022-10-01T00:00:00.000Z"),
            endingTime: DateTime.parse("2023-12-01T00:00:00.000Z"),
            positionDescription:
                "Collaborative design of the application within an agile team. Development of the Speechlab application in Flutter from scratch. Deployment of the application on stores (AppStore, PlayStore). Management of continuous integration and deployment for the application.",
            company: "Fastlane Educations",
          )
        ],
        annualSalaryExpectations: "40000",
        jobAvailability: JobAvailability.activeSearch,
      ),
      Profile(
        id: '3',
        name: 'THIERRy',
        lastName: 'Floriani',
        profession: 'Flutter developer',
        city: 'Seoul',
        introduction:
            "Passionate about development for over 3 years, I have collaborated withIT service companies, startups, and large enterprises to create high performing mobile applications. Eager for exciting new challenges, I am ready to bring my expertise and creativity to realize new projects abroad.",
        experiences: [
          Experience(
            position: "Lead tech Flutter",
            startingTime: DateTime.parse("2022-10-01T00:00:00.000Z"),
            endingTime: DateTime.parse("2023-12-01T00:00:00.000Z"),
            positionDescription:
                "Collaborative design of the application within an agile team. Development of the Speechlab application in Flutter from scratch. Deployment of the application on stores (AppStore, PlayStore). Management of continuous integration and deployment for the application.",
            company: "Fastlane Educations",
          )
        ],
        annualSalaryExpectations: "40000",
        jobAvailability: JobAvailability.lookingForOpportunities,
      ),
      Profile(
        id: '1',
        name: 'Romain',
        lastName: 'Floriani',
        profession: 'Flutter developer',
        city: 'Seoul',
        introduction:
            "Passionate about development for over 3 years, I have collaborated withIT service companies, startups, and large enterprises to create high performing mobile applications. Eager for exciting new challenges, I am ready to bring my expertise and creativity to realize new projects abroad.",
        experiences: [
          Experience(
            position: "Lead tech Flutter",
            startingTime: DateTime.parse("2022-10-01T00:00:00.000Z"),
            endingTime: DateTime.parse("2023-12-01T00:00:00.000Z"),
            positionDescription:
                "Collaborative design of the application within an agile team. Development of the Speechlab application in Flutter from scratch. Deployment of the application on stores (AppStore, PlayStore). Management of continuous integration and deployment for the application.",
            company: "Fastlane Educations",
          )
        ],
        annualSalaryExpectations: "40000",
        jobAvailability: JobAvailability.notAvailable,
      ),
      Profile(
        id: '2',
        name: 'Romain',
        lastName: 'Floriani',
        profession: 'Développeur Flutter',
        city: 'Seoul',
        introduction:
            "Passionate about development for over 3 years, I have collaborated withIT service companies, startups, and large enterprises to create high performing mobile applications. Eager for exciting new challenges, I am ready to bring my expertise and creativity to realize new projects abroad.",
        experiences: [
          Experience(
            position: "Lead tech Flutter",
            startingTime: DateTime.parse("2022-10-01T00:00:00.000Z"),
            endingTime: DateTime.parse("2023-12-01T00:00:00.000Z"),
            positionDescription:
                "Collaborative design of the application within an agile team. Development of the Speechlab application in Flutter from scratch. Deployment of the application on stores (AppStore, PlayStore). Management of continuous integration and deployment for the application.",
            company: "Fastlane Educations",
          )
        ],
        annualSalaryExpectations: "40000",
        jobAvailability: JobAvailability.activeSearch,
      )
    ];

    emit(ProfilesLoaded(profiles: profiles));
  }

  void _onRemoveProfile(RemoveProfile event, Emitter<ProfilesState> emit) {
    final currentState = state;
    if (currentState is ProfilesLoaded) {
      final profiles = currentState.profiles
          .where((profile) => profile.id != event.profileId)
          .toList();
      emit(ProfilesLoaded(profiles: profiles));
    }
  }
}
