import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import '../../providers/auth_provider.dart';
import '../../utility/sliders/generalSlider.dart';
import '../../utility/sliders/nameSlider.dart';
import '../../utility/sliders/doneSlider.dart';

// class SignUp with ChangeNotifier
class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  final formKey = GlobalKey<FormState>();

  var _email, _password, _name;
  // Controllers for the text fields
  final PageController _pageController = PageController(initialPage: 0);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  // parameters for Provider
  // final _email = "";
  // final _password = "";
  // final _name = "";

  late List<Sliders> _sliderWidgets;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    // Alternative: Place the doRegister() here...

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> _sliderWidgets = [
      Sliders(
          height: height,
          width: width,
          title: "Creating your account",
          question: "What is your email?",
          holder: "bob@example.com",
          error: "Please enter your email address correctly",
          controller: _emailController,
          pageController: _pageController,
          onNextPressed: (_email) {
            print('Email: $_email');
          }),
      Sliders(
          height: height,
          width: width,
          title: "Creating your account",
          question: "Create your password",
          holder: "Password",
          error: "Please enter the correct password",
          controller: _passwordController,
          pageController: _pageController,
          onNextPressed: (_password) {
            print('Password: $_password');
          }),
      nameSlider(
          height: height,
          width: width,
          title: "Creating your account",
          question: "What's your name?",
          fst_title: "First Name",
          fst_holder: "Bob",
          last_title: "Last Name",
          last_holder: "Joe",
          error: "Please enter all the fields",
          fstNameController: _firstNameController,
          lastNameController: _lastNameController,
          pageController: _pageController,
          onNextPressed: (_name) {
            print('Name: $_name');
          }),
      doneSlider(height: height, width: width)
    ];

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(), // Create an instance of AuthProvider
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                body: PageView(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable swipe navigation
                  children: _sliderWidgets,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


//     var doRegister = (){
//           print('on doRegister');

//       final form = formKey.currentState;
//       if(form.validate()){

//         form.save();

//         auth.loggedInStatus = Status.Authenticating;
//         auth.notify();

//         Future.delayed(loginTime).then((_) {
//           Navigator.pushReplacementNamed(context, '/login');
//           auth.loggedInStatus = Status.LoggedIn;
//           auth.notify();
//         });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text('Invalid form. Please complete the form properly'),
//     duration: Duration(seconds: 10), // Adjust the duration as needed
//   ),
// );
//     };
