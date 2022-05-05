import 'package:flutter/material.dart';

ThemeData defaultThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueGrey,
    primarySwatch: Colors.blueGrey,
    fontFamily: 'Raleway',
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14.0),
      bodyText1: TextStyle(fontSize: 20.0),
    ),
  );
}