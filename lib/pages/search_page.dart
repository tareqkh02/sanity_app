import 'package:flutter/material.dart';
import 'package:safe_chat/Apis/Apis.dart';
import 'package:safe_chat/pages/messages.dart';
import 'package:safe_chat/pages/widget/hendel_messages.dart';

class User {
  final String name;
  final String email;
  final String photoUrl;
  final String id ;

  User({
    required this.name,
    required this.email,
    required this.id,
    this.photoUrl = 'assets/default_avatar.png',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      id: json['id']
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = [];
  }

  void _filterUsers(String query) async {
    if (query.isEmpty) {
      setState(() => filteredUsers = []);
      return;
    }

    try {
      final results = await searchUsers(query, context);
      final users = results.map((data) => User.fromJson(data)).toList();

      setState(() {
        filteredUsers = users;
      });
    } catch (e) {
      print("Search failed: $e");
      setState(() => filteredUsers = []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Select Members',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
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
                  id: user.id,
                  name: user.name,
                  email: user.email,
                  time: 'Online',
                  photoUrl: user.photoUrl,
                  onTap: () => handleMessageTap(context, {
                    'id':user.id,
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
