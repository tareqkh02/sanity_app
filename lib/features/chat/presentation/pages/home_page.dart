import 'package:flutter/material.dart';
import 'package:safe_chat/features/chat/presentation/pages/search_page.dart';
import 'package:safe_chat/features/chat/presentation/widgets/bottom_nav_bar.dart';
import 'package:safe_chat/features/chat/presentation/widgets/message_item.dart';
import 'package:safe_chat/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildMessagesTab(),
          const SearchPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: ChatBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget _buildMessagesTab() {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: _messages.isEmpty
          ? const Center(child: Text('No messages yet'))
          : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return MessageItem(
                  name: msg['name']!,
                  message: msg['message'],
                  time: msg['time'] ?? '',
                  photoUrl: msg['photoUrl'] ?? '',
                );
              },
            ),
    );
  }
}
