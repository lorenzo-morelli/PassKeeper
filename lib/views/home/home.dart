
import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/widgets/search_widget.dart';
import 'package:provider/provider.dart';
import 'account_list.dart';
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
  final _formKey = GlobalKey<FormState>();
  late List<Account> accounts;
  String query = '';

  @override
  Widget build(BuildContext context) {
    accounts = Provider.of<List<Account>>(context);
    return StreamProvider<List<Account>>.value(
      value: DatabaseService(_auth.getUid()).accounts,
      initialData: const [],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            SizedBox(height: 50),
            Container(alignment: Alignment.centerRight, child: DropDownMenu()),
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
                onSelected: (item) => {}, //dropDownSortBy(context, item, accounts),
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
              onChanged: (val) => searchAccount,
              // DatabaseService(_auth.getUid()).searchQuery(accounts, query), //searchAccount,
              hintText: 'search...',
            ),
            Expanded(
              child: true ? AccountList(accounts: accounts) : Text('Nothing found :('),
            ),
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

  void searchAccount(String query) {
    setState(() {
      this.query = query;
    });
    print(this.query);
  }

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

  void addAccount(BuildContext context) {
    String site = '';
    String username = '';
    String password = '';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Constants.cornRad)),
              ),
              title: Text(
                'Add new account',
                textAlign: TextAlign.center,
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: Constants.textInputDecoration,
                      validator: (val) => val!.isEmpty ? 'Please enter a site' : null,
                      onChanged: (val) => setState(() => site = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: Constants.textInputDecoration.copyWith(
                        hintText: 'username',
                      ),
                      validator: (val) => val!.isEmpty ? 'Please enter a username' : null,
                      onChanged: (val) => setState(() => username = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      decoration: Constants.textInputDecoration.copyWith(
                        hintText: 'password',
                      ),
                      validator: (val) => val!.isEmpty ? 'Please enter a password' : null,
                      onChanged: (val) => setState(() => password = val),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Text(
                            'Cancel',
                            style: TextStyle(decoration: TextDecoration.underline),
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Constants.cornRad),
                              ),
                            ),
                          ),
                          child: Text(
                            'Create',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              DatabaseService(_auth.getUid()).addAccount(Account(site, username, password));
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
