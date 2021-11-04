import 'package:flutter/material.dart';
import 'package:scdao_mobile/screens/signup_screen.dart';
import 'package:scdao_mobile/screens/login_screen.dart';
import 'package:scdao_mobile/screens/document_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DocumentScreen(),
      routes: {
        'loginPage': (_) => LoginScreen(),
        'SignupPage': (_) => SignupScreen(),
        'Document page': (_) => DocumentScreen(),
      },
    );
  }
}
