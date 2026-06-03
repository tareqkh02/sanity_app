class ChatEntity {
  final String id;
  final String name;
  final String? image;
  final bool isGroup;
  final String? adminId;
  final List<String> members;
  final String? lastMessage;
  final String? lastMessageTime;

  const ChatEntity({
    required this.id,
    this.name = '',
    this.image,
    this.isGroup = false,
    this.adminId,
    this.members = const [],
    this.lastMessage,
    this.lastMessageTime,
  });
}
