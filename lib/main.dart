import '../constants.dart';
import '../router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/src/painting/image_resolution.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.checkLoginStatus();

  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider<AuthProvider>(create: (_) => authProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'CourtInfo Spark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: kPrimaryTextColor),
          bodyMedium: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.normal,
              color: kSecondaryColor),
          labelSmall: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: kPlaceholderTextColor),
        ),
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(50, 95, 50, 50),
        width: double.infinity,
        height: 896,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //'Welcome to'
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: const Text(
                  'Welcome to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    fontSize: 37.593132019,
                    height: 1.6699999614,
                    color: Color(0xff404040),
                  ),
                ),
              ),
              // image
              Container(
                child: const Image(
                    width: 250,
                    height: 250,
                    image: AssetImage("lib/assets/Welcome.png")),
              ),
              const SizedBox(
                height: 67,
              ),
              Container(
                width: double.infinity,
                height: 51,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Sign up button
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 33, 0),
                      child: FloatingActionButton.extended(
                          onPressed: () => {context.goNamed('signup')},
                          heroTag: 'signup_tag',
                          label: const Text('Sign up'),
                          backgroundColor: const Color(0xff1f2c5c)),
                    ),
                    // Login button
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FloatingActionButton.extended(
                          heroTag: 'login_tag',
                          onPressed: () => {context.goNamed('login')},
                          label: const Text('Log in'),
                          backgroundColor: const Color(0xff1f2c5c)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
