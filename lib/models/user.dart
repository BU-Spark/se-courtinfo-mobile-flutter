import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenModel {
  final String accessToken;
  final String tokenType;

  const TokenModel({required this.tokenType, required this.accessToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    if (json['access_token'] != null && json['token_type'] != null) {
      return TokenModel(
          accessToken: json['access_token'], tokenType: json['token_type']);
    } else {
      throw Exception("Unable to find properties: access_token or token-type");
    }
  }

  Map toJson() => {
        "access_token": this.accessToken,
        "token_type": this.tokenType,
      };

  Future<void> setTokenToCache(SharedPreferences prefs) async {
    print("token type: " + this.tokenType);
    print("access token: " + this.accessToken);
    await prefs.setString("token", jsonEncode(this));
  }

  static TokenModel? getTokenFromCache(SharedPreferences prefs) {
    final tokenJson = prefs.getString("token");
    print("retrieving token from cache: $tokenJson");
    if (tokenJson != null) {
      final Map<String, dynamic> json = jsonDecode(tokenJson);
      return new TokenModel(
        tokenType: json['token_type'],
        accessToken: json['access_token'],
      );
    }
    return null;
  }
}

class UserModel {
  final String username;
  TokenModel? token;

  UserModel({required this.username, this.token});

  factory UserModel.build(String user, TokenModel t) {
    return UserModel(username: user, token: t);
  }
}
