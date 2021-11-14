import 'package:firebase_auth/firebase_auth.dart';
import 'package:passkeeper/models/my_user.dart';

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

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

}