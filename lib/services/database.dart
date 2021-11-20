import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/models/my_user.dart';
import 'encryption/encryption_contract.dart';
import 'encryption/encryption_service.dart';

class DatabaseService {
  final String uid;
  CollectionReference usersColl = FirebaseFirestore.instance.collection('users');
  late CollectionReference accountsColl = FirebaseFirestore.instance.collection('users/$uid/accounts');
  IEncryption sut = EncryptionService(Encrypter(AES(Key.fromLength(32))));

  DatabaseService(this.uid);

  Future addAccount(Account account) async {
    final encrPassword = sut.encrypt(account.password);
    return accountsColl.doc(account.site).set({
      'site': account.site,
      'username': account.username,
      'password': encrPassword,
    });
  }

  Future addUser(UserData user) async {
    return usersColl.doc(uid).set({
      'first name': user.firstName,
      'last name': user.lastName,
    });
  }

  Future updateAccount(String? site, String? username, String? password) {
    final encrPassword = sut.encrypt(password!);
    return accountsColl.doc(site).set({
      'site': site,
      'username': username,
      'password': encrPassword,
    });
  }

  void deleteAccount(String site) async {
    accountsColl.doc(site).delete();
  }

  Stream<List<Account>> get accounts {
    return accountsColl.snapshots().map((snap) => _accountListFromSnapshot(snap));
  }

  List<Account> _accountListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Account(
              doc.get('site') ?? '',
              doc.get('username') ?? '',
              doc.get('password'),
            ))
        .toList();
  }

  Stream<List<Account>> accountsWithQuery(String query) {
    return accountsColl.snapshots().map((snap) => searchQuery(snap, query));
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
