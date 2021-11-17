import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentList extends StatefulWidget {
  final bool isDescending;
  final List<String> listEntry;
  ContentList({required this.isDescending, required this.listEntry});

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listEntry = widget.listEntry;
    final List<String> descendingList = listEntry
      ..sort((b, a) => a.compareTo(b));
    final List<String> ascendingList = new List.from(descendingList.reversed);
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: listEntry.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: new Image(
            image: new AssetImage("lib/assets/folder.png"),
            height: 40.0,
            width: 40.0,
          ),
          title: Text(widget.isDescending
              ? descendingList[index]
              : ascendingList[index]),
          onTap: () {},
        ),
      ),
    );
  }
}

class ContentGrid extends StatefulWidget {
  final bool isDescending;
  final List<String> listEntry;
  ContentGrid({required this.isDescending, required this.listEntry});

  @override
  _ContentGridState createState() => _ContentGridState();
}

class _ContentGridState extends State<ContentGrid> {
  @override
  Widget build(BuildContext context) {
    final List<String> listEntry = widget.listEntry;
    final List<String> descendingList = listEntry
      ..sort((b, a) => a.compareTo(b));
    final List<String> ascendingList = new List.from(descendingList.reversed);
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 6,
      itemBuilder: (context, index) => Card(
        child: GridTile(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Image(
                image: AssetImage(
                  "lib/assets/folder.png",
                ),
                width: 120,
                height: 120,
              ),
              Text(widget.isDescending
                  ? descendingList[index]
                  : ascendingList[index])
            ],
          ),
        ),
      ),
    );
  }
}
