import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';

final AuthService _auth = AuthService();
void dropDown(BuildContext context, int item) {
  switch (item) {
    case 1:
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.all(0),
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text('Yes', style: TextStyle(fontSize: 18, color: Colors.black)),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await _auth.signOut();
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
      break;
  }
}