import 'package:equatable/equatable.dart';

class Experience extends Equatable {
  final String position;
  final DateTime startingTime;
  final DateTime endingTime;
  final String positionDescription;
  final String company;

  const Experience(
      {required this.position,
      required this.startingTime,
      required this.endingTime,
      required this.positionDescription,
      required this.company});

  @override
  List<Object?> get props =>
      [position, startingTime, endingTime, positionDescription, company];
}
