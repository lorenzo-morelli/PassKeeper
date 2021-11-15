import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passkeeper/models/account.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference accountCollection = FirebaseFirestore.instance.collection('accounts');

  List<Account> _accountListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Account(
              doc.get('name') ?? '',
              doc.get('sugars') ?? '0',
              doc.get('strength') ?? 0,
            ))
        .toList();
  }
}
