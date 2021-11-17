import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/views/authentication/register.dart';
import 'login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool login = true;

  void toggleView() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return login ? Login(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
