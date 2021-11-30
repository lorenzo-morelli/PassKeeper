import 'package:encrypt/encrypt.dart' as kay;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flut;
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/services/encryption/encryption_contract.dart';
import 'package:passkeeper/services/encryption/encryption_service.dart';
import 'package:passkeeper/shared/colors_table.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/tocolor_extension.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({flut.Key? key, required this.account, required this.index}) : super(key: key);
  final Account account;
  final int index;

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  var controlUsername = TextEditingController();
  var controlPassword = TextEditingController();
  final AuthService _auth = AuthService();
  String username = '';
  String password = '';
  String color = '';
  var obscurePassword = true;

  @override
  void initState() {
    IEncryption sut = EncryptionService(Encrypter(AES(kay.Key.fromLength(32))));
    setState(() => username = widget.account.username);
    setState(() => password = sut.decrypt(widget.account.password));
    setState(() => color = widget.account.color);
    setState(() => controlUsername = TextEditingController(text: widget.account.username));
    setState(() => controlPassword = TextEditingController(text: sut.decrypt(widget.account.password)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Account>>.value(
      initialData: const [],
      value: DatabaseService(_auth.getUid()).accounts,
      child: Wrap(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Constants.cornRad),
                topRight: Radius.circular(Constants.cornRad),
              ),
            ),
            child: Form(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Update settings for ${widget.account.site}.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
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
                    validator: (val) => val!.isEmpty ? 'Enter email' : null,
                    onChanged: (val) {
                      setState(() => username = val);
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                          obscureText: obscurePassword,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: obscurePassword
                            ? Icon(Icons.visibility, color: Colors.black54)
                            : Icon(Icons.visibility_off, color: Colors.black54),
                        onTap: () => setState(() {
                          obscurePassword = !obscurePassword;
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ColorsTable(
                      color: widget.account.color.toColor(),
                      func: (id) => setState(() => color = Constants.colors[id].toString()),
                    radius: 16,
                  ),
                  SizedBox(height: 18),
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
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      DatabaseService(_auth.getUid()).updateAccount(widget.account.site, username, password, color);
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.red, size: 20),
                      TextButton(
                        onPressed: () {
                          DatabaseService(_auth.getUid()).deleteAccount(widget.account.site);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Delete account',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: '',
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
