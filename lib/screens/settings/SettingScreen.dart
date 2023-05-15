import 'package:courtinfo_spark/components/BottomNav.dart';
import 'package:courtinfo_spark/constants.dart';
import 'package:flutter/material.dart';

import 'components/Body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      body: const Stack(
        children: <Widget>[
          Body(),
          // BottomNav(),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: kBackgroundColor,
      title: const Text(
        "Settings",
        style: TextStyle(
            color: kPrimaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
    );
  }
}
