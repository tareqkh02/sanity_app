import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_chat/Apis/Apis.dart';
import 'package:safe_chat/class/AuthProvider.dart';
import 'package:safe_chat/pages/widget/input_message.dart';
import 'package:safe_chat/services/socket_service.dart';

class ConversationPage extends StatefulWidget {
  final String chatId;
  final String name;
  final String id;
  final String photoUrl;

  const ConversationPage(
      {super.key,
      required this.name,
      required this.id,
      required this.photoUrl,
      required this.chatId});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  bool _initialized = false;
  String? _chatId;
  String? _lastSentMessage;

  late SocketService socketService;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final token = Provider.of<AuthProvider>(context, listen: false).authToken;

      if (token != null) {
        socketService = SocketService();
        socketService.init(token);

        socketService.socket.on('connect', (_) {
          print('Socket connected');
        });

        socketService.socket.on('disconnect', (_) {
          print('Socket disconnected');
        });

        socketService.socket.on('connect_error', (error) {
          print('Connection error: $error');
        });

        socketService.socket.on('new-message', (data) async {
          final String message = data['senderId'];
          print('sender$message');
          print('id ${widget.id}');
          final myId = await getUserId(context);
          print('id ${myId}');
          if (data['content'] != null) {
            setState(() {
              _messages.insert(0, {
                'text': data['content'],
                'isMe': data['senderId'] == myId,
                'isEncrypted': true,
              });
            });
          }
        });

        _initialized = true;
      } else {
        print("Token is null, socket not initialized.");
      }
    }
  }

  final List<Map<String, dynamic>> _messages = [];

  Future<void> _decryptAllMessages(String pin) async {
    if (pin != "1234") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN cod not True ')),
      );
      return;
    }

    bool success = true;

    for (int i = 0; i < _messages.length; i++) {
      if (_messages[i]['isEncrypted'] == true) {
        final decrypted = await decryptText(context, _messages[i]['text']);
        if (decrypted != null) {
          _messages[i] = {
            'text': decrypted,
            'isMe': _messages[i]['isMe'],
            'isEncrypted': false,
          };
        } else {
          success = false;
          break;
        }
      }
    }

    if (success) {
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('errour of decrypting')),
      );
    }
  }

  Future<void> _showPinDialog() async {
    final TextEditingController pinController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('please add the PIN code'),
        content: TextField(
          controller: pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'PIN CODE'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('cancel'),
          ),
          TextButton(
            onPressed: () {
              if (pinController.text.isNotEmpty) {
                Navigator.of(context).pop(true);
              }
            },
            child: const Text('deacrypt'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _decryptAllMessages(pinController.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_open, color: Colors.black),
            tooltip: 'Unlock',
            onPressed: _showPinDialog,
          ),
        ],
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            BuildMessageInput(
              onSendMessage: (messageText) async {
                if (_initialized) {
                  _lastSentMessage = messageText;
                  socketService.sendMessage(
                      widget.chatId, messageText, widget.id);
                } else {
                  print("Socket not initialized.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
