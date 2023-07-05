import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../utility/sliders/login_slider.dart';
import '../../providers/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  // Controllers for the text fields
  final PageController _pageController = PageController(initialPage: 0);
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  late List<loginSlider> _sliderWidgets;

  @override
  void dispose() {
    _pageController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<bool> onContinuePressed() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    print(email);
    print(password);

    // Use a Completer to handle the asynchronous login process
    Completer<bool> completer = Completer<bool>();

    // Call the API login method using the authProvider
    authProvider.login(email, password).then((success) {
      // ignore: unrelated_type_equality_checks
      if (success == true) {
        // If signup is successful, complete the completer with true
        print("Success login");
        completer.complete(true);
      } else {
        print('Login failed');
        // If signup fails, complete the completer with false
        completer.complete(false);
      }
    }).catchError((error) {
      print('Login error: $error');
      // If there's an error, complete the completer with false
      completer.complete(false);
    });

    // Return the future of the completer
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    //Alternative: doLogin
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> _sliderWidgets = [
      loginSlider(
          height: height,
          width: width,
          title: "Log in",
          question: "Enter your email",
          holder: "bob@example.com",
          error: "Please enter your email address correctly",
          controller: _emailController,
          pageController: _pageController,
          onContinuePressed: onContinuePressed),
      loginSlider(
          height: height,
          width: width,
          title: "Log in",
          question: "Enter your password",
          holder: "Password",
          error: "Please make sure that you enter the correct password",
          controller: _passwordController,
          pageController: _pageController,
          onContinuePressed: onContinuePressed),
    ];
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
  }
}

  //  var doLogin = () {
  //     final form = formKey.currentState;
  //     if (form.validate()) {
  //       form.save();
  //       final Future<Map<String, dynamic>> response = auth.login(_email, _password);
  //       response.then((response) {
  //         if (response['status']) {
  //           User user = response['user'];
  //           Provider.of<UserProvider>(context, listen: false).setUser(user);
  //           Navigator.pushReplacementNamed(context, '/dashboard');
  //         } else {
  //           Flushbar(
  //             title: "Failed Login",
  //             message: response['message']['message'].toString(),
  //             duration: Duration(seconds: 3),
  //           ).show(context);
  //         }
  //       });
  //     } else {
  //       Flushbar(
  //         title: 'Invalid form',
  //         message: 'Please complete the form properly',
  //         duration: Duration(seconds: 10),
  //       ).show(context);
  //     }
  //   };
