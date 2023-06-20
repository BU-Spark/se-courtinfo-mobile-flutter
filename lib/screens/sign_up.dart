import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:go_router/go_router.dart';

// class SignUp with ChangeNotifier
class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers for the text fields
  String _newtext = "";
  String _fstName = "";
  String _lastName = "";
  String _userLastName = "";
  String _password = "";
  String _email = "";

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
List<Widget> forms = [];
  int index = 0;
//   TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
//   TextStyle linkStyle = TextStyle(color: Colors.yellow);

  
  Widget sliders(double height, double width, String title, String question,
      String holder, String error) {
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
              SizedBox(height: height * 0.05),

              // "Creating your account"
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff404040), // Change the text color to red
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // Question
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 26, 26, 26), // Change the text color to red
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.05),

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
                  controller:
                      index == 0 ? _emailController : _passwordController,
                  placeholder: holder,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _newtext,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 179, 16, 19), // Change the text color to red
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 120.0),

              // Back button
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
                    setState(() {
                      if (index == 0) {
                        context.goNamed('welcome');
                      } else {
                        index--;
                        _newtext = "";
                      }
                    });
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    backgroundColor:
                        const Color(0xff1f2c5c), // Background color
                  ),
                  onPressed: () {
                    setState(() {
                      if ((index == 0 && _emailController.text == "") ||
                          (index == 1 && _passwordController.text == "")) {
                        _newtext = error;
                      } else {
                        _newtext = "";
                        if (index == 0) {
                          _email = _emailController.text;
                          index++;
                        } else if (index == 1) {
                          _password = _passwordController.text;
                          index++;
                        }
                      }
                    });
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

  Widget nameSlider(
      double height,
      double width,
      String title,
      String question,
      String fstName,
      String fstNameHolder,
      String lastName,
      String lastNameHolder,
      String error) {
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
              SizedBox(height: height * 0.05),
              // "Creating your account"
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff404040), // Change the text color to red
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              // "What's your name?"
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 26, 26, 26), // Change the text color to red
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.05),
              //First name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  fstName,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 26, 26, 26), // Change the text color to red
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.02),
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
                  controller: _firstNameController,
                  placeholder: fstNameHolder,
                  placeholderStyle: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(color: CupertinoColors.systemGrey),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: height * 0.04),
              // Last name
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  lastName,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 26, 26, 26), // Change the text color to red
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.02),
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
                  controller: _lastNameController,
                  placeholder: lastNameHolder,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _newtext,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 179, 16, 19), // Change the text color to red
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    setState(() {
                      if (index == 0) {
                        context.goNamed('welcome');
                      } else {
                        index--;
                        _newtext = "";
                      }
                    });
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
                    setState(() {
                      if (_firstNameController.text == "" ||
                          _lastNameController.text == "") {
                        _newtext = error;
                      } else {
                        _newtext = "";
                        _fstName = _firstNameController.text;
                        _lastName = _lastNameController.text;
                        // notifyListeners();
                        index++;
                      }
                    });
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

  Widget doneMessage(double height, double width) {
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
               margin:  const EdgeInsets.fromLTRB(0, 220, 9, 9),
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
                  color: Color.fromARGB(255, 91, 89, 89), // Change the text color to red
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> forms = [
      sliders(height, width, "Creating your account", "What is your email?",
          "bob@example.com", "Please enter your email address"),
      sliders(height, width, "Creating your account", "Create your password",
          "Password", "Please make sure that you enter the correct password"),
      nameSlider(
          height,
          width,
          "Creating your account",
          "What's your name?",
          "First Name",
          "Bob",
          "Last Name",
          "Joe",
          "Please enter all the fields"),
      doneMessage(height, width)
    ];
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            body: forms[index]),
      ),
    );
  }
}
