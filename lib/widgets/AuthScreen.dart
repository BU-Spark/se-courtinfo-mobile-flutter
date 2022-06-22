import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({
    Key? key,
    required this.inputFields,
    required this.button,
    this.navTextSpan,
  }) : super(key: key);

  final Widget inputFields;
  final TextButton button;
  final List<TextSpan>? navTextSpan;

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).size.height * 0.1;
    final double paddingBot = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FilteredBackgroundImage(
        image: AssetImage('lib/assets/login_background.png'),
        color: Color.fromRGBO(31, 44, 92, 0.9),
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop, bottom: paddingBot),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Image(
                    image: AssetImage("lib/assets/scdao-logo.png"),
                    height: 150.0,
                  ),
                  inputFields,
                ],
              ),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: navTextSpan,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 175,
                    child: button,
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
