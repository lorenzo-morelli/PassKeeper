import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/loading.dart';
import 'package:passkeeper/views/authentication/reset_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  var controlEmail = TextEditingController();
  var controlPassword = TextEditingController();
  bool obscurePassword = true;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Constants.loading = false;
    return Constants.loading
        ? Loading()
        : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.lightGrey,
      body: Column(
        children: [
          SizedBox(height: 100),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          SizedBox(height: 30),
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
                    controller: controlEmail,
                    decoration: Constants.textInputDecoration.copyWith(
                      hintText: 'email',
                      suffixIcon: email.isNotEmpty
                          ? IconButton(
                        onPressed: () => setState(() {
                          controlEmail.clear();
                          email = '';
                        }),
                        icon: Icon(Icons.close, color: Colors.grey),
                      )
                          : null,
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 7),
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(decoration: TextDecoration.underline, fontSize: 15),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPassword()),
                      ),
                    ),
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
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => Constants.loading = true);
                        Constants.withGoogle = false;
                        dynamic result = await _auth.signIn(email, password);
                        if (result == null) {
                          setState(() {
                            error = "Couldn't sign in with those credentials";
                            Constants.loading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Text(error, style: TextStyle(color: Colors.red, fontSize: 14)),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          TextButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.cornRad),
                ),
              ),
            ),
            label: Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: ''),
            ),
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
            onPressed: () async {
              setState(() => Constants.loading = true);
              Constants.withGoogle = true;
              await _auth.signInWithGoogle();
            },
          ),
          SizedBox(height: 30),
          Text("Don't have an account yet?", style: TextStyle(fontSize: 17)),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black87, width: 2),
                ),
              ),
            ),
            child: Text(
              'Register',
              style: TextStyle(color: Colors.black87, fontSize: 19, fontStyle: FontStyle.italic),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
    );
  }
}