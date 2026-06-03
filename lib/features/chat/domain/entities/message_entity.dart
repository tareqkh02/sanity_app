class MessageEntity {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime? createdAt;
  final bool isEncrypted;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    this.createdAt,
    this.isEncrypted = false,
  });
}
