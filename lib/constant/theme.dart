import 'package:flutter/material.dart';

//theme
CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool isdarktheme = true;
  ThemeMode get currentTheme => isdarktheme ? ThemeMode.light : ThemeMode.dark;
  void toggleTheme() {
    isdarktheme = !isdarktheme;
    notifyListeners();
  }

//when light theme toggle
  static ThemeData get lightTheme {
    return ThemeData(
      canvasColor: Colors.transparent,
      primaryColor: const Color(0xff7E89F0),
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
    );
  }

//when dark theme toggle
  static ThemeData get darkTheme {
    return ThemeData(
      canvasColor: Colors.transparent,
      primaryColor: const Color(0xff7E89F0),
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
    );
  }
}
