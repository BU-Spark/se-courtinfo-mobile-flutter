import 'package:shared_preferences/shared_preferences.dart';
import '../models/token.dart';

class UserPreferences {
  Future<bool> saveUser(Token token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('type', token.tokenType);
    prefs.setString('token', token.accessToken);

    return prefs.commit();
  }

  Future<Token> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String type = prefs.getString("type") ?? "";
    String token = prefs.getString("token") ?? "";

    return Token(
        tokenType: type, 
        accessToken: token);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('type');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
}
