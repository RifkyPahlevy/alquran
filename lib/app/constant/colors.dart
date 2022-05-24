import 'package:flutter/material.dart';

const appPurple = const Color(0xFF5D1049);
const appWhite = const Color(0xFFFAF9FC);
const appPurpleLight = const Color(0xFF2C0C88);
const appGrey = const Color(0xFFB79FD2);
const appPurple2 = const Color(0xFF230A72);
const appPurple3 = const Color(0xFF6B32D7);
const appPink = const Color(0xFFC26286);
const appPurpleDark = const Color(0xFF251441);

ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appPurple),
    primaryColor: appWhite,
    scaffoldBackgroundColor: appWhite,
    appBarTheme: AppBarTheme(elevation: 4, backgroundColor: appPurpleLight));

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appWhite),
  primaryColor: appPurple,
  backgroundColor: appPurple,
  scaffoldBackgroundColor: appPurpleLight,
  appBarTheme: AppBarTheme(elevation: 0, backgroundColor: appPurpleLight),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: appWhite,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: appWhite,
    ),
  ),
);
