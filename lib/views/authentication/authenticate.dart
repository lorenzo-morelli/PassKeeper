import 'package:flutter/material.dart';
import 'package:passkeeper/views/authentication/register.dart';

import 'login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signIn = true; //TODO: should be false

  void toggleView() {
    setState(() {
      signIn = !signIn;
    });
}

  @override
  Widget build(BuildContext context) {
    return signIn ? Login(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
