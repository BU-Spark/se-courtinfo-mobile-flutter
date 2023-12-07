import 'package:courtinfo_spark/components/BottomNav.dart';
import 'package:courtinfo_spark/constants.dart';
import 'package:courtinfo_spark/providers/upload_provider.dart';
import 'package:courtinfo_spark/screens/home/components/Body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime currentDateTime = DateTime.now();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      body: Consumer<UploadProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: <Widget>[
              Body(),
            ],
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: kBackgroundColor,
      title: const Text(
        "Your Documents",
        style: TextStyle(
            color: kPrimaryColor, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodyMedium,
                foregroundColor: kSecondaryColor,
              ),
              onPressed: () {},
              child: const Text("Select"),
            )),
      ],
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
    );
  }
}
