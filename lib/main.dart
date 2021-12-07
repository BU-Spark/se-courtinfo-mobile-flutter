import 'package:flutter/material.dart';
import 'package:scdao_mobile/screens/signup_screen.dart';
import 'package:scdao_mobile/screens/login_screen.dart';
import 'package:scdao_mobile/screens/document_screen.dart';
import 'package:scdao_mobile/screens/camera_screen.dart';
import 'package:scdao_mobile/screens/review_screen.dart';
import 'package:scdao_mobile/screens/Settings_screen.dart';
import 'package:scdao_mobile/screens/Privacy/privacy_screen.dart';
import 'package:scdao_mobile/screens/Privacy/change_password.dart';
import 'package:scdao_mobile/screens/Privacy/change_username.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(ProviderScope(child: MyApp(firstcamera: firstCamera)));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.firstcamera}) : super(key: key);
  final firstcamera;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DocumentScreen(),
      routes: {
        'loginPage': (_) => LoginScreen(),
        'SignupPage': (_) => SignupScreen(),
        'DocumentPage': (_) => DocumentScreen(),
        'CameraPage': (_) => CameraScreen(
              camera: firstcamera,
            ),
        'reviewPage': (_) => ReviewScreen(),
        'settingsPage': (_) => SettingsScreen(),
        'privacyPage': (_) => PrivacyScreen(),
        'UsernamePage': (_) => UsernameScreen(),
        'PasswordPage': (_) => PasswordScreen(),
      },
    );
  }
}
