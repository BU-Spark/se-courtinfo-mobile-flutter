import 'package:flutter/material.dart';
import '../widgets/BottomNavBar.dart';
import '../widgets/DocumentsListView.dart';

class NewDocumentScreen extends StatefulWidget {
  const NewDocumentScreen({Key? key}) : super(key: key);

  @override
  State<NewDocumentScreen> createState() => _NewDocumentScreenState();
}

class _NewDocumentScreenState extends State<NewDocumentScreen> {
  final _searchController = TextEditingController();
  void _navOnPressed(String id) {}
  final List<String> testArr = [
    "bye",
    "yeet",
    "sheeeesh",
    "yolo",
    "ayy",
    "hello",
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double widthPadding = queryData.size.width * 0.05;
    double heightPadding = queryData.size.height * 0.02;
    final double iconSize = queryData.size.width * 0.18;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // search bar
            Padding(
              padding: EdgeInsets.only(
                left: widthPadding,
                right: widthPadding,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 3.0,
                        offset: Offset(0, 2.0)),
                  ],
                ),
                width: queryData.size.width,
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(fontSize: 16.0),
                  decoration: const InputDecoration(
                    hintText: "Search",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      gapPadding: 1.0,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            // documents menu bar
            Padding(
              padding: EdgeInsets.only(
                left: widthPadding,
                right: widthPadding,
                top: heightPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Documents",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        splashRadius: 1.0,
                        onPressed: () => {print("Pressed create new folder!")},
                        icon: Icon(
                          Icons.create_new_folder,
                          size: 28.0,
                          color: Colors.blueAccent.withOpacity(0.5),
                        ),
                      ),
                      IconButton(
                        splashRadius: 1.0,
                        onPressed: () => {print("Pressed open filter")},
                        icon: Icon(
                          Icons.menu,
                          size: 28.0,
                          color: Colors.blueAccent.withOpacity(0.5),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // documents listviews
            Expanded(
              flex: 5,
              child: DocumentsListView(
                docArray: testArr,
                heightPadding: heightPadding,
                widthPadding: widthPadding,
                isDescending: true,
              ),
            )
          ],
        ),
      ),
      // middle navigation button
      floatingActionButton: Container(
        height: iconSize + 10,
        width: iconSize + 10,
        child: FloatingActionButton(
          onPressed: () => _navOnPressed(''),
          child: Icon(
            Icons.camera_alt,
            size: iconSize / 1.5,
          ),
          backgroundColor: Color.fromARGB(255, 5, 44, 75),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // left & right nav buttons
      bottomNavigationBar: BottomNavBar(
        navOnPressed: _navOnPressed,
      ),
    );
  }
}
