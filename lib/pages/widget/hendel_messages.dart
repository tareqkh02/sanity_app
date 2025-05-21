import 'package:flutter/material.dart';
import 'package:safe_chat/Apis/Apis.dart';
import 'package:safe_chat/pages/ConversationPage.dart';

void handleMessageTap(BuildContext context, Map<String, String> msg) async {
  String? chatId = msg['chatId']; // استخدم chatId الموجود إذا موجود

  if (chatId == null && msg['id'] != null) {
    // لازم تنشئ محادثة جديدة فقط لو chatId غير موجود
    final adminId = await getUserId(context);
    if (adminId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get admin ID')),
      );
      return;
    }

    final chatData = await createNewChat(
      isGroup: false,
      members: [msg['id']!],
      context: context,
    );

    chatId = chatData?['id'];
    if (chatId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating chat')),
      );
      return;
    }
    print('Created chat ID: $chatId');
  }

  if (chatId != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationPage(
          chatId: chatId!,
          id: msg['id'] ?? 'Unknown',
          name: msg['name'] ?? 'Unknown',
          photoUrl: msg['photoUrl'] ?? '',
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid chat ID')),
    );
  }
}
