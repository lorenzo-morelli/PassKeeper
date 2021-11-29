import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:passkeeper/models/my_user.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/shared/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userOfFirebase(User user) {
    return MyUser(user.uid);
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((user) => _userOfFirebase(user!));
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userOfFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userOfFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  Future signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = result.user;
    final name = user!.displayName.toString();
    var parts = name.split(' ');
    var firstName = parts[0].trim();
    var lastName = parts[1].trim();
    DatabaseService(user.uid).addUser(UserData(user.uid, firstName, lastName));
    return _userOfFirebase(user);
  }

  String getUid() {
    User? user = _auth.currentUser;
    return user!.uid;
  }

  String? getEmail() {
    User? user = _auth.currentUser;
    return user!.email;
  }

  Future verifyEmail() async {
    User? user = _auth.currentUser;
    user!.sendEmailVerification();
  }

  bool isVerified() {
    User? user = _auth.currentUser;
    if (user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  Future reload() async {
    User? user = _auth.currentUser;
    user!.reload();
  }

  Future resetPasswordNotLogged(String email) async {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() async {
    if (Constants.withGoogle) {
      await GoogleSignIn().signOut();
    }
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}