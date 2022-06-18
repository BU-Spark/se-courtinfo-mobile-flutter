import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// A screen that allows users to take a picture using a given camera.
class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);
  static const String routeName = "/camera";
  final CameraDescription camera;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 60, // Set this height
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1F2C5C),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text('Scan Documents',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      fontSize: 22,
                      color: Color(0XFFFFC032),
                    )),
              ],
            ),
          ),
        ),
        body: Column(children: [
          SizedBox(height: 60),
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Spacer(),
          Container(
            color: Color(0xFF1F2C5C),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(45, 10, 10, 10),
                    child: Icon(
                      Icons.photo,
                      size: 40,
                      color: Colors.white,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 10, 10, 10),
                  child: FloatingActionButton(
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;
                        final image = await _controller.takePicture();
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              imagePath: image.path,
                            ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 26.5,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 23.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
                    child: Image(
                      image: AssetImage("lib/assets/Review.png"),
                      height: 35.0,
                    )),
              ],
            ),
          )
        ]));
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.of(context).pushNamed('reviewPage');
      } else {
        Navigator.of(context).pushNamed('CameraPage');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 60, // Set this height
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(0xFF1F2C5C),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text('Confirm Picture',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    fontSize: 22,
                    color: Color(0XFFFFC032),
                  )),
            ],
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.file(File(imagePath)),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1F2C5C),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "lib/assets/Retake.png",
              width: 40,
              height: 40,
            ),
            label: 'RETAKE',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "lib/assets/Upload.png",
              width: 40,
              height: 40,
            ),
            label: 'UPLOAD',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
