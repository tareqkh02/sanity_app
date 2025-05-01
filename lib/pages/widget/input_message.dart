import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildMessageInput extends StatefulWidget {
  final Function(String message) onSendMessage;
  const BuildMessageInput({super.key, required this.onSendMessage});

  @override
  State<BuildMessageInput> createState() => _BuildMessageInputState();
}

class _BuildMessageInputState extends State<BuildMessageInput> {
  bool _isTyping = true;
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _messageController.clear();
      setState(() {
        _isTyping = false;
      });

      await Future.delayed(const Duration(milliseconds: 500));
      widget.onSendMessage("This is a bot reply.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        height: 50,
        child: TextField(
          controller: _messageController,
          onSubmitted: (value) {
            _sendMessage();
          },
          onChanged: (text) {
            setState(() {
              _isTyping = text.isNotEmpty;
            });
          },
          decoration: InputDecoration(
              hintText: "Type a message...",
              fillColor: Colors.transparent,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 156, 156, 160), width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 156, 156, 160), width: 1.0),
              ),
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  _sendMessage();
                },
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
              )),
        ),
      ),
    );
  }
}
