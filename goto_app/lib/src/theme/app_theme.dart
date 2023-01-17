// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        // UI
        brightness: Brightness.light,
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            toolbarHeight: 56,
            elevation: 1,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
            actionsIconTheme: IconThemeData(
              color: Colors.black,
              size: 24,
            )),
        //text style
        textTheme: TextTheme(
          /// Trending
          headlineLarge: TextStyle(fontSize: 20),
          headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
          labelLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          labelMedium: TextStyle(fontSize: 14.0),
          labelSmall: TextStyle(fontSize: 14.0),
          bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(fontSize: 12, color: Colors.black),
        ),
      );
}
