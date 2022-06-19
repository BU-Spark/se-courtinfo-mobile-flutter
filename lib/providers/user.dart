import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(username: '');

  UserModel get user => _user;

  void setUserFromJson(String username, TokenModel token) {
    _user = UserModel.build(username, token);
    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
