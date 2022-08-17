import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scdao_mobile/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scdao_mobile/models/user.dart';
import 'package:scdao_mobile/providers/user.dart';
import 'package:scdao_mobile/screens/signup_screen.dart';
import 'package:scdao_mobile/screens/login_screen.dart';
import 'package:scdao_mobile/screens/review_screen.dart';
import 'package:scdao_mobile/services/user.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

  // get camera
  // final camera = await availableCameras();
  // final firstCam = camera.first;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: new FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: ((context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data != null)
              return MyApp(
                prefs: snapshot.data!,
                // camera: firstCam,
              );
            return MaterialApp(
                home: LoadingScreen()); //TODO: create error screen
          default:
            return MaterialApp(home: LoadingScreen());
        }
      }),
    ),
  ));
}

class MyApp extends StatefulWidget {
  late final SharedPreferences prefs;
  // final CameraDescription camera;
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
      initialRoute: "/",
      routes: {
        "/": (_) => LoadingScreen(),
        LoginScreen.routeName: (_) => LoginScreen(
              prefs: widget.prefs,
            ),
        SignupScreen.routeName: (_) => SignupScreen(),
        ReviewScreen.routeName: (_) => ReviewScreen(),
        MainScreen.routeName: (_) => MainScreen(),
      },
    );
  }
}

//TODO: create a loading screen
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loading screen"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Loading",
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.document_scanner,
              ),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed("/documents"),
            ),
          ],
        ),
      ),
    );
  }
}
