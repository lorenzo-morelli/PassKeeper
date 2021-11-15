import 'package:flutter/material.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/views/home/account_tile.dart';

class AccountList extends StatefulWidget {
  const AccountList({Key? key}) : super(key: key);

  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: Constants.allAccounts.length,
      itemBuilder: (context, index) {
        return AccountTile(account: Constants.allAccounts[index], index: index);
      },
    );
  }
}
