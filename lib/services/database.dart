import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkeeper/models/account.dart';

class DatabaseService {
  final String uid;
  CollectionReference usersColl = FirebaseFirestore.instance.collection('users');
  late CollectionReference accountsColl = FirebaseFirestore.instance.collection('users/$uid/accounts');

  DatabaseService(this.uid);

  Future addAccount(Account account) async {
    return accountsColl
        .doc(account.site)
        .set({
          'site': account.site,
          'username': account.username,
          'password': account.password,
        })
        .then((val) => print('account added'))
        .catchError((error) => print('failed to add user: $error'));
  }

  Future addUser(String firstName, String lastName) async {
    return usersColl
        .doc(uid)
        .set({
          'uid': uid,
          'name': firstName,
          'surname': lastName,
        })
        .then((val) => print('user added'))
        .catchError((error) => print('failed to add user: $error'));
  }

  List<Account> _accountListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Account(
      doc.get('site') ?? '',
      doc.get('username') ?? '',
      doc.get('password') ?? '',
    ))
        .toList();
  }

  Stream<List<Account>> get accounts {
    return accountsColl.snapshots().map(_accountListFromSnapshot);
  }
}
