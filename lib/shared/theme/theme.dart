import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary1Color,
      primaryColorLight: AppColors.primary2Color,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
      ).copyWith(
        secondary: AppColors.accent1Color,
      ),
      fontFamily: 'MadaniArabic-Medium',
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline2: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline3: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline4: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline5: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline6: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        button: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: AppColors.primary1Color,
      ),
    );
  }

  static ThemeData get dartTheme {
    return ThemeData(
      fontFamily: 'MadaniArabic-Medium',
      primaryColor: AppColors.primary1Color,
      scaffoldBackgroundColor: const Color(0xFF20232E),
      backgroundColor: const Color(0xFF2C2E37),
      brightness: Brightness.dark,
      platform: TargetPlatform.iOS,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline2: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline3: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline4: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline5: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline6: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.white,
        ),
        caption: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        button: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: AppColors.primary1Color,
      ),
    );
  }
}
