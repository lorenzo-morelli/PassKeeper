import 'package:flutter/material.dart';

class Account {
  final String site;
  final String username;
  final String password;
  String color = Colors.black26.toString();
  Account.withoutcolor(this.site, this.username, this.password);
  Account(this.site, this.username, this.password, this.color);
}
