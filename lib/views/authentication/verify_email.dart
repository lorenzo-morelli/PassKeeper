import 'dart:async';
import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/loading.dart';
import 'package:passkeeper/views/home/home.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final AuthService _auth = AuthService();
  int time = 60;
  Timer timer = Timer(Duration(seconds: 0), () => {});
  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  void initState() {
    _auth.verifyEmail();
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        if (time > 0) {
          time--;
        }
      });
      await _auth.reload();
      if (_auth.isVerified()) {
        timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300),
            Text('An email has been sent to your email address.'),
            Text('Please verify in your email inbox.'),
            SizedBox(height: 20),
            TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  backgroundColor: MaterialStateProperty.all<Color>(time == 0 ? Colors.black87 : Colors.black54),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Constants.cornRad),
                    ),
                  ),
                ),
                child: Text(
                  'Resend email',
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
                onPressed: () {
                  if (time == 0) {
                    _auth.verifyEmail();
                    time = 60;
                  }
                }),
            SizedBox(height: 5),
            time > 0 ? Text('Try again in ${time}s.') : Text(''),
            SizedBox(height: 30),
            Loading(),
          ],
        ),
      ),
    );
  }
}
