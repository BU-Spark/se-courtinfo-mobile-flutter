import 'package:flutter/material.dart';
import 'package:scdao_mobile/widgets/Filter.dart';
import 'package:scdao_mobile/widgets/ListGrid.dart';
import 'dart:developer';
import 'package:scdao_mobile/riverpod/Provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentScreen extends ConsumerWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blue = const Color(0xFF1F2C5C);
    final grey = const Color(0xFFB8BFD7);
    final fill = const Color(0xFFF4F6FB);
    final grey2 = const Color(0xFFB8BFD7);
    bool isContent = true;
    int _selectedType = 0;
    int _selectedOrder = 0;
    int _selectedFilter = 0;
    bool isMenuOpen = false;

    GlobalKey _key = LabeledGlobalKey("button_icon");
    late OverlayEntry _overlayEntry;
    late Size buttonSize;
    late Offset buttonPosition;
    double screenWidth = MediaQuery.of(context).size.width;
    final _selectedIndex = ref.watch(selectedIndex);
    final String value = ref.watch(helloWorldProvider);
    final isDescending = ref.watch(is_Descending);
    final isGrid = ref.watch(is_Grid);
    final searchEntry = ref.watch(list_Entry);
    final listEntry = ref.watch(search_Entry);

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
      ref.read(selectedIndex.state).state = index;
      if (index == 1) {
        Navigator.of(context).pushNamed('CameraPage');
      } else if (index == 2) {
        Navigator.of(context).pushNamed('settingsPage');
      }
    }

    void searchFiles(String query) {
      final searchedfiles = searchEntry.where((fileName) {
        final filesLower = fileName.toLowerCase();
        final searchLower = query.toLowerCase();
        return filesLower.contains(searchLower);
      }).toList();
      if (query.length != 0) {
        ref.read(search_Entry.state).state = searchedfiles;
      } else {
        ref.read(search_Entry.state).state = searchEntry;
      }
      log('$searchEntry');
    }

    return Scaffold(
      backgroundColor: Color(0xFFF4F6FB),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value,
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
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            fillColor: fill,
                            filled: true,
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (searchText) =>
                              {searchFiles(searchController.text)}),
                    ),
                    GestureDetector(
                      key: _key,
                      onTap: () => {
                        if (isMenuOpen)
                          {
                            closeMenu(),
                            if (_selectedType == 1)
                              {ref.read(is_Grid.state).state = true}
                            else
                              {ref.read(is_Grid.state).state = false},
                            if (_selectedOrder == 1)
                              {ref.read(is_Descending.state).state = true}
                            else
                              {ref.read(is_Descending.state).state = false},
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
