import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scdao_mobile/screens/camera_screen.dart';
import 'package:scdao_mobile/screens/documents_screen.dart';

import '../widgets/BottomNavBar.dart';

class MainScreen extends StatelessWidget {
  static const routeName = "/documents";
  MainScreen({Key? key}) : super(key: key);
  final _navigatorKeys = GlobalKey<NavigatorState>();

  Route _onGenerateRoute(RouteSettings settings) {
    print("settings.name: ${settings.name}");
    late Widget page;
    switch (settings.name) {
      default:
        page = DocumentsScreen();
        break;
    }

    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  void _pushNamedRoute(String namedRoute) {
    if (namedRoute == DocumentsScreen.routeName) {
      _navigatorKeys.currentState!.pop();
    } else {
      _navigatorKeys.currentState!.pushNamed(namedRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final double iconSize = queryData.size.width * 0.18;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.white,
      body: Navigator(
        key: _navigatorKeys,
        initialRoute: 'documents',
        onGenerateRoute: _onGenerateRoute,
      ),
      // middle navigation button
      floatingActionButton: Container(
        height: iconSize + 10,
        width: iconSize + 10,
        child: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(CameraScreen.routeName),
          child: Icon(
            Icons.camera_alt,
            size: iconSize / 1.5,
          ),
          backgroundColor: Color.fromARGB(255, 5, 44, 75),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // left & right nav buttons
      bottomNavigationBar: BottomNavBar(
        pushNamedRoute: _pushNamedRoute,
      ),
    );
  }
}
