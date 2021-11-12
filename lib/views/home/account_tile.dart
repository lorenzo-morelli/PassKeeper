import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Text('ciao');
  }
}
