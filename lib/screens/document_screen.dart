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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: 50,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
        padding: EdgeInsets.fromLTRB(10, 20, 50, 20),
        child: Image(
          image: AssetImage("lib/assets/Documentbackgroundpic.png"),
          height: 225.0,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text('Uh oh, you don’t have any documents yet!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 17,
            color: blue,
          )),
      SizedBox(
        height: 15,
      ),
      Text('Start scanning some files to get started.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 14,
            color: grey,
          )),
      Spacer(),
      Image(
        image: AssetImage("lib/assets/Navbar.png"),
        height: 140.0,
      ),
    ]));
  }
}
