import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/shared/colors_table.dart';
import 'package:passkeeper/shared/constants.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String site = '';
  String username = '';
  String password = '';
  String color = Constants.colors[0].toString();
  var controlSite = TextEditingController();
  var controlUsername = TextEditingController();
  var controlPassword = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
      ),
      title: Text(
        'Add new account',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controlSite,
                decoration: Constants.textInputDecoration.copyWith(
                  hintText: 'site',
                  suffixIcon: site.isNotEmpty
                      ? IconButton(
                          onPressed: () => setState(() {
                            controlSite.clear();
                            site = '';
                          }),
                          icon: Icon(Icons.close, color: Colors.grey),
                        )
                      : null,
                ),
                validator: (val) => val!.isEmpty ? 'Enter site' : null,
                onChanged: (val) {
                  setState(() => site = val);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: controlUsername,
                decoration: Constants.textInputDecoration.copyWith(

                  hintText: 'username',
                  suffixIcon: username.isNotEmpty
                      ? IconButton(
                          onPressed: () => setState(() {
                            controlUsername.clear();
                            username = '';
                          }),
                          icon: Icon(Icons.close, color: Colors.grey),
                        )
                      : null,
                ),
                onChanged: (val) {
                  setState(() => username = val);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: controlPassword,
                decoration: Constants.textInputDecoration.copyWith(
                  hintText: 'password',
                  suffixIcon: password.isNotEmpty
                      ? IconButton(
                          onPressed: () => setState(() {
                            controlPassword.clear();
                            password = '';
                          }),
                          icon: Icon(Icons.close, color: Colors.grey),
                        )
                      : null,
                ),
                validator: (val) => val!.isEmpty ? 'Enter password' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 10),
              ColorsTable(
                func: (id) => setState(() => color = Constants.colors[id].toString()),
                radius: 14,
              ),
              SizedBox(height: 5),
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
                  SizedBox(width: 30),
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
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        DatabaseService(_auth.getUid()).addAccount(Account(site, username, password, color));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
