import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobmatchr/constants/ui_helper.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "JobMatch'",
              style: GoogleFonts.lobster(
                color: Blue.lightenedButton,
                fontSize: 28,
              ),
            ),
            Text(
              "R",
              style: GoogleFonts.lobster(
                color: Blue.lightenedButton,
                fontSize: 28,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: null,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/icons/settings_icon.png",
                    fit: BoxFit.contain,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
