import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Colors/Colorss.dart';

ThemeData Light = ThemeData(
    fontFamily: 'jannah',
    scaffoldBackgroundColor: MyColors.scaffoldLight,
    primarySwatch: MyColors.primarySwatch,
    textTheme: const TextTheme(
        bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 16,
    )),

    // ignore: prefer_const_constructors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MyColors.bottomNavLight,
        selectedItemColor: MyColors.primarySwatch,
        unselectedItemColor: Colors.grey),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ));
ThemeData Dark = ThemeData(
    fontFamily: 'jannah',
    scaffoldBackgroundColor: MyColors.scaffoldDark,
    primarySwatch: MyColors.primarySwatch,
    // ignore: prefer_const_constructors
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MyColors.bottomNavDark,
        selectedItemColor: MyColors.primarySwatch,
        unselectedItemColor: Colors.grey),
    cardColor: Colors.black,
    textTheme: const TextTheme(
        bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 16,
    )),
    appBarTheme: const AppBarTheme(
      elevation: 15,
      backgroundColor: MyColors.bottomNavDark,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ));
