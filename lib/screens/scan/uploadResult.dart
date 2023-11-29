import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UploadResultPage extends StatelessWidget {
  final bool isSuccess;

  UploadResultPage(this.isSuccess);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSuccess ? 'Upload Successful' : 'Upload Failed',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Color(0xff1f2c5c),
              ),
            ),
            SizedBox(height: 20),
            if (isSuccess)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xff1f2c5c), // Set button background color to dark blue
                ),
                onPressed: () {
                  context.goNamed('home');
                },
                child: Text('Go to Main Page'),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff1f2c5c),
                    ),
                    onPressed: () {
                      context.goNamed('camera');
                    },
                    child: Text('Rescan'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff1f2c5c),
                    ),
                    onPressed: () {
                     context.goNamed('home');
                    },
                    child: Text('Home'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
