import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProviders extends ChangeNotifier {
  User _user = User(username: '');

  User get user => _user;

  void setUser(String user, String token) {
    _user = User.build(user, jsonDecode(token));
    notifyListeners();
  }
}
