import 'package:flutter/material.dart';

Widget contentListView() {
  return ListView.builder(
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: 6,
    itemBuilder: (context, index) => Card(
      child: ListTile(
        leading: new Image(
          image: new AssetImage("lib/assets/folder.png"),
          height: 40.0,
          width: 40.0,
        ),
        title: Text(index.toString()),
        onTap: () {},
      ),
    ),
  );
}

Widget contentGridView() {
  return GridView.builder(
    physics: const ClampingScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
            Text('blablabla')
          ],
        ),
      ),
    ),
  );
}
