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

  String? _errorUserMsg;
  String? _errorPwdMsg;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  bool _validateInput() {
    final userInput = _usernameController.value.text;
    final passInput = _pwdController.value.text;

    setState(() {
      _errorUserMsg = null;
      _errorPwdMsg = null;
    });

    bool validateUser = !(userInput.contains("@") && userInput.contains("."));
    setState(() {
      if (userInput.isEmpty) {
        _errorUserMsg = "Username can't be empty!";
      } else if (validateUser) {
        _errorUserMsg = "Username is not valid!";
      } else {
        _errorUserMsg = null;
      }
      if (passInput.isEmpty) {
        _errorPwdMsg = "Password can't be empty!";
      } else {
        _errorPwdMsg = null;
      }
    });
    if (userInput.isEmpty || passInput.isEmpty || validateUser) return false;

    return true;
  }

  void _onLogin(UserProvider userProv) async {
    try {
      bool isInputValid = _validateInput();
      if (!isInputValid) return;

      setState(() {
        _errorUserMsg = null;
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
          _errorUserMsg = "User is not found!";
        });
      }
    } on Exception catch (e) {
      print(e);
      setState(() {
        _errorUserMsg = "There is an error, please try again later!";
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
            TextField(
              controller: _usernameController,
              onChanged: (text) {
                setState(() {
                  if (text != "" && _errorUserMsg != null) {
                    _errorUserMsg = null;
                  }
                });
              },
              decoration: InputDecoration(
                errorText: _errorUserMsg,
                prefixIcon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 3.0, color: Colors.white),
                ),
                labelText: "Username",
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _pwdController,
              onChanged: (text) {
                setState(() {
                  if (text != "" && _errorUserMsg != null) {
                    _errorPwdMsg = null;
                  }
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                errorText: _errorPwdMsg,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                enabledBorder: const UnderlineInputBorder(
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
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
              ),
            )
          ],
        ),
      ),
      button: TextButton(
        onPressed: () => _onLogin(userProvider),
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
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
        const TextSpan(text: "Don't have an account? "),
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
