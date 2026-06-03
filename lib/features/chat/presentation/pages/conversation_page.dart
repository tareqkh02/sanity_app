import 'package:flutter/material.dart';
import 'package:safe_chat/features/chat/data/datasources/chat_socket_service.dart';
import 'package:safe_chat/features/chat/presentation/widgets/message_input.dart';

class ConversationPage extends StatefulWidget {
  final String chatId;
  final String name;
  final String id;
  final String photoUrl;

  const ConversationPage({
    super.key,
    required this.name,
    required this.id,
    required this.photoUrl,
    required this.chatId,
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  bool _initialized = false;
  final List<Map<String, dynamic>> _messages = [];
  late ChatSocketService socketService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      socketService = ChatSocketService();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    socketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final bool isMe = message['isMe'] as bool? ?? false;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe
                            ? const Color.fromARGB(255, 234, 230, 230)
                            : const Color.fromARGB(255, 255, 250, 250),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['text']?.toString() ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            MessageInput(
              onSendMessage: (messageText) {
                socketService.sendMessage(
                  widget.chatId,
                  messageText,
                  widget.id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
