import 'package:flutter/material.dart';
import 'package:scdao_mobile/screens/signup_screen.dart';
import 'package:scdao_mobile/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _login = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupScreen(),
      routes: {
        'loginPage': (_) => LoginScreen(),
        'SignupPage': (_) => SignupScreen(),
      },
    );
  }
}
