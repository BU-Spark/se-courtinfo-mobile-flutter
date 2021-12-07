import 'package:flutter/material.dart';

class UsernameScreen extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<UsernameScreen> {
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
        title: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
            child: Text(
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                fontSize: 28,
                color: Color(0xFF1F2C5C),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Text(
              'Set',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                fontSize: 20,
                color: Color(0xFFB8BFDA),
              ),
            ),
          )
        ],
      ),
      body: ListView(children: [
        Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              children: [
                Text(
                  'Current Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    fontSize: 18,
                    color: Color(0xFF1F2C5C),
                  ),
                ),
                Spacer(),
                Container(
                  width: 150,
                  child: Text(
                    'BlaBlaBla',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color(0xFF1F2C5C),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              children: [
                Text(
                  'New Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    fontSize: 18,
                    color: Color(0xFF1F2C5C),
                  ),
                ),
                Spacer(),
                Container(
                  width: 150,
                  child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      fontSize: 18,
                      color: Color(0xFF1F2C5C),
                    ),
                  ),
                )
              ],
            ),
          ),
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
