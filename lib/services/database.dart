import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/models/my_user.dart';
import 'package:uuid/uuid.dart';

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

  Future addUser(UserData user) async {
    return usersColl.doc(uid).set({
      'uid': uid,
      'first name': user.firstName,
      'surname': user.lastName,
    });
  }

  Future updateAccount(String? site, String? username, String? password) {
    return accountsColl.doc(site).set({
      'site': site,
      'username': username,
      'password': password,
    });
  }

  Stream<List<Account>> get accounts {
    return accountsColl.snapshots().map(_accountListFromSnapshot);
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

  List<Account> searchQuery(QuerySnapshot snapshot, String query) {
    return snapshot.docs
        .map((doc) => Account(
              doc.get('site') ?? '',
              doc.get('username') ?? '',
              doc.get('password') ?? '',
            ))
        .where((account) {
      final siteLower = account.site.toLowerCase();
      final searchLower = query.toLowerCase();
      return siteLower.contains(searchLower);
    }).toList();
  }
}
