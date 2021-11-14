import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const double cornRad = 30;
  static Color? lightGrey = Colors.grey[100];

  static InputDecoration textInputDecoration = InputDecoration(
    hintText: 'site',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black87, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
    suffixIcon: IconButton(
      onPressed: () {},
      icon: Icon(Icons.close, color: Colors.grey),
    ),
  );

  static ThemeData theme = ThemeData(
    fontFamily: 'GentiumBook',
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
    ),
  );
}
