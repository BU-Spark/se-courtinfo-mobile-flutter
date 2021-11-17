import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scdao_mobile/widgets/Filter.dart';
import 'package:scdao_mobile/widgets/ListGrid.dart';
import 'dart:developer';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final blue = const Color(0xFF1F2C5C);
  final grey = const Color(0xFFB8BFD7);
  final fill = const Color(0xFFF4F6FB);
  final grey2 = const Color(0xFFB8BFD7);
  bool isDescending = false;
  bool isGrid = false;
  bool isContent = true;
  int _selectedType = 0;
  int _selectedOrder = 0;
  int _selectedFilter = 0;
  bool isMenuOpen = false;
  List<String> listEntry = <String>[
    'E Form',
    'B Form',
    'C Form',
    'D Form',
    'A Form',
    'F Form'
  ];
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = LabeledGlobalKey("button_icon");
    late OverlayEntry _overlayEntry;
    late Size buttonSize;
    late Offset buttonPosition;
    double screenWidth = MediaQuery.of(context).size.width;
    int _selectedIndex = 0;

    findButton() {
      RenderBox renderBox =
          _key.currentContext?.findRenderObject() as RenderBox;
      buttonSize = renderBox.size;
      buttonPosition = renderBox.localToGlobal(Offset.zero);
    }

    OverlayEntry _overlayEntryBuilder() {
      return OverlayEntry(
        builder: (BuildContext context) {
          return Positioned(
            top: buttonPosition.dy + buttonSize.height + 20,
            right: screenWidth - buttonPosition.dx - 20,
            width: 320,
            child: OverlayClass(
                typeindex: (selectedType) {
                  _selectedType = selectedType;
                },
                filterindex: (selectedFilter) {
                  _selectedFilter = selectedFilter;
                },
                orderindex: (selectedOrder) {
                  _selectedOrder = selectedOrder;
                },
                selectedFilter: _selectedFilter,
                selectedOrder: _selectedOrder,
                selectedType: _selectedType),
          );
        },
      );
    }

    void openMenu() {
      findButton();
      _overlayEntry = _overlayEntryBuilder();
      Overlay.of(context)!.insert(_overlayEntry);
      isMenuOpen = !isMenuOpen;
    }

    void closeMenu() {
      _overlayEntry.remove();

      isMenuOpen = !isMenuOpen;
    }

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      if (index == 1) {
        Navigator.of(context).pushNamed('CameraPage');
      }
    }

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your Documents',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          fontSize: 28,
                          color: blue,
                        )),
                    Text('Select',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 17,
                          color: grey,
                        )),
                  ])),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 227,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          fillColor: fill,
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    GestureDetector(
                      key: _key,
                      onTap: () => {
                        if (isMenuOpen)
                          {
                            closeMenu(),
                            setState(() {
                              if (_selectedType == 1) {
                                isGrid = true;
                              } else {
                                isGrid = false;
                              }
                              if (_selectedOrder == 1) {
                                isDescending = true;
                              } else {
                                isDescending = false;
                              }
                            }),
                            log('$isDescending')
                          }
                        else
                          {openMenu()}
                      },
                      child: Image(
                        image: AssetImage("lib/assets/FilterIcon.png"),
                        height: 25.0,
                      ),
                    ),
                  ])),
          isGrid
              ? ContentGrid(
                  isDescending: isDescending,
                  listEntry: listEntry,
                )
              : ContentList(
                  isDescending: isDescending,
                  listEntry: listEntry,
                ),
          //  Container(
          //     child: Column(
          //       children: [
          //         SizedBox(height: 55),
          //         Padding(
          //           padding: EdgeInsets.fromLTRB(10, 45, 50, 20),
          //           child: Image(
          //             image: AssetImage(
          //                 "lib/assets/Documentbackgroundpic.png"),
          //             height: 225.0,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         Text('Uh oh, you don’t have any documents yet!',
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontFamily: 'Inter',
          //               fontSize: 17,
          //               color: blue,
          //             )),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         Text(
          //           'Start scanning some files to get started.',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontFamily: 'Inter',
          //             fontSize: 14,
          //             color: grey,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
        ],
      ),
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
