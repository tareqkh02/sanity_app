import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageInput extends StatefulWidget {
  final Function(String message) onSendMessage;

  const MessageInput({super.key, required this.onSendMessage});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 156, 156, 160),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _messageController,
          onSubmitted: (_) => _sendMessage(),
          decoration: InputDecoration(
            hintText: "Type a message...",
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            suffixIcon: GestureDetector(
              onTap: _sendMessage,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    'assets/send1.svg',
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
