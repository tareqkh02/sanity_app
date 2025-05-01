import 'package:flutter/material.dart';
import 'package:safe_chat/pages/widget/input_message.dart';

class ConversationPage extends StatefulWidget {
  final String name;
  final String photoUrl;

  const ConversationPage({
    super.key,
    required this.name,
    required this.photoUrl,
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final List<Map<String, dynamic>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            CircleAvatar(
              backgroundImage: AssetImage(widget.photoUrl),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "Active now",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final bool isMe = message['isMe'];
                    final bool isEncrypted = message['isEncrypted'] ?? false;

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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                message['text'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!isMe) ...[
                              IconButton(
                                icon: Icon(
                                  isEncrypted ? Icons.lock : Icons.lock_open,
                                  size: 16,
                                  color:
                                      isEncrypted ? Colors.green : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _messages[index]['isEncrypted'] =
                                        !isEncrypted;
                                  });
                                },
                              ),
                            ]
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            BuildMessageInput(
              onSendMessage: (messageText) {
                setState(() {
                  _messages.insert(0, {
                    "text": messageText,
                    "isMe": messageText != "This is a bot reply.",
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
