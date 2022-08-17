import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);
  static const routeName = "documents/camera";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Camera Screen!"),
    );
  }
}
