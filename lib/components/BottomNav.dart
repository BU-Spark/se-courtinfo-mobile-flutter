import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String routeName = GoRouter.of(context).location;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: child,
      bottomNavigationBar: SizedBox(
        width: size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),
              painter: BNPainter(),
            ),
            Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: Transform.translate(
                  offset: const Offset(0, -40),
                  child: FloatingActionButton(
                    onPressed: () {
                      GoRouter.of(context).goNamed('camera');
                    },
                    backgroundColor: kPrimaryColor,
                    elevation: 0.1,
                    child: const Icon(Icons.photo_camera, size: 35),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.topic,
                          size: 40,
                          color: routeName == '/home'
                              ? kPrimaryColor
                              : kSecondaryColor),
                      onPressed: () {
                        GoRouter.of(context).goNamed('home');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings,
                          size: 40,
                          color: routeName == '/settings'
                              ? kPrimaryColor
                              : kSecondaryColor),
                      onPressed: () {
                        GoRouter.of(context).goNamed('settings');
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BNPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);

    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.38, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(45), clockwise: false);
    path.quadraticBezierTo(size.width * 0.62, 0, size.width * 0.66, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, sqrt(10), false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}