import 'package:flutter/material.dart';
import 'package:safe_chat/features/chat/presentation/widgets/message_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, String>> _searchResults = [];

  void _filterUsers(String query) {
    // TODO: integrate with ChatRemoteDataSource.searchUsers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Select Members',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 156, 156, 160),
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onChanged: _filterUsers,
                decoration: const InputDecoration(
                  hintText: 'Search by name or email...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final user = _searchResults[index];
                return MessageItem(
                  name: user['name'] ?? '',
                  email: user['email'],
                  time: 'Online',
                  photoUrl: user['photoUrl'] ?? '',
                  onTap: () {
                    // TODO: navigate to conversation
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
