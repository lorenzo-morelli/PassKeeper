import 'package:flutter/material.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/loading.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Constants.lightGrey,
            body: Column(
              children: [
                SizedBox(height: 120),
                Text('AGGIUNGERE IMMAGINE CARRINA'),
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: Constants.textInputDecoration
                              .copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: Constants.textInputDecoration
                              .copyWith(hintText: 'Password'),
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Constants.cornRad)),
                          ),
                          child: TextButton(
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(error,
                            style: TextStyle(color: Colors.red, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                Text('METTERE A POSTO I PULSANTI COME REGISTER!'),
                SizedBox(height: 130),
                Text("Haven't an account yet?", style: TextStyle(fontSize: 16)),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black87),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
          );
  }
}
