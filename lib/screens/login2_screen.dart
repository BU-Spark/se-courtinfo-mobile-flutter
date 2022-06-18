import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FilteredBackgroundImage(
        image: AssetImage('lib/assets/login_background.png'),
        color: Color.fromRGBO(31, 44, 92, 0.9),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, bottom: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage("lib/assets/scdao-logo.png"),
                    height: 150.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 80.0, left: 40.0, right: 40.0),
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3.0, color: Colors.white),
                            ),
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3.0, color: Colors.white),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                                text: "Forgot your password?",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("Click forgot your password text");
                                  },
                                style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: "Sign up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("clicked sign up text!");
                            },
                          style: TextStyle(
                            color: Color.fromRGBO(255, 192, 50, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 175,
                    child: TextButton(
                      onPressed: () {
                        print("Button pressed!");
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(Size.fromWidth(320)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFFFC032)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilteredBackgroundImage extends StatelessWidget {
  FilteredBackgroundImage(
      {required this.image, required this.child, required this.color});

  final Color color;
  final AssetImage image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: child,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: image,
          colorFilter: ColorFilter.mode(color, BlendMode.srcATop),
        ),
      ),
    );
  }
}
