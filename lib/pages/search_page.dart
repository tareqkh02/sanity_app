import 'package:flutter/material.dart';
import 'package:safe_chat/pages/messages.dart';
import 'package:safe_chat/pages/widget/hendel_messages.dart';

class User {
  final String name;
  final String email;
  final String photoUrl;

  User({required this.name, required this.email, required this.photoUrl});
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> allUsers = [
    User(
      name: 'Tareq kh ',
      email: 'Tareq@example.com',
      photoUrl: 'assets/tarq.jpg',
    ),
    User(
      name: 'Tareq kh ',
      email: 'Tareq@example.com',
      photoUrl: 'assets/tarq.jpg',
    ),
    User(
      name: 'Tareq kh ',
      email: 'Tareq@example.com',
      photoUrl: 'assets/tarq.jpg',
    ),
    User(
      name: 'Tareq kh ',
      email: 'Tareq@example.com',
      photoUrl: 'assets/tarq.jpg',
    ),
    // Add more users as needed
  ];

  List<User> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = allUsers;
  }

  void _filterUsers(String query) {
    final users = allUsers.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Select Members',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 156, 156, 160),
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: TextField(
                onChanged: _filterUsers,
                decoration: InputDecoration(
                  hintText: 'Search by name or email...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return MessageItem(
                  name: user.name,
                  email: user.email,
                  time: 'Online',
                  photoUrl: user.photoUrl,
                  onTap: () => handleMessageTap(context, {
                    'name': user.name,
                    'photoUrl': user.photoUrl,
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
