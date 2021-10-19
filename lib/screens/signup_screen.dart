import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scdao_mobile/constants/color_constants.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 75,
          ),
          Image(
            image: AssetImage("lib/assets/scdao-logo.png"),
            height: 125.0,
          ),
          SizedBox(
            height: 45,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Username",
                prefixIcon: Icon(
                  FontAwesomeIcons.mailBulk,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Password",
                prefixIcon: Icon(
                  FontAwesomeIcons.userLock,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 100),
          Text(
            "Don't have an account? Sign up",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 25.0,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Log In",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600),
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size.fromWidth(320)),
              backgroundColor: MaterialStateProperty.all(kscdaoYellow),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }
}

class FilteredBackgroundImage extends StatelessWidget {
  FilteredBackgroundImage(
      {required this.image,
      required this.colorFilterColor,
      required this.child});

  final AssetImage image;
  final Color colorFilterColor;
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
          colorFilter: ColorFilter.mode(colorFilterColor, BlendMode.dstATop),
          image: image,
        ),
      ),
    );
  }
}
