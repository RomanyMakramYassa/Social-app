import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData derktheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      titleSpacing: 20.00,
      backwardsCompatibility: false,
      backgroundColor: Colors.red,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 30.00, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739')),
  textTheme: TextTheme(
    subtitle1: TextStyle(
        height: 1,
        fontSize: 18.00,
        color: Colors.black,
        fontWeight: FontWeight.w900),
    bodyText1: TextStyle(
        fontSize: 18.00, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  fontFamily: 'Jannah',
);
ThemeData lighttheme = ThemeData(
    textTheme: TextTheme(
      subtitle1: TextStyle(
          height: 1,
          fontSize: 18.00,
          color: Colors.black,
          fontWeight: FontWeight.w900),
      bodyText1: TextStyle(
          fontSize: 18.00, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    fontFamily: 'Jannah',
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
        titleSpacing: 20.00,
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 30.00, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
    ));
