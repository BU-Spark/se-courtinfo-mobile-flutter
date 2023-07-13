import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/token.dart';
import '../utility/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  Token? _loginToken;
  final storage = new FlutterSecureStorage();

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Token? get loginToken => _loginToken;

  Future<void> checkLoginStatus() async {
    // try to retrieve token if existed
    String? storedToken = await storage.read(key: 'login_token');
    if (storedToken != null) {
      DateTime expirationDate = JwtDecoder.getExpirationDate(storedToken);
      // print('expiration date: $expirationDate');
      //check if the token is expired or not
      if (expirationDate.isAfter(DateTime.now())) { //still valid
        _loginToken = Token.fromJson(json.decode(storedToken));
        _loggedInStatus = Status.LoggedIn;
        storedToken = null; 
      } else { //token expired
        _loggedInStatus = Status.NotLoggedIn;
        await storage.delete(key: 'login_token');
      }
    } else { //no login token found
      _loggedInStatus = Status.NotLoggedIn;
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> signup(String email, String password,
      String first_name, String last_name) async {
    var result;

    final Map<String, String> apiBodyData = {
      'username': email,
      'password': password,
    };

    final Uri registerUri = Uri.parse(AppUrl.register);

    final response = await http.post(
      registerUri,
      body: apiBodyData,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      //create a token model
      Token token = Token.fromJson(responseData);

      notifyListeners();
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': token,
      };
    } else {
      result = {
        'status': false,
        'message': 'Sign up failed',
        'data': json.decode(response.body)['error'],
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, String> loginData = {
      'username': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Uri loginUri = Uri.parse(AppUrl.login);

    http.Response response = await http.post(
      loginUri,
      body: loginData,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      //create a token model
      Token token = Token.fromJson(responseData);

      _loggedInStatus = Status.LoggedIn;
      _loginToken = token; // Store the login token
      await storage.write(
        key: 'login_token',
        value: json.encode(token.toJson()),
      ); // Store the token securely
      print('stored token_write:${json.encode(token.toJson())}');
      result = {
        'status': true,
        'message': 'Successfully logged in',
        'data': token,
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      result = {
        'status': false,
        'message': json.decode(response.body)['error'],
      };
    }
    notifyListeners();
    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
