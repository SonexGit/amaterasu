import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  static const Color whiteColor = Color.fromARGB(255, 250, 250, 250);
  static const Color primaryColor = Color.fromARGB(255, 2, 62, 138);
  static const Color secondaryColor = Color.fromARGB(255, 2, 44, 100);
  static Color altColor = Colors.grey.shade100;
  static const Color textColor = Color.fromARGB(255, 20, 20, 20);
  static const Color categoryColorRed = Color.fromARGB(255, 239, 71, 111);
  static const Color categoryColorBlue = Color.fromARGB(255, 72, 150, 240);
  static const Color categoryColorPurple = Color.fromARGB(255, 173, 102, 255);
  static const Color categoryColorOrange = Color.fromARGB(255, 255, 209, 102);
  static const Color categoryColorGreen = Color.fromARGB(255, 6, 214, 160);
  static const Color categoryColorCyan = Color.fromARGB(255, 6, 214, 207);

  static const List<Color> mainGradient = [
    Color.fromARGB(255, 17, 153, 142),
    Color.fromARGB(255, 27, 175, 138),
    Color.fromARGB(255, 37, 196, 134),
    Color.fromARGB(255, 56, 239, 125),
  ];

  static TextStyle fontFamily =
      TextStyle(fontFamily: GoogleFonts.inter().fontFamily);

  static const TextStyle textStyle =
      TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w400);

  static const TextStyle appBarTitle = TextStyle(
      fontSize: 24,
      letterSpacing: 0.5,
      color: primaryColor,
      fontWeight: FontWeight.bold);
  static const TextStyle appBarInfo =
      TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.w500);

  static const TextStyle headlineStyleHome =
      TextStyle(fontSize: 24, color: primaryColor, fontWeight: FontWeight.bold);
  static TextStyle sublineStyleHome =
      TextStyle(fontSize: 16, color: Colors.grey.shade600);

  static const TextStyle fightFloor =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle profileHeadline = TextStyle(
    fontSize: 22,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle profileStats =
      TextStyle(fontSize: 16, color: secondaryColor);

  static TextStyle equipmentTextStyle =
      TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 16);
}
