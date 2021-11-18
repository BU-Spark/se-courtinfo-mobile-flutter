import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scdao_mobile/constants/color_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:io';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final loginRepositoryProvider =
    Provider<LoginRepository>((ref) => LoginRepository());

class LoginRepository {
  var url = Uri.parse("http://192.168.0.44:8888/api/token");
  Future<http.Response> login(String username, String password) async {
    Map<String, String> bodyParams = new Map();
    bodyParams["username"] = username;
    bodyParams["password"] = password;
    Map<String, String> headersMap = new Map();
    headersMap["content-type"] = "application/x-www-form-urlencoded";

    final http.Response res = await http
        .post(url, headers: headersMap, body: bodyParams, encoding: Utf8Codec())
        .then((res) {
      if (res.statusCode == 200) {
        print(res.body);
        return res;
      } else {
        print("error");
        return res;
      }
    });

    return res;
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _text = TextEditingController();
  final _emailtext = TextEditingController();
  bool _validate = false;
  bool _emailvalidate = false;
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  TextStyle linkStyle = TextStyle(color: Colors.yellow);
  @override
  void dispose() {
    _emailtext.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    http.Response res;

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
                style: TextStyle(color: Colors.white),
                controller: _text,
                decoration: InputDecoration(
                  errorText: _validate ? 'Username Can\'t Be Empty' : null,
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
                controller: _emailtext,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  errorText: _emailvalidate ? 'Password Can\'t Be Empty' : null,
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
            RichText(
              text: TextSpan(
                style: defaultStyle,
                children: <TextSpan>[
                  TextSpan(text: 'Forgot your password? '),
                  TextSpan(
                      text: 'Sign up',
                      style: linkStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            {Navigator.of(context).pushNamed('SignupPage')}),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _validate = _text.text.isEmpty;
                  _emailvalidate = _emailtext.text.isEmpty;
                });

                res = await ref
                    .read(loginRepositoryProvider)
                    .login(_text.text, _emailtext.text);

                if (res.statusCode == 200) {
                  Navigator.of(context).pushNamed('DocumentPage');
                  print("Yes!!");
                }
              },
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
