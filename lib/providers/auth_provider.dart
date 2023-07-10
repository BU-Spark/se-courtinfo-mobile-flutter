import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/token.dart';
import '../utility/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
   String? _loginToken;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

    String? get loginToken => _loginToken;

    Future<void> checkLoginStatus() async {
    // try to retrieve token if existed
    final storedToken = await FlutterSecureStorage().read(key: 'login_token');
    if (storedToken != null) {
      _loginToken = storedToken;
      _loggedInStatus = Status.LoggedIn;
    } else {
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
      Token token= Token. fromJson(responseData);

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
      _loginToken = token.token; // Store the login token
      await FlutterSecureStorage().write(
        key: 'login_token',
        value: _loginToken,
      ); // Store the token securely
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successfully logged in',
        'data': token,
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error'],
      };
    }
    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
