import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../validator.dart';
import 'package:email_validator/email_validator.dart';

class loginSlider extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  final String question;
  final String holder;
  final String error;
  final TextEditingController controller;
  final PageController pageController;
  final Future<bool> Function() onContinuePressed;

  loginSlider({
    required this.height,
    required this.width,
    required this.title,
    required this.question,
    required this.holder,
    required this.error,
    required this.controller,
    required this.pageController,
    required this.onContinuePressed,
  });
  @override
  // ignore: library_private_types_in_public_api
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<loginSlider> {
  String warning = '';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(60, 39, 60, 39),
        width: double.infinity,
        height: 896,
        child: Container(
          width: double.infinity,
          height: 480.23,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: widget.height * 0.05),

              // "Creating your account"
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xff404040), // Change the text color to red
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: widget.height * 0.02),

              // Question
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.question,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 26, 26, 26), // Change the text color to red
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: widget.height * 0.05),

              // Enter answer
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: CupertinoTextField(
                  style: const TextStyle(
                    color: Colors.black, // Change the color of the text to red
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255,
                        255), // Change the background color to light blue
                    borderRadius: BorderRadius.circular(4.42),
                    border: Border.all(
                      color: const Color(0xffcacaca),
                      width: 1.0,
                    ),
                  ),
                  controller: widget.controller,
                  obscureText: widget.question.contains('password'),
                  placeholder: widget.holder,
                  placeholderStyle: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(color: CupertinoColors.systemGrey),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                ),
              ),
              const SizedBox(height: 8),

              // Error message (if needed)
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Text(
                    warning,
                    style: const TextStyle(
                      color: Color(0xffb31013),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 120.0),

              // Back Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  backgroundColor: const Color.fromARGB(
                      255, 255, 255, 255), // Background color
                ),
                onPressed: () {
                  if (widget.pageController.page == 0) {
                    context.goNamed('welcome');
                  } else {
                    warning = '';
                    widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: const Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.6699999173,
                    color: Color(0xff464646),
                  ),
                ),
              ),

              // Continue button
              const SizedBox(height: 2),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  backgroundColor: const Color(0xff1f2c5c), // Background color
                ),
                onPressed: () {
                  final inputText = widget.controller.text.trim();
                  // validate if email format is right
                  if (inputText.isEmpty ||
                      (widget.question.contains('email') &&
                          !Validator.validateEmail(inputText))) {
                    setState(() {
                      warning = widget.error;
                    });
                  } else {
                    setState(() {
                      warning = '';
                    });
                    if (widget.pageController.page == 1) {
                      // Validate if user login info exists
                      if (widget.onContinuePressed() == true){
                        context.goNamed('home');
                      } else {
                        print('invalidate user info');
                      }
                    } else {
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
