import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key, required this.navOnPressed}) : super(key: key);
  final void Function(String) navOnPressed;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final double iconSize = queryData.size.width * 0.1;

    return Container(
      height: iconSize + 30,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: IconButton(
              splashRadius: 1,
              onPressed: () => this.navOnPressed("1"),
              icon: Icon(
                Icons.folder_open_outlined,
                color: Color.fromARGB(255, 5, 44, 75), //TODO: change to theme
                size: iconSize * 0.8,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              width: iconSize,
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              splashRadius: 1,
              onPressed: () => this.navOnPressed("3"),
              icon: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 5, 44, 75), //TODO: change to theme
                size: iconSize * 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
