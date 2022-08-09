import 'package:flutter/material.dart';

class DocumentsListView extends StatelessWidget {
  const DocumentsListView({
    Key? key,
    required this.docArray,
    required this.heightPadding,
    required this.widthPadding,
    required this.isDescending,
  }) : super(key: key);

  final List<String> docArray;
  final double heightPadding;
  final double widthPadding;
  final bool isDescending;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: docArray.length,
      itemBuilder: (context, index) {
        return LimitedBox(
          maxHeight: 100 + heightPadding,
          child: Container(
            padding: EdgeInsets.only(
              top: heightPadding / 2,
              bottom: heightPadding / 2,
              left: widthPadding,
              right: widthPadding,
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                        color: Colors.grey.withOpacity(0.25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: widthPadding,
                    top: 4.0,
                    bottom: 4.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        docArray[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "6/22/2022  16:10",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.article,
                            color: Colors.grey,
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
