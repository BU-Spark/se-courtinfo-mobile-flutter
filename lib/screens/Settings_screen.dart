import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    String getInitials(String account_name) => account_name.isNotEmpty
        ? account_name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    String _username = 'Username Here';
    String initials = getInitials(_username);
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      if (index == 1) {
        Navigator.of(context).pushNamed('CameraPage');
      } else if (index == 0) {
        Navigator.of(context).pushNamed('DocumentPage');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF4F6FB),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
          child: Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              fontSize: 28,
              color: Color(0xFF1F2C5C),
            ),
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          height: 90,
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF1F2C5C),
                    child: Text('$initials'),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '$_username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      fontSize: 22,
                      color: Color(0xFF1F2C5C),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          child: Container(
            height: 50,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Image(
                    image: AssetImage("lib/assets/Privacy.png"),
                    height: 22.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Privacy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color(0xFF1F2C5C),
                    ),
                  ),
                  Spacer(),
                  Image(
                    image: AssetImage("lib/assets/Arrow.png"),
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
          onTap: () => {Navigator.of(context).pushNamed('privacyPage')},
        ),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          child: Container(
            height: 50,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Image(
                    image: AssetImage("lib/assets/Personal.png"),
                    height: 18.0,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Personal information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color(0xFF1F2C5C),
                    ),
                  ),
                  Spacer(),
                  Image(
                    image: AssetImage("lib/assets/Arrow.png"),
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
          onTap: () => {},
        ),
      ]),
      backgroundColor: Color(0xFFF4F6FB),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.folder_open,
              color: Color(0xFFB8BFD7),
              size: 30,
            ),
            label: 'Folders',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "lib/assets/Camera.png",
              width: 70,
              height: 70,
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Color(0xFFB8BFD7),
              size: 30,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
