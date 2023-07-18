import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreen createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  String dropdownValue = 'Bond Tracking Form';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(34, 150, 34, 87),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 72),
              width: 234,
              height: 272,
              child: const Image(
                  width: 234,
                  height: 272,
                  image: AssetImage("lib/assets/scanImage.png")),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 1, 38),
              constraints: const BoxConstraints(
                maxWidth: 345,
              ),
              child: const Text(
                'Which documents do you want to upload?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.2125,
                  color: Color(0xff1f2c5c),
                ),
              ),
            ),
            Container(
              child: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                // will replace the list by the actial forms objects retrieved by api cal /api/forms
                items: <String>['Bond Tracking Form', 'Criminal Complain Form']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
                height: 20,
              ),
            Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FloatingActionButton.extended(
                          onPressed: () => {context.goNamed('scanDoc')},
                          heroTag: 'camera_continue',
                          label: const Text('Continue'),
                          backgroundColor: const Color(0xff1f2c5c)),
                    ),
          ],
        ),
      ),
    );
  }
}
