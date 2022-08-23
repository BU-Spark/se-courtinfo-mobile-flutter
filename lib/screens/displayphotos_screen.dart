import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPhotoArgs {
  final String imagePath;

  DisplayPhotoArgs(this.imagePath);
}

class DisplayPhotoScreen extends StatelessWidget {
  static const routeName = "/display";
  const DisplayPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DisplayPhotoArgs;

    return Scaffold(
      appBar: AppBar(title: const Text("Photo taken")),
      body: Image.file(File(args.imagePath)),
    );
  }
}
