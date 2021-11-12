import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/widgets/search_widget.dart';

import 'account_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Account> accounts;
  String query = '';

  final allAccounts = <Account>[
    Account('facebook', 'morel', 'pass'),
    Account('instagram', 'andre', 'ciao'),
  ]; // TODO

  @override
  void initState() {
    super.initState();
    accounts = allAccounts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 85),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.person),
              SizedBox(width: 10),
              Icon(Icons.settings),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 25),
          Stack(
            children: [
              Image.asset('assets/images/home.png'),
              Column(
                children: [
                  SizedBox(height: 25),
                  Wrap(
                    runSpacing: -10,
                    children: [
                      Center(
                        child: Text(
                          'PassKeeper.',
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      SizedBox(height: 70),
                      Center(
                        child: Text(
                          'A safe place to store all',
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'ZenAntique',
                                color: Colors.black,
                                fontSize: 19),
                            children: const [
                              TextSpan(text: 'your '),
                              TextSpan(
                                text: 'passwords',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                              TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          SearchWidget(
            text: query,
            onChanged: searchAccount,
            hintText: 'Text',
          ),
          Expanded(
            child: accounts.isNotEmpty ? ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return AccountTile(account: accounts[index]);
              },
            ) : Text('Nessun risultato trovato'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add new account',
        child: const Icon(Icons.add),
      ),
    );
  }

  void searchAccount(String query) {
    final accounts = allAccounts.where((account) {
      final siteLower = account.site.toLowerCase();
      final searchLower = query.toLowerCase();

      return siteLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.accounts = accounts;
    });
  }
}
