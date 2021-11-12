import 'package:flutter/material.dart';
import 'package:passkeeper/views/authentication/login.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return true ? Home() : Login(); // decides to go to Home() or Login()
  }
}