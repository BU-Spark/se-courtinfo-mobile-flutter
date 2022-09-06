import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scdao_mobile/utils/ImageUtils.dart';

class DisplayPhotoScreen extends StatefulWidget {
  static const routeName = "/display";
  const DisplayPhotoScreen({Key? key}) : super(key: key);

  @override
  State<DisplayPhotoScreen> createState() => _DisplayPhotoScreenState();
}

class _DisplayPhotoScreenState extends State<DisplayPhotoScreen> {
  int _currIndex = 0;
  List<String> _imagePaths = [];

  @override
  void initState() {
    ImageUtility.getImagesFromPreferences().then((values) {
      print(values);
      setState(() {
        this._imagePaths = values;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: queryData.size.height * 1 / 10,
              child: Row(
                children: [],
              ),
            ),
            Expanded(
              flex: 5,
              child: this._imagePaths.length != 0
                  ? Image.file(File(_imagePaths[this._currIndex]))
                  : Center(child: Text("No image is taken")),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: queryData.size.width * 0.28,
              height: 40,
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Retake",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ],
                ),
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: queryData.size.width * 1 / 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          if (this._currIndex > 0) {
                            setState(() {
                              this._currIndex--;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.arrow_left_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                            "${this._currIndex + 1}/${this._imagePaths.length}"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (this._currIndex < this._imagePaths.length - 1) {
                              this._currIndex++;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.arrow_right_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: queryData.size.width * 0.11,
        width: queryData.size.width,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
        child: IconButton(
          onPressed: () => print("continue"),
          icon: Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
          color: Colors.green,
        ),
      ),
    );
  }
}
