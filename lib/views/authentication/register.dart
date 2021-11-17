import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/loading.dart';
import 'package:passkeeper/views/authentication/verify_email.dart';
import 'package:passkeeper/views/home/home.dart';

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
  var controlPassword = TextEditingController();
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
                          validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: controlPassword,
                          obscureText: true,
                          decoration: Constants.textInputDecoration.copyWith(
                            hintText: 'password',
                            suffixIcon: email.isNotEmpty
                                ? IconButton(
                                    onPressed: () => setState(() {
                                      controlPassword.clear();
                                      password = '';
                                    }),
                                    icon: Icon(Icons.close, color: Colors.grey),
                                  )
                                : null,
                          ),
                          validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
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
                              dynamic result = await _auth.register(email, password);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyScreen()));
                              if (result == null) {
                                setState(() {
                                  error = 'Please supply a valid email';
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
                SizedBox(height: 130),
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
