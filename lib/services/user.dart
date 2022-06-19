import 'dart:convert';
import 'package:scdao_mobile/services/service.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService extends HttpService {
  Future<User?> login(String username, String password) async {
    Map<String, String> formParams = <String, String>{
      "username": username,
      "password": password
    };

    Map<String, String> headers = <String, String>{
      "content-type": "application/x-www-form-urlencoded"
    };
    try {
      Uri uri = apiAddress("/token");
      final http.Response res =
          await http.post(uri, headers: headers, body: formParams);
      if (res.statusCode == 200) {
        return User.build(username, jsonDecode(res.body));
      } else if (res.statusCode > 200) {
        print("Wrong status code: ${res.statusCode}");
        print("body: ${res.body}");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signUp(String username, String password) async {
    Map<String, String> formParams = <String, String>{
      "username": username,
      "password": password
    };

    Map<String, String> headers = <String, String>{
      "content-type": "application/x-www-form-urlencoded"
    };
    Uri uri = apiAddress("/signup");
    final http.Response res = await http.post(
      uri,
      headers: headers,
      body: formParams,
    );
    if (res.statusCode == 200) {
      return User.build(username, jsonDecode(res.body));
    } else if (res.statusCode > 200) {
      print("Wrong status code: ${res.statusCode}");
      print("body: ${res.body}");
    }
    return null;
  }
}
