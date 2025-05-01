import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:safe_chat/pages/messages.dart';
import 'package:safe_chat/pages/search_page.dart';
import 'package:safe_chat/pages/widget/hendel_messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> messages = [
    {
      'name': 'Tareq Kh',
      'message': 'Hello! How are you doing?',
      'time': '2:45 PM',
      'photoUrl': 'assets/tarq.jpg',
    },
    {
      'name': 'Ali B.',
      'message': 'Are we meeting today?',
      'time': '1:30 PM',
      'photoUrl': 'assets/tarq.jpg',
    },
    // Add more messages here
  ];

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')),
  ];
  bool _searchTabTappedOnce = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: GNav(
            rippleColor: Colors.grey[800]!,
            hoverColor: Colors.grey[700]!,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
            ],
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 900),
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.black,
            iconSize: 24,
            tabBackgroundColor: Colors.black.withOpacity(0.1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tabs: [
              GButton(icon: LineIcons.home, text: 'Home'),
              GButton(icon: LineIcons.search, text: 'Search'),
              GButton(icon: LineIcons.user, text: 'Profile'),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              if (index == 1) {
                if (_searchTabTappedOnce) {
                  _searchTabTappedOnce = false;

                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  });
                } else {
                  _searchTabTappedOnce = true;

                  setState(() {
                    _selectedIndex = index;
                  });

                  Future.delayed(Duration(seconds: 2), () {
                    _searchTabTappedOnce = false;
                  });
                }
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
            
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Messages',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return MessageItem(
                    name: msg['name']!,
                    message: msg['message']!,
                    time: msg['time']!,
                    photoUrl: msg['photoUrl']!,
                    onTap: () => handleMessageTap(context, msg),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
