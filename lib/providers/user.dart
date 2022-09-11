import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(username: '');
  String? _previewImgPath;

  UserModel get user => _user;

  String? get previewImgPath => _previewImgPath;

  void setUserFromJson(String username, TokenModel token) {
    _user = UserModel.build(username, token);
    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void setPreviewImgPath(String? img) {
    _previewImgPath = img;
    notifyListeners();
  }
}
