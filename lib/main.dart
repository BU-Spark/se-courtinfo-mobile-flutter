import 'package:courtinfo_spark/constants.dart';
import 'package:flutter/material.dart';
import 'package:courtinfo_spark/router.dart';

void main() {
  runApp(const MyApp());
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
