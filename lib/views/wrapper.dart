import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passkeeper/models/my_user.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/views/authentication/authenticate.dart';
import 'package:passkeeper/views/authentication/verify_email.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return user == null ? Authenticate() : Home();
  }
}

