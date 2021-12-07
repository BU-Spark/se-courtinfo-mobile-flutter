import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

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
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: ListView(children: [
        GestureDetector(
          child: Container(
            height: 50,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text(
                    'Change Username',
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
          onTap: () => {Navigator.of(context).pushNamed('UsernamePage')},
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
                  Text(
                    'Change Password',
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
          onTap: () => {Navigator.of(context).pushNamed('PasswordPage')},
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
