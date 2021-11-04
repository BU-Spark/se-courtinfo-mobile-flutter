import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scdao_mobile/constants/color_constants.dart';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final blue = const Color(0xFF1F2C5C);
  final grey = const Color(0xFFB8BFD7);
  final fill = const Color(0xFFF4F6FB);
  final grey2 = const Color(0xFFB8BFD7);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: 30,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Your Documents',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  fontSize: 28,
                  color: blue,
                )),
            Text('Select',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: grey,
                )),
          ])),
      Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 227,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: fill,
                  filled: true,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Image(
              image: AssetImage("lib/assets/FolderIcon.png"),
              height: 25.0,
            ),
            Image(
              image: AssetImage("lib/assets/FilterIcon.png"),
              height: 25.0,
            ),
          ])),
      SizedBox(height: 55),
      Padding(
        padding: EdgeInsets.fromLTRB(10, 45, 50, 20),
        child: Image(
          image: AssetImage("lib/assets/Documentbackgroundpic.png"),
          height: 225.0,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text('Uh oh, you don’t have any documents yet!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 17,
            color: blue,
          )),
      SizedBox(
        height: 10,
      ),
      Text('Start scanning some files to get started.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 14,
            color: grey,
          )),
      Expanded(
          child: new Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: new BoxDecoration(color: Colors.white),
          height: 50,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 10,
                left: 60,
                child: Icon(
                  Icons.folder_open,
                  size: 35,
                  color: Color(0xFF1F2C5C),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage("lib/assets/Camera.png"),
                    height: 75.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 60,
                child: Icon(
                  Icons.settings,
                  color: grey2,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ))
    ]));
  }
}
