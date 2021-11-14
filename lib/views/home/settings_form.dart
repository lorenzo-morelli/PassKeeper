import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  final allAccounts = <Account>[
    Account('facebook', 'morel', 'pass'),
    Account('instagram', 'andre', 'ciao'),
  ]; // TODO
  Color color = Colors.red;

  List<Color> colors = [
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.cyanAccent,
    Colors.purple,
    Colors.red,
    Colors.deepOrange,
    Colors.teal,
    Colors.indigoAccent,
    Colors.amber,
    Colors.cyan,
    Colors.blueGrey,
    Colors.brown,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.95,
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Constants.cornRad),
              topRight: Radius.circular(Constants.cornRad),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Update settings for ${allAccounts[0].site}.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: allAccounts[0].username,
                  decoration: Constants.textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a site' : null,
                  onChanged: (val) => {},
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: allAccounts[0].username,
                  decoration: Constants.textInputDecoration.copyWith(
                    hintText: 'username',
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a username' : null,
                  onChanged: (val) => {},
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: allAccounts[0].password,
                  decoration: Constants.textInputDecoration.copyWith(
                    hintText: 'Password',
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a password' : null,
                  onChanged: (val) => {},
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: BlockPicker(
                    pickerColor: color,
                    availableColors: colors,
                    onColorChanged: (color) => setState(() {
                      this.color = color;
                      print('color changed: $color');
                    }),
                  ),
                ),
                //SizedBox(height: 35),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Constants.cornRad)),
                  ),
                  child: TextButton(
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
