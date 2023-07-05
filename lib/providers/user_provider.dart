import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier{

   User _user = User(
    userId: 0,
    first_name: '',
    last_name: '',
    email: '',
    type: '',
    token: '',
  );

  User get user => _user;

  void setUser (User user){
    _user = user;
    notifyListeners();
  }
}