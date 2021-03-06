import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/services/auth.dart';
import 'package:passkeeper/services/database.dart';
import 'package:passkeeper/shared/colors_table.dart';
import 'package:passkeeper/views/home/search_account.dart';
import 'package:passkeeper/widgets/search_widget.dart';
import 'package:provider/provider.dart';
import 'add_accounts.dart';
import 'dropdown_menu.dart';
import 'title.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String query = '';
  bool order = true;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Account>>.value(
            initialData: const [],
            value: FirebaseFirestore.instance
                .collection('users/${_auth.getUid()}/accounts')
                .snapshots()
                .map((snap) => DatabaseService(_auth.getUid()).accountListFromSnapshot(snap, query, order)),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  SizedBox(height: 30),
                  Container(alignment: Alignment.centerRight, child: DropDownMenu()),
                  SizedBox(height: 15),
                  AppName(),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 25, bottom: 10, top: 10),
                    child: GestureDetector(
                      child: order
                          ? Icon(FontAwesomeIcons.sortAlphaDown, color: Colors.grey[700])
                      : Icon(FontAwesomeIcons.sortAlphaDownAlt, color: Colors.grey[700]),
                      onTap: () => setState(() => (order = !order)),
                    ),
                  ),
                  SearchWidget(
                    text: query,
                    onChanged: (val) => searchAccount(val),
                    hintText: 'search...',
                  ),
                  SearchAccount(),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                elevation: 10,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AddAccount(),
                ),
                tooltip: 'Add new account',
                icon: Icon(Icons.add),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ), label: Text('Add account', style: TextStyle(fontFamily: '')),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            ),
          );
  }

  void searchAccount(String query) {
    DatabaseService(_auth.getUid()).setQuery(query);
    setState(() {
      this.query = query;
    });
  }
}
