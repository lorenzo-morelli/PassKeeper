import 'package:flutter/material.dart';
import 'package:passkeeper/views/authentication/login.dart';
import 'package:passkeeper/views/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'ZenAntique',
          highlightColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black87,
        ),
      ),
      home: Login(), // should be Wrapper()
    );
  }
}
