import 'package:flutter/material.dart';
import 'package:safe_chat/pages/ConversationPage.dart';

void handleMessageTap(BuildContext context, Map<String, String> msg ) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConversationPage(
        name: msg['name']!,
        photoUrl: msg['photoUrl']!,
      ),
    ),
  );
}