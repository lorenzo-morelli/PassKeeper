import 'package:flutter/material.dart';
import 'package:passkeeper/models/my_user.dart';
import 'package:passkeeper/views/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return user == null ? Authenticate() : Home(); // decides to go to Home() or Login()
  }
}
