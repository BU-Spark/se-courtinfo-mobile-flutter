import 'package:flutter/material.dart';

class NewDocumentScreen extends StatefulWidget {
  const NewDocumentScreen({Key? key}) : super(key: key);

  @override
  State<NewDocumentScreen> createState() => _NewDocumentScreenState();
}

class _NewDocumentScreenState extends State<NewDocumentScreen> {
  final _searchController = TextEditingController();

  void _navOnPressed(String id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 227,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search",
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        icons: [
          IconButton(
            onPressed: () => _navOnPressed("1"),
            icon: Icon(
              Icons.folder_open_outlined,
              color: Colors.blueAccent,
            ),
          ),
          // IconButton(
          //   onPressed: () => _navOnPressed("2"),
          //   icon: icon,
          // ),
          IconButton(
            onPressed: () => _navOnPressed("3"),
            icon: Icon(
              Icons.settings,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, required this.icons}) : super(key: key);
  final List<IconButton> icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        children: <IconButton>[],
      ),
    );
  }
}
