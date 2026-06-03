import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class ChatBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTabChange;

  const ChatBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: GNav(
        rippleColor: Colors.grey[800]!,
        hoverColor: Colors.grey[700]!,
        haptic: true,
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        tabBorder: Border.all(color: Colors.grey, width: 1),
        tabShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 8,
          ),
        ],
        curve: Curves.easeOutExpo,
        duration: const Duration(milliseconds: 900),
        gap: 8,
        color: Colors.grey[800],
        activeColor: Colors.black,
        iconSize: 24,
        tabBackgroundColor: Colors.black.withValues(alpha: 0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tabs: const [
          GButton(icon: LineIcons.home, text: 'Home'),
          GButton(icon: LineIcons.search, text: 'Search'),
          GButton(icon: LineIcons.user, text: 'Profile'),
        ],
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
