import 'package:courtinfo_spark/screens/settings/components/UserProfile.dart';
import 'package:flutter/material.dart';

import 'SettingsList.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Column(
          children: <Widget>[
            const UserProfile(),
            const SizedBox(height: 40),
            SettingsList(
              label: "Privacy",
              icon: Icons.lock,
              onTap: () {},
            ),
            SettingsList(
              label: "Personal Information",
              icon: Icons.person,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
