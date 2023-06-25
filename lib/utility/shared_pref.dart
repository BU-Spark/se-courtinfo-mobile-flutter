import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', user.userId);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('type', user.type);
    prefs.setString('token', user.token);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId") ?? 0;
    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    String type = prefs.getString("type") ?? "";
    String token = prefs.getString("token") ?? "";
    //  String renewalToken = prefs.getString("renewalToken");

    return User(
        userId: userId, name: name, email: email, type: type, token: token);
    //  renewalToken: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('type');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
}
