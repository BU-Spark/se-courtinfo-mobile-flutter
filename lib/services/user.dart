import 'dart:convert';

import 'package:scdao_mobile/services/service.dart';
import 'package:http/http.dart' as http;

class Token {
  final String accessToken;
  final String tokenType;

  const Token({required this.tokenType, required this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    if (json['access_token'] != null && json['token_type'] != null) {
      return Token(
          accessToken: json['access_token'], tokenType: json['token_type']);
    } else {
      throw Exception("Unable to find properties: access_token or token-type");
    }
  }
}

class User {
  final String username;
  final Token token;

  const User({required this.username, required this.token});

  factory User.build(String user, Map<String, dynamic> tokenJson) {
    return User(username: user, token: Token.fromJson(tokenJson));
  }
}

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
    try {
      Uri uri = apiAddress("/signup");
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
}
