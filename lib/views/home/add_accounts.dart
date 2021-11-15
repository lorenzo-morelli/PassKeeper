import 'package:flutter/material.dart';
import 'package:passkeeper/shared/constants.dart';

final _formKey = GlobalKey<FormState>();

void addAccount(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
      ),
      title: Text(
        'Add new account',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: Constants.textInputDecoration,
              validator: (val) => val!.isEmpty ? 'Please enter a site' : null,
              onChanged: (val) => {},
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: Constants.textInputDecoration.copyWith(
                hintText: 'username',
              ),
              validator: (val) => val!.isEmpty ? 'Please enter a username' : null,
              onChanged: (val) => {},
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: Constants.textInputDecoration.copyWith(
                hintText: 'password',
              ),
              validator: (val) => val!.isEmpty ? 'Please enter a password' : null,
              onChanged: (val) => {},
            ),
            SizedBox(height: 30),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 40),
            //   child: BlockPicker(
            //     pickerColor: color,
            //     availableColors: colors,
            //     onColorChanged: (color) => setState(() {
            //       this.color = color;
            //       print('color changed: $color');
            //     }),
            //   ),
            // ),
            //SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Text(
                    'Cancel',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
                  ),
                  child: TextButton(
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));