import 'package:flutter/material.dart';

class Style {
  static Color whiteColor = const Color.fromARGB(255, 250, 250, 250);
  static Color primaryColor = Colors.red;
  static Color secondaryColor = Colors.blue;
  static Color textColor = const Color.fromARGB(255, 20, 20, 20);
  static const Color categoryColorRed = Color.fromARGB(255, 239, 71, 111);
  static const Color categoryColorBlue = Color.fromARGB(255, 72, 150, 240);
  static const Color categoryColorPurple = Color.fromARGB(255, 173, 102, 255);
  static const Color categoryColorOrange = Color.fromARGB(255, 255, 209, 102);
  static const Color categoryColorGreen = Color.fromARGB(255, 6, 214, 160);
  static const Color categoryColorCyan = Color.fromARGB(255, 6, 214, 207);

  // static const List<Color> mainGradient = [
  //   Color.fromARGB(255, 244, 7, 82),
  //   Color.fromARGB(255, 247, 89, 113),
  //   Color.fromARGB(255, 248, 130, 128),
  //   Color.fromARGB(255, 249, 171, 143),
  // ];

  // static const List<Color> mainGradient = [
  //   Color.fromARGB(255, 242, 146, 237),
  //   Color.fromARGB(255, 243, 123, 169),
  //   Color.fromARGB(255, 243, 111, 135),
  //   Color.fromARGB(255, 243, 99, 100),
  // ];

  static const List<Color> mainGradient = [
    Color.fromARGB(255, 17, 153, 142),
    Color.fromARGB(255, 27, 175, 138),
    Color.fromARGB(255, 37, 196, 134),
    Color.fromARGB(255, 56, 239, 125),
  ];

  static TextStyle textStyle = TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w400);
  static TextStyle headlineStyleHome = TextStyle(fontSize: 28, color: textColor, fontWeight: FontWeight.w800);
  static TextStyle sublineStyleHome = TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500);

  static TextStyle headlineStyleHomeCard = TextStyle(fontSize: 20, color: whiteColor, fontWeight: FontWeight.w700);

  static TextStyle moneyAppBar = const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
}
