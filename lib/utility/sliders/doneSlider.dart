import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class doneSlider extends StatelessWidget{
  final double height;
  final double width;

  doneSlider({
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    String _error = '';

     return Container(
      padding: const EdgeInsets.fromLTRB(60, 39, 60, 39),
      width: double.infinity,
      height: 896,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "You are all set"
            Container(
              margin: const EdgeInsets.fromLTRB(0, 220, 9, 9),
              child: const Text(
                "You're all set 🎉",
                style: TextStyle(
                  color: Color.fromARGB(
                      255, 9, 0, 0), // Change the text color to red
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              child: const Text(
                "Please contact Spark! for more information",
                style: TextStyle(
                  color: Color.fromARGB(
                      255, 91, 89, 89), // Change the text color to red
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Back to welcome page
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: FloatingActionButton.extended(
                  onPressed: () {
                    context.goNamed('home');
                  },
                  label: const Text('Done'),
                  backgroundColor: const Color(0xff1f2c5c)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
