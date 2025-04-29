import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
Widget bottomNavigationBar() {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Color.fromARGB(255, 156, 156, 160),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    maxRadius: 15,
                    child: SvgPicture.asset(
                      'assets/message-square-svgrepo-com.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    maxRadius: 15,
                    child: SvgPicture.asset(
                      'assets/profile-2-svgrepo-com.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(
        width: 160,
      ),
      Container(
        height: 35,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black),
            color: Colors.black),
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child: SvgPicture.asset(
            'assets/search-alt-1-svgrepo-com.svg',
            color: Colors.white,
            height: 20,
            width: 20,
          ),
        ),
      ),
    ],
  );
}
