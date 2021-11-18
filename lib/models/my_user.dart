import 'account.dart';

class MyUser {
  final String uid;

  MyUser(this.uid);
}

class UserData {
  String uid;
  String? firstName;
  String? lastName;
  //List<Account> accounts;

  UserData(this.uid, this.firstName, this.lastName);
  //UserData.simple(this.uid, this.accounts);
}