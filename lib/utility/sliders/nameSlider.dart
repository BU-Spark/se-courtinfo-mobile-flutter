import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class nameSlider extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  final String question;
  final String fst_title;
  final String fst_holder;
  final String last_title;
  final String last_holder;
  final String error;
  final TextEditingController fstNameController;
  final TextEditingController lastNameController;
  final PageController pageController;
  final Function(String) onNextPressed;

  nameSlider({
    required this.height,
    required this.width,
    required this.title,
    required this.question,
    required this.fst_title,
    required this.fst_holder,
    required this.last_title,
    required this.last_holder,
    required this.error,
    required this.fstNameController,
    required this.lastNameController,
    required this.pageController,
    required this.onNextPressed,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NameSliderState createState() => _NameSliderState();
}

class _NameSliderState extends State<nameSlider> {
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
              // "What's your name?"
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
              //First name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.fst_title,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 26, 26, 26), // Change the text color to red
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: widget.height * 0.02),
              // Enter fstname
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
                  controller: widget.fstNameController,
                  placeholder: widget.fst_holder,
                  placeholderStyle: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(color: CupertinoColors.systemGrey),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: widget.height * 0.04),
              // Last name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.last_title,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 26, 26, 26), // Change the text color to red
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: widget.height * 0.02),
              // Enter last name
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
                  controller: widget.lastNameController,
                  placeholder: widget.last_holder,
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
              const SizedBox(height: 90.0),

              // Back to password page
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: ElevatedButton(
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
              ),
              const SizedBox(height: 2),

              // Continue button
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    backgroundColor:
                        const Color(0xff1f2c5c), // Background color
                  ),
                  onPressed: () {
                    if (widget.fstNameController.text.isEmpty ||
                        widget.lastNameController.text.isEmpty) {
                      warning = widget.error;
                      setState(() {
                        warning = widget.error;
                      });
                    } else {
                      final inputText =
                          "${widget.fstNameController.text.trim()} ${widget.lastNameController.text.trim()}";
                      setState(() {
                        warning = '';
                      });
                      // notifyListeners();
                      widget.onNextPressed(inputText);
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
