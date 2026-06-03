import 'package:flutter/material.dart';
import 'package:safe_chat/features/chat/presentation/widgets/message_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _messages = [];

  @override
  Widget build(BuildContext context) {
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
