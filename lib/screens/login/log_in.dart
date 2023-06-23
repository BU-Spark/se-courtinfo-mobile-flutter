import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../utility/sliders/generalSlider.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers for the text fields
  final PageController _pageController = PageController(initialPage: 0);
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  late List<Sliders> _sliderWidgets;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> _sliderWidgets = [
      Sliders(
          height: height,
          width: width,
          title: "Creating your account",
          question: "What is your email?",
          holder: "bob@example.com",
          error: "Please enter your email address",
          controller: _emailController,
          pageController: _pageController),
      Sliders(
          height: height,
          width: width,
          title: "Creating your account",
          question: "Create your password",
          holder: "Password",
          error: "Please make sure that you enter the correct password",
          controller: _passwordController,
          pageController: _pageController),
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
