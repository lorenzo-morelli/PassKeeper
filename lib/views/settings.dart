import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/views/wrapper.dart';

import 'authentication/authenticate.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.delete, color: Colors.red, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Delete all your accounts',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: '',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              onTap:() => showConfirm(0),
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.close, color: Colors.red, size: 30),
                  SizedBox(width: 10),
                  Text(
                    'Delete your PassKeeper account',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: '',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              onTap:() => showConfirm(1),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showConfirm(int x) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
        ),
        title: Text(
          'Are you sure?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Text("You won't be able to cancel\nyour changes", textAlign: TextAlign.center),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text('Yes', style: TextStyle(fontSize: 18, color: Colors.red)),
                  onPressed: () async {
                    if (x == 0) {
                      Navigator.of(context).pop();
                      DatabaseService(_auth.getUid()).deleteAllAccounts();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('All your accounts have been deleted successfully!'),
                      ));
                    } else if (x == 1) {
                      DatabaseService(_auth.getUid()).deleteUserData();
                      await _auth.deleteUser();
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Wrapper(),
                          ),
                          ModalRoute.withName('/'));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Your PassKeeper account has been deleted successfully!'),
                      ));
                    }
                  },
                ),
                TextButton(
                  child: Text('No', style: TextStyle(fontSize: 18, color: Colors.black)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
