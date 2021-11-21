import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';

import '../wrapper.dart';

final AuthService _auth = AuthService();

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      onSelected: (item) => dropDownSettings(context, item),
      icon: Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Container(child: Text('Settings'), alignment: Alignment.center),
        ),
        PopupMenuItem(
          value: 1,
          child: Container(child: Text('Reset password'), alignment: Alignment.center),
        ),
        PopupMenuItem(
          value: 2,
          child: Container(child: Text('Logout'), alignment: Alignment.center),
        ),
      ],
    );
  }
}

Future<void> dropDownSettings(BuildContext context, int item) async {
  switch (item) {
    case 1:
      await _auth.resetPasswordNotLogged(_auth.getEmail()!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reset password email sent'),
        )
      );
      break;
    case 2:
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Wrapper()),
                      );
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
