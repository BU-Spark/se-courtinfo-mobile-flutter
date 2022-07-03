import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scdao_mobile/models/user.dart';
import 'package:scdao_mobile/providers/user.dart';
import 'package:scdao_mobile/screens/signup_screen.dart';
import 'package:scdao_mobile/screens/login_screen.dart';
import 'package:scdao_mobile/screens/document_screen.dart';
import 'package:scdao_mobile/screens/review_screen.dart';
import 'package:scdao_mobile/screens/Settings_screen.dart';
import 'package:scdao_mobile/screens/Privacy/privacy_screen.dart';
import 'package:scdao_mobile/screens/Privacy/change_password.dart';
import 'package:scdao_mobile/screens/Privacy/change_username.dart';
import 'package:scdao_mobile/services/user.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: new FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: ((context, AsyncSnapshot<SharedPreferences> snapshot) =>
          snapshot.hasData
              ? MyApp(
                  prefs: snapshot.data!,
                )
              : LoadingScreen()),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService userService = new UserService();

  // get token from cache and sends it to backend to check
  // if it's still valid or not
  Future<void> checkCachedToken(UserProvider provider) async {
    final token = TokenModel.getTokenFromCache(widget.prefs);
    if (token != null) {
      final user = await userService.checkToken(token);
      if (user != null) {
        provider.setUser(user);
      }
    } else {
      await widget.prefs.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    // check for cached token when the app is launched
    // since MyApp is the parent widget for every screen, it is built once.
    checkCachedToken(userProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(prefs: widget.prefs),
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(
              prefs: widget.prefs,
            ),
        SignupScreen.routeName: (_) => SignupScreen(),
        DocumentScreen.routeName: (_) => DocumentScreen(),
        ReviewScreen.routeName: (_) => ReviewScreen(),
        SettingsScreen.routeName: (_) => SettingsScreen(),
        PrivacyScreen.routeName: (_) => PrivacyScreen(),
        UsernameScreen.routeName: (_) => UsernameScreen(),
        PasswordScreen.routeName: (_) => PasswordScreen(),
      },
    );
  }
}

//TODO: create a loading screen
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Text("Loading"),
    );
  }
}
