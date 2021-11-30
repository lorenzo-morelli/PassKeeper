import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/local_auth_api.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/views/home/home.dart';

class Fingerprint extends StatefulWidget {
  const Fingerprint({Key? key}) : super(key: key);

  @override
  _FingerprintState createState() => _FingerprintState();
}

class _FingerprintState extends State<Fingerprint> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    fingerprintAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Constants.cornRad),
                    ),
                  ),
                ),
                onPressed: () => fingerprintAuth(),
                child: Text('Use fingerprint', style: TextStyle(color: Colors.white, fontSize: 22))),
            SizedBox(height: 15),
            Text('or'),
            SizedBox(height: 15),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black87, width: 2),
                  ),
                ),
              ),
              onPressed: () => _auth.signOut(),
              child: Text('Go to the login page', style: TextStyle(color: Colors.black87, fontSize: 19, fontStyle: FontStyle.italic)),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Future<void> fingerprintAuth() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}