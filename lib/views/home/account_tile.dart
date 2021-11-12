import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          contentPadding: EdgeInsets.only(bottom: 0),
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.purple,
          ),
          title: Text(account.site),
          subtitle: Text('Username: ${account.username}\nPassword: ${account.password}'),
          trailing: Icon(Icons.settings),
        ),
      ),
    );
  }
}
