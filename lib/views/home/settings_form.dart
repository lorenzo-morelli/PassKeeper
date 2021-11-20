import 'package:encrypt/encrypt.dart' as kay;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flut;
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/services/encryption/encryption_contract.dart';
import 'package:passkeeper/services/encryption/encryption_service.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({flut.Key? key, required this.account, required this.index}) : super(key: key);
  final int index;
  final Account account;

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final controller = TextEditingController();
  final AuthService _auth = AuthService();
  String username = '';
  String password = '';

  @override
  void initState() {
    setState(() => username = widget.account.username);
    setState(() => password = widget.account.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IEncryption sut = EncryptionService(Encrypter(AES(kay.Key.fromLength(32))));
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
                    initialValue: widget.account.username,
                    decoration: Constants.textInputDecoration.copyWith(
                      hintText: 'username',
                    ),
                    onChanged: (val) => setState(() => username = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: sut.decrypt(widget.account.password),
                    decoration: Constants.textInputDecoration.copyWith(
                      hintText: 'Password',
                    ),
                    onChanged: (val) => setState(() => password = val),
                  ),
                  SizedBox(height: 30),
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
                      DatabaseService(_auth.getUid()).updateAccount(widget.account.site, username, password);
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
