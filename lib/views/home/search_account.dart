import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';
import 'package:provider/provider.dart';

import 'account_list.dart';

class SearchAccount extends StatefulWidget {
  const SearchAccount({Key? key}) : super(key: key);

  @override
  _SearchAccountState createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount> {
  @override
  Widget build(BuildContext context) {
    List<Account> accounts = Provider.of<List<Account>>(context);
    return Expanded(
      child: accounts.isNotEmpty
          ? AccountList(accounts: accounts)
          : Column(
              children: const [
                SizedBox(height: 32),
                Text('Nothing found :('),
              ],
            ),
    );
  }
}
