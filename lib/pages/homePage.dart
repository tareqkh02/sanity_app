import 'package:flutter/material.dart';
import 'package:safe_chat/pages/bottomNavigationBar.dart';
import 'package:safe_chat/pages/messages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
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
                child: ListView(children: [
              MessageItem(
                name: "Tareq Kh ",
                message: "Hello! How are you doing?",
                time: "2:45 PM",
                photoUrl: "assets/tarq.jpg",
                onTap: () {
                  print("Tapped on John");
                },
              ),
              MessageItem(
                name: "Tareq Kh ",
                message: "Hello! How are you doing?",
                time: "2:45 PM",
                photoUrl: "assets/tarq.jpg",
                onTap: () {
                  print("Tapped on John");
                },
              ),
              MessageItem(
                name: "Tareq Kh ",
                message: "Hello! How are you doing?",
                time: "2:45 PM",
                photoUrl: "assets/tarq.jpg",
                onTap: () {
                  print("Tapped on John");
                },
              ),
              MessageItem(
                name: "Tareq Kh ",
                message: "Hello! How are you doing?",
                time: "2:45 PM",
                photoUrl: "assets/tarq.jpg",
                onTap: () {
                  print("Tapped on John");
                },
              ),
              MessageItem(
                name: "Tareq Kh ",
                message: "Hello! How are you doing?",
                time: "2:45 PM",
                photoUrl: "assets/tarq.jpg",
                onTap: () {
                  print("Tapped on John");
                },
              ),
              MessageItem(
                name: "Tareq Kh ",
                message: "Hello! How are you doing?",
                time: "2:45 PM",
                photoUrl: "assets/tarq.jpg",
                onTap: () {
                  print("Tapped on John");
                },
              ),
              MessageItem(
                name: "Tareq Kh ",
                message: "Hello! How are you doing?",
                time: "2:45 PM",
                photoUrl: "assets/tarq.jpg",
                onTap: () {
                  print("Tapped on John");
                },
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
