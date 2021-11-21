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
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.cyanAccent,
    Colors.purple,
    Colors.red,
    Colors.deepOrange,
    Colors.teal,
    Colors.indigoAccent,
    Colors.amber,
    Colors.cyan,
    Colors.blueGrey,
    Colors.brown,
    Colors.black,
  ];

  static ThemeData theme = ThemeData(
    fontFamily: 'GentiumBook',
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
    ),
  );

  //TODO: colori temi... rosino sul psd, bianchino..., usare solo costanti!
}
