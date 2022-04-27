import 'package:flutter/material.dart';
import 'package:scdao_mobile/constants/color_constants.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image(
            image: AssetImage("lib/assets/scdao-logo.png"),
          ),
        ),
        decoration: BoxDecoration(color: kscdaoBlue),
      ),
    );
  }
}
