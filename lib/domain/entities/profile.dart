import 'package:equatable/equatable.dart';
import 'package:jobmatchr/domain/entities/experience.dart';

enum JobAvailability {
  activeSearch,
  lookingForOpportunities,
  notAvailable,
}

class Profile extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String profession;
  final String city;
  final String introduction;
  final List<Experience> experiences;
  final String annualSalaryExpectations;
  final JobAvailability jobAvailability;

  const Profile({
    required this.id,
    required this.name,
    required this.lastName,
    required this.profession,
    required this.city,
    required this.introduction,
    required this.experiences,
    required this.annualSalaryExpectations,
    required this.jobAvailability,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        lastName,
        profession,
        city,
        introduction,
        experiences,
        annualSalaryExpectations,
        jobAvailability,
      ];
}
