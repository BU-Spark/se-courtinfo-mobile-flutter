import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scdao_mobile/providers/user.dart';
import 'package:scdao_mobile/screens/document_screen.dart';
import 'package:scdao_mobile/screens/signup_screen.dart';
import 'package:scdao_mobile/services/user.dart';
import 'package:scdao_mobile/widgets/AuthScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _pwdController = TextEditingController();
  UserService userService = UserService();

  String _errorMsg = "";
  bool _isError = false;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _pwdController.dispose();
  }

  void _onLogin(UserProvider userProv) async {
    try {
      setState(() {
        _isError = false;
        _isLoading = true;
      });

      // TODO: Delete before production
      // For testing loading flow
      await Future.delayed(const Duration(milliseconds: 1000));

      var user = await userService.login(
        _usernameController.text,
        _pwdController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (user != null) {
        userProv.setUser(user);
        Navigator.of(context).pushNamed(DocumentScreen.routeName);
      } else {
        setState(() {
          _errorMsg = "User is not found!";
          _isError = true;
        });
      }
    } on Exception catch (e) {
      print(e);
      setState(() {
        _errorMsg = "There is an error, please try again later!";
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return AuthScreen(
      inputFields: Padding(
        padding: const EdgeInsets.only(top: 80.0, left: 40.0, right: 40.0),
        child: Column(
          children: [
            if (_isError)
              Text(
                _errorMsg,
                style: TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 3.0, color: Colors.white),
                ),
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _pwdController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 3.0, color: Colors.white),
                ),
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10.0),
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
                    style: TextStyle(color: Colors.white.withOpacity(0.6))),
              ),
            )
          ],
        ),
      ),
      button: TextButton(
        onPressed: () => _onLogin(userProvider),
        child: _isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size.fromWidth(320)),
          backgroundColor: _isLoading
              ? MaterialStateProperty.all(Colors.grey)
              : MaterialStateProperty.all(Color(0xFFFFC032)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      navTextSpan: <TextSpan>[
        TextSpan(text: "Don't have an account? "),
        TextSpan(
          text: "Sign up",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.of(context).pushNamed(SignupScreen.routeName);
              print("clicked sign up text!");
            },
          style: TextStyle(
            color: Color.fromRGBO(255, 192, 50, 1),
          ),
        ),
      ],
    );
  }
}
