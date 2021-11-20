import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  var controlEmail = TextEditingController();
  final AuthService _auth = AuthService();
  String email = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(height: 250),
            Text(
              'Reset Password',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
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
                  SizedBox(height: 5),
                  Text(message, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
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
                                'Reset',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => Constants.loading = true);
                                  await _auth.resetPasswordNotLogged(email);
                                  setState(() => message = 'Check your email to reset your password');
                                }
                              }),
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
