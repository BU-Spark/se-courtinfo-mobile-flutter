import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  static const String routeName = "/review";
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 55),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Image(
              image: AssetImage("lib/assets/ScanImage.png"),
              height: 225.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
            child: Text(
              'While this is processing, please input the type of document you scanned:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                fontSize: 17,
                color: Color(0xFF1F2C5C),
              ),
            ),
          ),
          DropdownWidget(),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF1F2C5C),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('DocumentPage');
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  fontSize: 22,
                  color: Color(0XFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

/// This is the private State class that goes with DropdownWidget.
class _DropdownWidgetState extends State<DropdownWidget> {
  String dropdownValue = 'A Form';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(height: 3, color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[
            'E Doc',
            'B Form',
            'C Paper',
            'D Form',
            'A Form',
            'F Table'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
