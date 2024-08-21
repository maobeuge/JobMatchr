import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmatchr/domain/entities/profile.dart';

const List<String> jobAvailabilityTags = [
  "Recherche active",
  "A l'écoute du marché",
  "Non disponible",
];

class JobAvailabilityTag extends StatelessWidget {
  final JobAvailability jobAvailability;

  const JobAvailabilityTag({required this.jobAvailability, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 6,
            backgroundColor: jobAvailability == JobAvailability.activeSearch
                ? Colors.green
                : jobAvailability == JobAvailability.lookingForOpportunities
                    ? Colors.yellow
                    : Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              jobAvailabilityTags[jobAvailability.index],
              style: GoogleFonts.outfit(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
