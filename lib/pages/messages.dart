import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final String name;
  final String? message;
  final String? email;
  final String time;
  final String photoUrl;
  final VoidCallback? onTap;

  const MessageItem({
    Key? key,
    required this.name,
    this.message,
    this.email,
    required this.time,
    required this.photoUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtitle = message ?? email ?? ''; // Pick one

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(photoUrl),
              onBackgroundImageError: (_, __) => const Icon(Icons.error),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              time,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
