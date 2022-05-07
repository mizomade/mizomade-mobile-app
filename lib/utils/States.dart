import 'package:flutter/material.dart';

class Profile extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated {
    return this._isAuthenticated;
  }

  set setAuthenticated(bool newVal) {
    this._isAuthenticated = newVal;
    notifyListeners();
  }
}

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark :ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes{
  static final darkTheme= ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    // unselectedWidgetColor: Colors.black26,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple
          )
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple
      ),

      disabledColor: Colors.white60,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,

      )

  );

  static final lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple
      )
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepPurple
    ),


    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.black),
    disabledColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepPurple,

    ),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),

    )


  );
}