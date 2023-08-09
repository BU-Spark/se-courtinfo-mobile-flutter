import 'dart:io';
import 'package:flutter/material.dart';

class FullScreenDialog extends StatelessWidget {
  final File imageFile;

  const FullScreenDialog({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color of the dialog
      body: GestureDetector(
        onTap: () {
          // When tapping on the side of the picture, close the dialog and go back to ScanDocScreen
          Navigator.of(context).pop();
        },
        child: Center(
          child: Stack(
            children: [
              Image.file(
                imageFile,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: () { // When clicking on the close button, close the dialog and go back to ScanDocScreen
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Colors.red, 
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
