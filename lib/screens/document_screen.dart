import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DocumentScreen extends StatefulWidget {
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final blue = const Color(0xFF1F2C5C);
  final grey = const Color(0xFFB8BFD7);
  final fill = const Color(0xFFF4F6FB);
  final grey2 = const Color(0xFFB8BFD7);
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = LabeledGlobalKey("button_icon");
    late OverlayEntry _overlayEntry;
    late Size buttonSize;
    late Offset buttonPosition;
    bool isMenuOpen = false;
    double screenWidth = MediaQuery.of(context).size.width;
    final List<String> filterEntry = <String>[
      'Name',
      'Last Modified',
      'Last Opend',
      'File type'
    ];
    final List<String> orderEntry = <String>['Ascending', 'Descending'];
    final List<String> typeEntry = <String>['List', 'Grid'];
    findButton() {
      RenderBox renderBox =
          _key.currentContext?.findRenderObject() as RenderBox;
      buttonSize = renderBox.size;
      buttonPosition = renderBox.localToGlobal(Offset.zero);
    }

    OverlayEntry _overlayEntryBuilder() {
      return OverlayEntry(
        builder: (context) {
          return Positioned(
            top: buttonPosition.dy + buttonSize.height + 20,
            right: screenWidth - buttonPosition.dx - 20,
            width: 320,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    width: 320,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFF4F6FB),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                            child: Text(
                              'Sort by: ',
                              style: TextStyle(
                                  color: Color(0xFF6774A6),
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: Color(0xFFB8BFD7))),
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: filterEntry.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      '${filterEntry[index]}',
                                      style: TextStyle(
                                          color: Color(0xFFB8BFD7),
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: Color(0xFFB8BFD7))),
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: orderEntry.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      '${orderEntry[index]}',
                                      style: TextStyle(
                                          color: Color(0xFFB8BFD7),
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: typeEntry.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      '${typeEntry[index]}',
                                      style: TextStyle(
                                          color: Color(0xFFB8BFD7),
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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

    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: 30,
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
            Image(
              image: AssetImage("lib/assets/FolderIcon.png"),
              height: 25.0,
            ),
            GestureDetector(
              key: _key,
              onTap: () => {
                if (isMenuOpen) {closeMenu()} else {openMenu()}
              },
              child: Image(
                image: AssetImage("lib/assets/FilterIcon.png"),
                height: 25.0,
              ),
            ),
          ])),
      SizedBox(height: 55),
      Padding(
        padding: EdgeInsets.fromLTRB(10, 45, 50, 20),
        child: Image(
          image: AssetImage("lib/assets/Documentbackgroundpic.png"),
          height: 225.0,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text('Uh oh, you don’t have any documents yet!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 17,
            color: blue,
          )),
      SizedBox(
        height: 10,
      ),
      Text('Start scanning some files to get started.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 14,
            color: grey,
          )),
      Expanded(
          child: new Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: new BoxDecoration(color: Colors.white),
          height: 80,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 10,
                left: 60,
                child: Icon(
                  Icons.folder_open,
                  size: 35,
                  color: Color(0xFF1F2C5C),
                ),
              ),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () =>
                          {Navigator.of(context).pushNamed('CameraPage')},
                      child: Image(
                        image: AssetImage("lib/assets/Camera.png"),
                        height: 80.0,
                      ),
                    )),
              ),
              Positioned(
                bottom: 10,
                right: 60,
                child: Icon(
                  Icons.settings,
                  color: grey2,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ))
    ]));
  }
}
