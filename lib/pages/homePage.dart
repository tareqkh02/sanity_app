import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:safe_chat/Apis/Apis.dart';
import 'package:safe_chat/pages/messages.dart';
import 'package:safe_chat/pages/profilepage.dart';
import 'package:safe_chat/pages/search_page.dart';
import 'package:safe_chat/pages/widget/hendel_messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    getUserId(context);
    getUserId(context);
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    try {
      final List<dynamic> data = await getAllChats(context);

      final List<Map<String, String>> formatted =
          data.map<Map<String, String>>((chat) {
        final id = chat['id']?.toString() ?? 'Unknown';
        final members = chat['members'] as List<dynamic>? ?? [];
        final messages = chat['messages'] as List<dynamic>? ?? [];

        String chatId = 'Unknown';
        String name = 'Unknown';
        String photoUrl = '';
        String message = '';
        String time = '';

        if (members.isNotEmpty) {
          final firstMember = members[0] as Map<String, dynamic>;
          chatId = firstMember['chatId']?.toString() ?? 'Unknown';

          final user = firstMember['user'] as Map<String, dynamic>?;

          if (user != null) {
            name = user['name']?.toString() ?? 'Unknown';
            photoUrl = user['image']?.toString() ?? '';
          }
        }

        if (messages.isNotEmpty) {
          final firstMessage = messages[0] as Map<String, dynamic>;
          message = firstMessage['content']?.toString() ?? '';
          time = firstMessage['createdAt']?.toString() ?? '';
        }

        return {
          'chatId': chatId,
          'id': id,
          'name': name,
          'message': message,
          'time': time,
          'photoUrl': photoUrl,
        };
      }).toList();

      setState(() {
        _messages = formatted;
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')),
  ];
  bool _searchTabTappedOnce = false;
  bool _profileTabTappedOnce = false;
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
              }
              if (index == 2) {
                if (_profileTabTappedOnce) {
                  _profileTabTappedOnce = false;

                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessengerMenuPage()),
                    );
                  });
                } else {
                  _profileTabTappedOnce = true;

                  setState(() {
                    _selectedIndex = index;
                  });

                  Future.delayed(Duration(seconds: 2), () {
                    _profileTabTappedOnce = false;
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
        onPressed: () {},
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
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
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
