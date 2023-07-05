import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utility/app_url.dart';
import '../utility/shared_pref.dart';
import 'package:http/http.dart' as http;

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

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future<Map<String, dynamic>> signup(String email, String password,
      String first_name, String last_name) async {
    final Map<String, dynamic> apiBodyData = {
      'email': email,
      'password': password,
      'first_name': first_name,
      'last_name': last_name,
    };

    final Uri registerUri = Uri.parse(AppUrl.register);

    final response = await http.post(registerUri,
        body: json.encode(apiBodyData),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});
    // .then(onValue)
    // .catchError(onError);

    return onValue(response);
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> onValue(http.Response response) async {
    var result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    print(responseData);

    if (response.statusCode == 200) {
      var userData = responseData['data'];

      //create a user model
      User authUser = User.fromJson(responseData);

      //then create shared preferences and save data
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Successfully registered',
        'data': responseData
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
        // 'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData);

      var userData = responseData['Content'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
