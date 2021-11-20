import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/views/wrapper.dart';
import 'package:passkeeper/widgets/dismiss_keyboard.dart';
import 'package:provider/provider.dart';

import 'models/my_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: DismissKeyboard(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Constants.theme,
          home: Wrapper(),
        ),
      ),
    );
  }
}
