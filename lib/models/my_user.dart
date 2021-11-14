import 'account.dart';

class MyUser {
  final String uid;

  MyUser(this.uid);
}

class UserData {
  String uid;
  List<Account> accounts;

  UserData(this.uid, this.accounts);
}