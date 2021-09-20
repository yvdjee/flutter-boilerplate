import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme extends ChangeNotifier {
  bool isLightTheme = true;

  ThemeData get getThemeData => isLightTheme ? themeData : themeDataDark;

  setThemeData(bool val) {
    isLightTheme = val;
    notifyListeners();
  }

  final ThemeData themeData = new ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily,
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(0, 68, 105, 1),
    primaryColorBrightness: Brightness.light,
    colorScheme: ThemeData().colorScheme.copyWith(
          secondary: Color.fromRGBO(184, 0, 0, 1),
          brightness: Brightness.light,
        ),
    backgroundColor: Colors.white,
  );

  final ThemeData themeDataDark = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily,
    brightness: Brightness.dark,
    primaryColor: Color.fromRGBO(184, 0, 0, 1),
    primaryColorBrightness: Brightness.dark,
    colorScheme: ThemeData().colorScheme.copyWith(
          secondary: Color.fromRGBO(0, 68, 105, 1),
          brightness: Brightness.dark,
        ),
  );
}
