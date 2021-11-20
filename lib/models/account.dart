import 'package:flutter/material.dart';

class Account {
  final String site;
  final String username;
  String password;
  Color color = Colors.black26;

  Account(this.site, this.username, this.password);
  Account.withColor(this.site, this.username, this.password, this.color);
}
