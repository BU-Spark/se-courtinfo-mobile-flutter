import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utility/sliders/generalSlider.dart';
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
  late List<Sliders> _sliderWidgets;

  @override
  void dispose() {
    _pageController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
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
          error: "Please make sure that you enter the correct password",
          controller: _passwordController,
          pageController: _pageController,
          onNextPressed: (_password) {
            print('Password: $_password');
          }),
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
