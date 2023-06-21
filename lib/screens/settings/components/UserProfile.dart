import 'package:courtinfo_spark/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  // String fstName = context.read<SignUp>().nameSlider(),

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: kPrimaryColor,
              child: Text(
                "JA", 
                // Text('The name is ${context.watch<SignUp>()._fstName})')
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "John Appleseed",
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "District Attorney of Massachusetts",
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
          ],
        ),
      ),
    );
  }
}
