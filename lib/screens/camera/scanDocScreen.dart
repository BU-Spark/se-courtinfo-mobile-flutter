import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';

class ScanDocScreen extends StatefulWidget {
  final int minPageCount;

  const ScanDocScreen({required this.minPageCount});

  @override
  _ScanDocScreen createState() => _ScanDocScreen();
}

class _ScanDocScreen extends State<ScanDocScreen> {
  List<String> _pictures = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Initialize the camera view
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }

  bool _morePicAllowed() {
    // check whether the user is able to take more pictures (page.length < minPageCount)
    return _pictures.length < widget.minPageCount;
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool morePicAllowed = _morePicAllowed();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff1f2c5c)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('home'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(50, 20, 50, 50),
        width: double.infinity,
        height: 896,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                  'Scanning Document - ${widget.minPageCount} pages required.'),
            ),

            GestureDetector(
              child: SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pictures.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      GestureDetector(
                        onTap: () {
                          // view a page in full-screen view
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.file(
                            File(_pictures[index]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _onDeletePicture(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.close, size: 16),
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ),

            // Retake button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: Color(0xff1f2c5c),
                        width: 2.0,
                      ),
                    ),
                    backgroundColor: Colors.white, // Background color
                  ),
                  onPressed: onRetake,
                  child: const Text(
                    'Retake',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.6699999173,
                      color: Color(0xff1f2c5c),
                    ),
                  ),
                ),

                // Add More Pictures button (if available)
                if (morePicAllowed) const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    backgroundColor: const Color(0xff1f2c5c),
                  ),
                  onPressed: _addMorePicture,
                  child: const Text(
                    'Add more pages',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.6699999173,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1F2C5C),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => _onNavigate(-1),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${_currentIndex + 1}/${_pictures.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.6699999173,
                    color: Color(0xff1f2c5c),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1F2C5C),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () => _onNavigate(1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Submit button
            if (!morePicAllowed)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  backgroundColor: const Color(0xff1f2c5c),
                ),
                onPressed: _onSubmit,
                child: const Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.6699999173,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onRetake() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }

  void _onDeletePicture(int index) {
    setState(() {
      _pictures.removeAt(index);
    });
  }

  void _onNavigate(int step) {
    int newIndex = _currentIndex + step;
    if (newIndex >= 0 && newIndex < _pictures.length) {
      setState(() {
        _currentIndex = newIndex;
        _pageController.animateToPage(
          newIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _addMorePicture() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures.addAll(pictures);
      });
    } catch (exception) {
      // Handle exception here
    }
  }

  void _onSubmit() async {
    if (_pictures.length == widget.minPageCount) {
      // implement API post
      // loading page
      context.goNamed('home');
    } else {
      // error message shown: need more pic
      final snackBar = SnackBar(
        content: Text(
          'You need to scan exactly ${widget.minPageCount} pages.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
