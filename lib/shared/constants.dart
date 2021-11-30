import 'package:flutter/material.dart';

class Constants {
  static const double cornRad = 30;
  static Color? lightGrey = Colors.grey[100];
  static bool withGoogle = false;
  static bool loading = false;

  static InputDecoration textInputDecoration = InputDecoration(
    hintText: 'site',
    fillColor: Colors.white,
    filled: true,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black87, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
    suffixIcon: null,
    );

  static List<Color> colors = [
    Color(0xffc0c0c0), // grey
    Color(0xffe52b50), // red
    Color(0xfff28500), // orange
    Color(0xffffd500), // yellow
    Color(0xff87cc87), // light green
    Color(0xff40826d), // green
    Color(0xff4a6e8c), // blue
    Color(0xff9370db), // purple
  ];

  static ThemeData theme = ThemeData(
    fontFamily: 'GentiumBook',
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
    ),
  );

  //TODO: colori temi... rosino sul psd, bianchino..., usare solo costanti!
  static Color defaultColor = Colors.black26;

}
