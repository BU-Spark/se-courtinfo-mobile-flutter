import 'package:flutter/material.dart';

class CommonDialog extends StatefulWidget {
  final String title;
  final String actionText;
  final VoidCallback onAction;

  CommonDialog({
    required this.title,
    required this.actionText,
    required this.onAction,
  });

  @override
  _CommonDialogState createState() => _CommonDialogState();
}

class _CommonDialogState extends State<CommonDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 180, 20, 180),
        child: AlertDialog(
          title: Center(child: Text(widget.title)),
          content: const Text('Do you want to clean all the shooting records?'),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  backgroundColor: const Color(0xff1f2c5c),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onAction(); // Call the onAction callback
                },
                child: Text(
                  widget.actionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.6699999173,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.6699999173,
                    color: Color.fromARGB(255, 212, 22, 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
