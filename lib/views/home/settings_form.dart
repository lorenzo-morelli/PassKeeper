import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:passkeeper/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  late Color color;
  @override
  Widget build(BuildContext context) {
    Color color = Constants.allAccounts[widget.index].color;
    return Wrap(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.90,
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
                    'Update settings for ${Constants.allAccounts[widget.index].site}.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: Constants.allAccounts[widget.index].site,
                  decoration: Constants.textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a site' : null,
                  onChanged: (val) => {},
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: Constants.allAccounts[widget.index].username,
                  decoration: Constants.textInputDecoration.copyWith(
                    hintText: 'username',
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a username' : null,
                  onChanged: (val) => {},
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: Constants.allAccounts[widget.index].password,
                  decoration: Constants.textInputDecoration.copyWith(
                    hintText: 'Password',
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a password' : null,
                  onChanged: (val) => {},
                ),
                SizedBox(height: 30),
                BlockPicker(
                  pickerColor: color,
                  availableColors: Constants.colors,
                  onColorChanged: (color) => setState(() {
                    this.color = color;
                    print('color changed: $color');
                  }),
                ),
                //SizedBox(height: 35),
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
