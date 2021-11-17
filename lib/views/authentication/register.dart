import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/loading.dart';
import 'package:passkeeper/views/authentication/verify_email.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  var controlEmail = TextEditingController();
  var controlPassword1 = TextEditingController();
  var controlPassword2 = TextEditingController();
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  String email = '';
  String password1 = '';
  String password2 = '';
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
                  'Register',
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
                          validator: (val) => val!.isEmpty ? 'Enter an email.' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controlPassword1,
                                decoration: Constants.textInputDecoration.copyWith(
                                  hintText: 'password',
                                  suffixIcon: password1.isNotEmpty
                                      ? IconButton(
                                          onPressed: () => setState(() {
                                            controlPassword1.clear();
                                            password1 = '';
                                          }),
                                          icon: Icon(Icons.close, color: Colors.grey),
                                        )
                                      : null,
                                ),
                                validator: (val) => val!.length < 6 ? 'Enter a password of 6 characters at least.' : null,
                                obscureText: obscurePassword1,
                                onChanged: (val) {
                                  setState(() => password1 = val);
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              child: obscurePassword1
                                  ? Icon(Icons.visibility, color: Colors.black54)
                                  : Icon(Icons.visibility_off, color: Colors.black54),
                              onTap: () => setState(() {
                                obscurePassword1 = !obscurePassword1;
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controlPassword2,
                                decoration: Constants.textInputDecoration.copyWith(
                                  hintText: 'password',
                                  suffixIcon: password2.isNotEmpty
                                      ? IconButton(
                                          onPressed: () => setState(() {
                                            controlPassword2.clear();
                                            password2 = '';
                                          }),
                                          icon: Icon(Icons.close, color: Colors.grey),
                                        )
                                      : null,
                                ),
                                validator: (val) => password1 != password2 ? "Passwords don't match." : null,
                                obscureText: obscurePassword2,
                                onChanged: (val) {
                                  setState(() => password2 = val);
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              child: obscurePassword2
                                  ? Icon(Icons.visibility, color: Colors.black54)
                                  : Icon(Icons.visibility_off, color: Colors.black54),
                              onTap: () => setState(() {
                                obscurePassword2 = !obscurePassword2;
                              }),
                            ),
                          ],
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
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => Constants.loading = true);
                              dynamic result = await _auth.register(email, password1);
                              if (result == null) {
                                setState(() {
                                  error = 'Please supply a valid email or \n user already registered.';
                                  Constants.loading = false;
                                });
                              }
                              result = await _auth.verifyEmail();
                            }
                          },
                        ),
                        SizedBox(height: 12),
                        Text(error, style: TextStyle(color: Colors.red, fontSize: 14), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Text("Have an account already?", style: TextStyle(fontSize: 17)),
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
                    'Login',
                    style: TextStyle(color: Colors.black87, fontSize: 19, fontStyle: FontStyle.italic),
                  ),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
          );
  }

  Future<void> popup() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
        ),
        content: Text('email being verified'),
      ),
    );
  }
}
