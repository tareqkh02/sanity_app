import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_chat/pages/search_page.dart';

Widget bottomNavigationBar(BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 40,
          width: 300,
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
                  width: 10,
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
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  child: CircleAvatar(
                    maxRadius: 15,
                    child: SvgPicture.asset(
                      'assets/search-alt-1-svgrepo-com.svg',
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
    ],
  );
}
