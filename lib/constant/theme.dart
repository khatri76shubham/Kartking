import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool isdarktheme = true;
  ThemeMode get currentTheme => isdarktheme ? ThemeMode.light : ThemeMode.dark;
  void toggleTheme() {
    isdarktheme = !isdarktheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      canvasColor: Colors.transparent,
      primaryColor: const Color(0xff7E89F0),
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      canvasColor: Colors.transparent,
      primaryColor: const Color(0xff7E89F0),
      backgroundColor: Colors.yellow,
      scaffoldBackgroundColor: Colors.yellow,
    );
  }
}

class Textstyle {}
