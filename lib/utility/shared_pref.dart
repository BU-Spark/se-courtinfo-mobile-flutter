import 'package:shared_preferences/shared_preferences.dart';
import '../models/token.dart';

class UserPreferences {
  Future<bool> saveUser(Token token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('type', token.tokenType);
    prefs.setString('token', token.accessToken);

    return prefs.commit();
  }


  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
}
