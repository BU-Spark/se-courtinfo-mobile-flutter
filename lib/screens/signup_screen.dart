import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scdao_mobile/constants/color_constants.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _userNametext = TextEditingController();
  final _passwordtext = TextEditingController();
  final _emailtext = TextEditingController();
  final _confirmPtext = TextEditingController();
  bool _email = false;
  bool _confirmP = false;
  bool _userName = false;
  bool _passwordvalidate = false;
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  TextStyle linkStyle = TextStyle(color: Colors.yellow);

  @override
  void dispose() {
    _emailtext.dispose();
    _confirmPtext.dispose();
    _passwordtext.dispose();
    _userNametext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0),
      body: FilteredBackgroundImage(
        colorFilterColor: Color(0x441F2C5C),
        image: AssetImage('lib/assets/login_background.png'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Image(
              image: AssetImage("lib/assets/scdao-logo.png"),
              height: 125.0,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _emailtext,
                decoration: InputDecoration(
                  errorText: _email ? 'Email Can\'t Be Empty' : null,
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
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Email",
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
                style: TextStyle(color: Colors.white),
                controller: _userNametext,
                decoration: InputDecoration(
                  errorText: _userName ? 'Username Can\'t Be Empty' : null,
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
                  hintStyle: TextStyle(color: Colors.grey),
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
                controller: _passwordtext,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  errorText:
                      _passwordvalidate ? 'Password Can\'t Be Empty' : null,
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
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Password",
                  prefixIcon: Icon(
                    FontAwesomeIcons.userLock,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                obscureText: true,
                controller: _confirmPtext,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  errorText: _confirmP ? 'Different input Passwords' : null,
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
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Confirm Password",
                  prefixIcon: Icon(
                    FontAwesomeIcons.userLock,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            RichText(
              text: TextSpan(
                style: defaultStyle,
                children: <TextSpan>[
                  TextSpan(text: 'Already have an account? '),
                  TextSpan(
                      text: 'Login',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            {Navigator.of(context).pushNamed('loginPage')}),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _userName = _userNametext.text.isEmpty;
                  _passwordvalidate = _passwordtext.text.isEmpty;
                  _email = _emailtext.text.isEmpty;
                  if (_passwordtext.text != _confirmPtext.text)
                    _confirmP = true;
                });
              },
              child: Text(
                "Sign Up",
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
