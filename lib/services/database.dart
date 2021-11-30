import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as kay;
import 'package:encrypt/encrypt.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/models/my_user.dart';
import 'encryption/encryption_contract.dart';
import 'encryption/encryption_service.dart';

class DatabaseService {
  final String uid;
  CollectionReference usersColl = FirebaseFirestore.instance.collection('users');
  late CollectionReference accountsColl = FirebaseFirestore.instance.collection('users/$uid/accounts');
  IEncryption sut = EncryptionService(Encrypter(AES(kay.Key.fromLength(32))));
  String query = '';
  bool order = true;

  DatabaseService(this.uid);

  void setQuery(String query) {
    this.query = query;
  }

  void setOrder(bool order) {
    this.order = order;
  }

  Future addAccount(Account account) async {
    final encrPassword = sut.encrypt(account.password);
    return accountsColl.doc(account.site).set({
      'site': account.site,
      'username': account.username,
      'password': encrPassword,
      'color': account.color,
    });
  }

  Future addUser(UserData user) async {
    return usersColl.doc(uid).set({
      'first name': user.firstName,
      'last name': user.lastName,
    });
  }

  Future updateAccount(String? site, String? username, String? password, String? color) {
    final encrPassword = sut.encrypt(password!);
    return accountsColl.doc(site).set({
      'site': site,
      'username': username,
      'password': encrPassword,
      'color': color,
    });
  }

  void deleteAccount(String site) async {
    accountsColl.doc(site).delete();
  }

  void deleteAllAccounts() async {
    accountsColl.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future deleteUserData() {
    return usersColl.doc(uid).delete();
  }

  Stream<List<Account>> get accounts {
    return accountsColl.snapshots().map((snap) => accountListFromSnapshot(snap, query, order));
  }

  List<Account> accountListFromSnapshot(QuerySnapshot snapshot, String query, bool order) {
    this.query = query;
    var accounts = snapshot.docs
        .map((doc) => Account(doc.get('site') ?? '', doc.get('username') ?? '', doc.get('password') ?? '', doc.get('color') ?? ''))
        .toList()
        .where((acc) {
      final siteLower = acc.site.toLowerCase();
      final searchLower = query.toLowerCase();
      return siteLower.contains(searchLower);
    }).toList();

    if (order) {
      accounts.sort;
    } else {
      accounts = List.from(accounts.reversed);
    }
    return accounts;
  }
}
