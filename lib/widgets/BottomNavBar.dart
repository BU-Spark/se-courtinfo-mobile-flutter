import 'package:flutter/material.dart';
import 'package:scdao_mobile/screens/documents_screen.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(String namedRoute) pushNamedRoute;
  BottomNavBar({Key? key, required this.pushNamedRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final double iconSize = queryData.size.width * 0.1;

    return Material(
      elevation: 5,
      child: Container(
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
                onPressed: () => this.pushNamedRoute(DocumentsScreen.routeName),
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
                onPressed: () => this.pushNamedRoute(
                    DocumentsScreen.routeName), //TODO: change to settings
                icon: Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 5, 44, 75), //TODO: change to theme
                  size: iconSize * 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
