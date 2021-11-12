import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        margin: EdgeInsets.only(bottom: 15),
        child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: account.color,
          ),
          title: Text(account.site, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          subtitle: Text('Username: ${account.username}\nPassword: ${account.password}'),
          trailing: Icon(Icons.settings, color: Colors.black54),
        ),
      ),
    );
  }
}
