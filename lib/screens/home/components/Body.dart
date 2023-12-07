import 'dart:async';

import 'package:courtinfo_spark/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/upload_provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<List<dynamic>> _docList = [];
  late Timer _timer;

  @override
   void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 100), (timer) {
      // Fetch the latest docList from the provider every 10 seconds
      Provider.of<UploadProvider>(context, listen: false).fetchUploadListDocuments().then((value) {
        setState(() {
          _docList = value;
        });
      });
    });
  }

   @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     _docList = Provider.of<UploadProvider>(context).getDocFiles;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<UploadProvider>(
        builder: (context, provider, child) {
          _docList = provider.getDocFiles;
          return Column(
            children: [
              SizedBox(
                height: height * 0.05,
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(15, 0, 0, 0),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              color: Colors.white),
                          width: width * 0.6,
                          child: const TextField(
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Search',
                              icon: Icon(
                                Icons.search,
                                color: kPlaceholderTextColor,
                              ),
                              hintStyle: TextStyle(
                                color: kPlaceholderTextColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.create_new_folder_rounded,
                            size: 40, color: kSecondaryColor),
                        const Icon(Icons.filter_list,
                            size: 40, color: kSecondaryColor)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: width * 0.92,
                height: height * 0.6,
                child: ListView.builder(
                  itemCount: _docList.length,
                  itemBuilder: (context, index) {
                    // print("items num:  ${_docList.length}");
                    // print('Doc List in UI: $_docList');
                    List<dynamic> document = _docList[index];
                    Color statusTextColor =
                        _getStatusTextColor(document[3].toString());
                    return Container(
                      width: width * 0.9,
                      height: height * 0.128,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${document[1]} - ${document[0]}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Reem Kufi Fun',
                                  fontWeight: FontWeight.w600,
                                  height: 1.0, // Adjust line height as needed
                                  letterSpacing: 0.25,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Submission time: ${document[2]}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Reem Kufi Fun',
                                  fontWeight: FontWeight.w600,
                                  height: 1.0, // Adjust line height as needed
                                  letterSpacing: 0.25,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                " ${document[3]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Reem Kufi Fun',
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                  letterSpacing: 0.25,
                                  color: statusTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _getStatusTextColor(String status) {
    if (status == 'Success') {
      return Colors.green;
    } else if (status == 'Failed') {
      return Colors.red;
    } else if (status == 'Processing') {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }
}
