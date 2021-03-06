import 'package:flutter/material.dart';
import 'package:passkeeper/models/my_user.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/views/authentication/authenticate.dart';
import 'package:passkeeper/views/authentication/verify_email.dart';
import 'package:provider/provider.dart';
import 'authentication/fingerprint.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null) {
      return Authenticate();
    } else if (!_auth.isVerified()) {
      return VerifyScreen();
    } else {
      return Fingerprint();
    }
  }
}