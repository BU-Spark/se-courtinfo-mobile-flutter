import 'package:flutter/material.dart';

import '../../../constants.dart';

class SettingsList extends StatelessWidget {
  const SettingsList(
      {super.key,
      required String label,
      required IconData icon,
      required Function() onTap})
      : _label = label,
        _icon = icon,
        _onTap = onTap;

  final String _label;
  final IconData _icon;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(_icon, size: 30, color: kPrimaryColor),
                const SizedBox(width: 20),
                Text(
                  _label,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: kSecondaryColor),
          ],
        ),
      ),
    );
  }
}
