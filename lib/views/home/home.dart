import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/widgets/search_widget.dart';
import 'package:provider/provider.dart';
import 'account_list.dart';
import 'account_tile.dart';
import 'add_accounts.dart';
import 'dropdown_menu.dart';
import 'title.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Account>>.value(
      value: DatabaseService(_auth.getUid()).accounts,
      initialData: const [],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            SizedBox(height: 50),
            Container(
              alignment: Alignment.bottomRight,
              child: DropDownMenu(),
            ),
            SizedBox(height: 25),
            AppName(),
            Container(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                icon: Transform(
                  transform: Matrix4.rotationY(math.pi),
                  child: Icon(Icons.sort),
                ),
                onSelected: (item) => {},//dropDownSortBy(context, item, accounts),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Text('Alphabetical order A-Z'),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text('Alphabetical order Z-A'),
                  )
                ],
              ),
            ),
            SearchWidget(
              text: query,
              onChanged: (val) {},//searchAccount,
              hintText: 'search...',
            ),
            Expanded(
              child: true
                  ? AccountList()
                  : Text('Nothing found :('),
            ),
            // TextButton(
            //   child: Text('add account'),
            //   onPressed: () {
            //     // DatabaseService(_auth.getUid()).addUser('Lorenzo', 'Morelli');
            //     // for (Account account in accounts){
            //     //   DatabaseService(_auth.getUid()).addAccount(account);
            //     // }
            //   },
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addAccount(context),
          tooltip: 'Add new account',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // void searchAccount(String query) {
  //   final accounts = Constants.allAccounts.where((account) {
  //     final siteLower = account.site.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //
  //     return siteLower.contains(searchLower);
  //   }).toList();
  //
  //   setState(() {
  //     this.query = query;
  //     this.accounts = accounts;
  //   });
  // }

  // void dropDownSortBy(BuildContext context, int item, List<Account> accounts) {
  //   switch (item) {
  //     case 0:
  //       setState(() {
  //         this.accounts = accounts;
  //       });
  //       break;
  //     case 1:
  //       setState(() {
  //         this.accounts = accounts;
  //       });
  //       break;
  //   }
  // }
}
