import 'package:flutter/material.dart';
import 'Folder.dart';

class DocumentsGridView extends StatelessWidget {
  const DocumentsGridView({
    Key? key,
    required this.folder,
  }) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double widthPadding = queryData.size.width * 0.05;
    double heightPadding = queryData.size.height * 0.02;

    return folder.documents.length + folder.subfolders.length != 0
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            shrinkWrap: true,
            itemCount: folder.documents.length + folder.subfolders.length,
            itemBuilder: (context, index) {
              if (index < folder.subfolders.length) {
                return LimitedBox(
                maxHeight: 150 + heightPadding,
                child: Container(
                  padding: EdgeInsets.only(
                    top: heightPadding / 2,
                    bottom: heightPadding / 2,
                    left: widthPadding,
                    right: widthPadding,
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: folder.subfolders[index].isEmpty() ? 
                        AssetImage('lib/assets/emptyFolder.png') :
                        AssetImage('lib/assets/folder.png'),
                        width: 85,
                        height: 85,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: widthPadding,
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              folder.subfolders[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
              }
              else {
                return LimitedBox(
                maxHeight: 150 + heightPadding,
                child: Container(
                  padding: EdgeInsets.only(
                    top: heightPadding / 2,
                    bottom: heightPadding / 2,
                    left: widthPadding,
                    right: widthPadding,
                  ),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('lib/assets/File.png'),
                        width: 85,
                        height: 85,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: widthPadding,
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              folder.documents[index-folder.subfolders.length],
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
              }
              
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Uh oh, you don't have any document!",
                style: TextStyle(
                  color:
                      Color.fromARGB(255, 18, 55, 121), //TODO: change to theme
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Start scanning files to get started",
                style: TextStyle(
                  color: Colors.grey, //TODO: change to theme
                  fontSize: 14,
                ),
              )
            ],
          );
  }
}
