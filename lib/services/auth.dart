import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passkeeper/models/my_user.dart';
import 'package:passkeeper/shared/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userOfFirebase(User user) {
    return MyUser(user.uid);
  }

  Stream<MyUser> get user {
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
    return _userOfFirebase(user!);
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
