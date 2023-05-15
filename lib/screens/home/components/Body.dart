import 'package:courtinfo_spark/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
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
                width: size.width * 0.6,
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
              const Icon(Icons.filter_list, size: 40, color: kSecondaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
