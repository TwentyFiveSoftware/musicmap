import 'package:flutter/material.dart';

const ACCENT_COLOR = const Color(0xFFA0CE81);

ThemeData getLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFFFFF),
    primaryColorDark: Color(0xFFFFFFFF),
    accentColor: ACCENT_COLOR,
    scaffoldBackgroundColor: Color(0xFFF4F4F4),
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.black),
      bodyText1:
          TextStyle(color: Colors.black45, fontWeight: FontWeight.normal),
    ),
    hintColor: Colors.black38,
    primaryColorLight: Colors.black26,
    textSelectionTheme: TextSelectionThemeData(cursorColor: ACCENT_COLOR),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: ACCENT_COLOR),
    ),
    shadowColor: Color(0x34000000),
  );
}

ThemeData getDarkTheme() {
  const DARK_COLOR = const Color(0xFF282C34);
  const LIGHT_COLOR = const Color(0xFF7A7C81);

  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: DARK_COLOR,
    primaryColorDark: Color(0xFF21252B),
    accentColor: ACCENT_COLOR,
    scaffoldBackgroundColor: DARK_COLOR,
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.white),
      bodyText1:
          TextStyle(color: Colors.white60, fontWeight: FontWeight.normal),
    ),
    hintColor: LIGHT_COLOR,
    primaryColorLight: LIGHT_COLOR,
    textSelectionTheme: TextSelectionThemeData(cursorColor: ACCENT_COLOR),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: ACCENT_COLOR),
    ),
    shadowColor: Color(0x34000000),
  );
}
