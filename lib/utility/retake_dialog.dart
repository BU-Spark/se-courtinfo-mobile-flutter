import 'package:flutter/material.dart';

class RetakeDialog extends StatefulWidget {
  final VoidCallback onRetake;

  const RetakeDialog({required this.onRetake});

  @override
  _RetakeDialogState createState() => _RetakeDialogState();
}

class _RetakeDialogState extends State<RetakeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Retake Confirmation'),
      content: const Text(
          'Do you want to delete all pictures and rescan the documents from the beginning?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.6699999173,
              color: Color(0xff1f2c5c),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            backgroundColor: const Color(0xff1f2c5c),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onRetake(); // Call the onRetake callback
          },
          child: const Text(
                    'Retake',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.6699999173,
                      color: Colors.white,
                    ),
                  ),
        ),
      ],
    );
  }
}
