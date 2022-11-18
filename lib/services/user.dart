import 'dart:convert';
import 'package:scdao_mobile/services/service.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:flutter/foundation.dart';

class UserService extends HttpService {
  Future<UserModel?> login(String username, String password) async {
    Map<String, String> formParams = <String, String>{
      "username": username.trim(),
      "password": password,
    };

    Map<String, String> headers = <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "accept": "application/json",
    };
    Uri uri = apiAddress("/token");
    debugPrint('exception_login_screen: $uri');

    print(uri.toString());
    final http.Response res = await http.post(
      uri,
      headers: headers,
      body: formParams,
      encoding: Utf8Codec(),
    );
    if (res.statusCode == 200) {
      // TODO: add logic for caching access_token
      print(res.body);
      return UserModel.build(
        username,
        TokenModel.fromJson(jsonDecode(res.body)),
      );
    } else if (res.statusCode > 200) {
      print("Wrong status code: ${res.statusCode}");
      print("body: ${res.body}");
    }
    return null;
  }

  Future<UserModel?> signUp(String username, String password) async {
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
      return UserModel.build(
        username,
        TokenModel.fromJson(jsonDecode((res.body))),
      );
    } else if (res.statusCode > 200) {
      print("Wrong status code: ${res.statusCode}");
      print("body: ${res.body}");
    }
    return null;
  }

  // TODO: create check token service in the backend
  Future<UserModel?> checkToken(TokenModel token) async {}
}
