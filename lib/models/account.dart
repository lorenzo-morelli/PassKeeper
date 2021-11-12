import 'package:flutter/material.dart';

class Account {
  final String site;
  final String username;
  final String password;
  Color color = Colors.black26;

  Account(this.site, this.username, this.password);

  changeColor(Color color) {
    this.color = color;
  }
}
