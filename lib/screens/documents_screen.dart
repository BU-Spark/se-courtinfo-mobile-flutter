import 'package:flutter/material.dart';
import 'package:scdao_mobile/widgets/Folder.dart';
import '../widgets/DocumentsListView.dart';
import '../widgets/DocumentsGridView.dart';
import '../widgets/Filter.dart';

class DocumentsScreen extends StatefulWidget {
  final String? subRoute;
  const DocumentsScreen({Key? key, this.subRoute}) : super(key: key);
  static const routeName = '/documents';

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final _searchController = TextEditingController();
  late OverlayEntry _selectMenu;
  late OverlayEntry _createFolderWindow;
  int _selectedType = 0;
  int _selectedOrder = 0;
  int _selectedFilter = 0;
  bool displayMenu = false;
  List<Folder> displayFolders = [];
  List<String> displayDocuments = [];
  //TODO: change type from String to a document data model
  Folder folder = new Folder(documents: [
    "bye",
    "yeet",
    "sheeeesh",
    "yolo",
    "ayy",
    "hello",
  ], name: "Root folder");

  @override
  void initState() {
    displayFolders = List.from(folder.subfolders);
    displayDocuments = List.from(folder.documents);
    super.initState();
    _searchController.addListener(() {
      setState(() {
        displayFolders = folder.subfolders
            .where((doc) => doc.name.contains(_searchController.text))
            .toList();
        displayDocuments = folder.documents
            .where((doc) => doc.contains(_searchController.text))
            .toList();
        if (_selectedOrder == 0) {
          displayFolders.sort((a, b) => a.name.compareTo(b.name));
          displayDocuments.sort((a, b) => a.compareTo(b));
        } else {
          displayFolders.sort((a, b) => b.name.compareTo(a.name));
          displayDocuments.sort((a, b) => b.compareTo(a));
        }
      });
    });
  }

  void _setTypeIndex(int value) {
    setState(() {
      _selectedType = value;
    });
  }

  void _setFilterIndex(int value) {
    setState(() {
      _selectedFilter = 0;
    });
  }

  void _setOrderIndex(int value) {
    setState(() {
      _selectedOrder = value;
      if (_selectedOrder == 0) {
        displayFolders.sort((a, b) => a.name.compareTo(b.name));
        displayDocuments.sort((a, b) => a.compareTo(b));
      } else {
        displayFolders.sort((a, b) => b.name.compareTo(a.name));
        displayDocuments.sort((a, b) => b.compareTo(a));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double widthPadding = queryData.size.width * 0.05;
    double heightPadding = queryData.size.height * 0.02;

    void closeMenu() {
      if (displayMenu) {
        _selectMenu.remove();
        displayMenu = false;
      }
    }

    void closeFolderWindow() {
      if (displayMenu) {
        _createFolderWindow.remove();
        displayMenu = false;
      }
    }

    void createFolder(String name) {
      setState(() {
        Folder newFolder = Folder(name: name,
          superFolder: folder
        );
        folder.subfolders.add(newFolder);
        displayFolders.add(newFolder);
        closeFolderWindow();
      });
    }

    OverlayEntry _selectMenuBuilder() {
      return OverlayEntry(builder: (context) {
        return Positioned(
            top: 120,
            left: 60,
            child: Filter(
                typeindex: _setTypeIndex,
                filterindex: _setFilterIndex,
                orderindex: _setOrderIndex,
                selectedFilter: _selectedFilter,
                selectedOrder: _selectedOrder,
                selectedType: _selectedType));
      });
    }

    OverlayEntry _createFolderBuilder() {
      String name = "Untitled Folder";
      return OverlayEntry(builder: (context) {
        return Positioned(
          width: 250.0,
          height: 200.0,
          top: 280.0,
          left: 80.0,
          child: new Material(
            child: new Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3)  
                )]
              ),

              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "New Folder", 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.blueAccent.withOpacity(0.5)),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: name,
                      ),
                      onChanged: (text) {
                        name = text;
                      }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {closeFolderWindow();},
                          child: Text("Cancel")
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String newName = name;
                            int i = 1;
                            while (folder.checkDuplicateName(newName)) {
                              newName = name + " " + i.toString();
                              i++;
                            }
                            createFolder(newName);
                          }, 
                          child: Text("Create")
                        )
                      ],
                    )
                  ],
                )
              )
            )
          )
        );
      });
    }

    void openMenu() {
      if (!displayMenu) {
        _selectMenu = _selectMenuBuilder();
        Overlay.of(context)!.insert(_selectMenu);
        displayMenu = true;
      }
    }

    void openFolderWindow() {
      if (!displayMenu) {
        _createFolderWindow = _createFolderBuilder();
        Overlay.of(context)!.insert(_createFolderWindow);
        displayMenu = true;
      }
    }

    return Column(
      children: [
        // search bar
        Padding(
          padding: EdgeInsets.only(
            top: 3,
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
                    onPressed: () => {openFolderWindow()},
                    icon: Icon(
                      Icons.create_new_folder,
                      size: 28.0,
                      color: Colors.blueAccent.withOpacity(0.5),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => {
                            if (displayMenu) {closeMenu()} else {openMenu()}
                          },
                      child: Icon(Icons.menu,
                          size: 28, color: Colors.blueAccent.withOpacity(0.5)))
                ],
              )
            ],
          ),
        ),
        // documents listviews
        Expanded(
            flex: 5,
            child: _selectedType == 0
                ? DocumentsListView(
                    folders: displayFolders,
                    documents: displayDocuments,
                  )
                : DocumentsGridView(
                    folders: displayFolders,
                    documents: displayDocuments
                  )
        )
      ],
    );
  }
}
