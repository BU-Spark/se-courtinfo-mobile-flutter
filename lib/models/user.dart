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
}

class UserModel {
  final String username;
  final TokenModel? token;

  const UserModel({required this.username, this.token});

  factory UserModel.build(String user, TokenModel t) {
    return UserModel(username: user, token: t);
  }
}
