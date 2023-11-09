import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import '../../models/upload.dart';
import '../../providers/upload_provider.dart';
import '../../utility/dialogs/common_dialog.dart';
import '../../utility/dialogs/picture_dialog.dart';
import 'package:provider/provider.dart';


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

  Future<void> initPlatformState() async { // Initialize the camera view
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      print('Exception occurred: $exception');
    }
  }
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final uploadProvider = Provider.of<UploadProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff1f2c5c)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:() => _showActionConfirm('home'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        width: double.infinity,
        height: 920,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            GestureDetector(
              child: SizedBox(
                height: 300,
                child: PageView.builder(
                  // View scanned documents
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
                          _showFullScreenDialog(context,
                              index); // View a page in full-screen view
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
                        child: GestureDetector(// Delete the selected photo
                          onTap: () => _onDeletePicture(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 212, 22, 22),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton( // "Retake" button
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: Color(0xff1f2c5c),
                        width: 2.0,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () => _showActionConfirm('retake'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Retake',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.6699999173,
                          color: Color(0xff1f2c5c),
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.photo_camera,
                        color: Color(0xff1f2c5c),
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton( //"Add More Pages" button
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: Color(0xff1f2c5c),
                        width: 2.0,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: _addMorePicture,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Add More Pages',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.6699999173,
                          color: Color(0xff1f2c5c),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '+',
                        style: TextStyle(
                          color: Color(0xff1f2c5c),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row( // Last page & next page buttons, pagination
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1F2C5C),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                        onPressed: () => _onNavigate(-1),
                      ),
                    ),
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
                SizedBox(
                  width: 28,
                  height: 28,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1F2C5C),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                        onPressed: () => _onNavigate(1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Container( // Submit button
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      backgroundColor: const Color(0xff1f2c5c),
                    ),
                    onPressed: () => _onSubmit(uploadProvider),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.6699999173,
                      color: Color(0xff1f2c5c),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onRetake() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      print('Exception occurred: $exception');
    }
  }

Future<void> _showActionConfirm(String action) async { // Trigger the dialog
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        if (action == 'retake'){ // Retake dialog
          return CommonDialog (
            title: 'Retake all documents',
            actionText: 'Retake',
            onAction: () { // Call the onRetake function to delete pictures and rescan documents
              _onRetake();
            },
        );
        }
        else { // Home dialog
          return CommonDialog(
            title: 'Go back to the home page',
            actionText: 'Home',
            onAction: () {
              context.goNamed('home');
            },
        );
        }
      },
    );
  }

  void _showFullScreenDialog(BuildContext context, int index) { // View selected photo in full screen
    showDialog(
      context: context,
      builder: (context) {
        return FullScreenDialog(imageFile: File(_pictures[index]));
      },
    );
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
      print('Exception occurred: $exception');
    }
  }
  
  void _onDeletePicture(int index) {
    setState(() {
      _pictures.removeAt(index);
    });
    if (_currentIndex >= _pictures.length) {
      _currentIndex = _pictures.length - 1;
    }
  }

  void _onNavigate(int step) { // Page Navigation
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

  Future<void> _onSubmit(UploadProvider uploadProvider) async { // Check whether the user has scanned the required num of pages before submission.
    if (_pictures.length == widget.minPageCount) { // need to add /upload API later on
      uploadProvider.uploadFiles(_pictures);
      // context.goNamed('docEdit');
    } else { // error message shown: need more pic
      final snackBar = SnackBar(
        content: Text(
          'You need to scan exactly ${widget.minPageCount} pages.',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}