import 'package:safe_chat/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:safe_chat/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:safe_chat/features/chat/domain/entities/chat_entity.dart';
import 'package:safe_chat/features/chat/domain/entities/message_entity.dart';
import 'package:safe_chat/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatLocalDataSource localDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<ChatEntity>> getChats() async {
    final chats = await remoteDataSource.getChats();
    return chats.map((chat) {
      final map = chat as Map<String, dynamic>;
      return ChatEntity(
        id: map['id']?.toString() ?? '',
        name: map['name']?.toString() ?? 'Unknown',
        image: map['image']?.toString(),
        isGroup: map['isGroup'] ?? false,
        adminId: map['adminId']?.toString(),
        lastMessage: map['lastMessage']?.toString(),
        lastMessageTime: map['lastMessageTime']?.toString(),
      );
    }).toList();
  }

  @override
  Future<ChatEntity> getChatById(String chatId) async {
    final chat = await remoteDataSource.getChatById(chatId);
    return ChatEntity(
      id: chat['id']?.toString() ?? '',
      name: chat['name']?.toString() ?? 'Unknown',
      image: chat['image']?.toString(),
      isGroup: chat['isGroup'] ?? false,
      adminId: chat['adminId']?.toString(),
    );
  }

  @override
  Future<ChatEntity> createChat({
    String? name,
    String? image,
    bool isGroup = false,
    String? adminId,
    required List<String> members,
  }) async {
    final chat = await remoteDataSource.createChat(
      name: name,
      image: image,
      isGroup: isGroup,
      adminId: adminId,
      members: members,
    );
    return ChatEntity(
      id: chat['id']?.toString() ?? '',
      name: chat['name']?.toString() ?? '',
      image: chat['image']?.toString(),
      isGroup: chat['isGroup'] ?? false,
      members: List<String>.from(chat['members'] ?? []),
    );
  }

  @override
  Future<List<MessageEntity>> getMessages(String chatId) async {
    final chat = await remoteDataSource.getChatById(chatId);
    final messages = chat['messages'] as List<dynamic>? ?? [];
    return messages.map((msg) {
      final map = msg as Map<String, dynamic>;
      return MessageEntity(
        id: map['id']?.toString() ?? '',
        chatId: chatId,
        senderId: map['senderId']?.toString() ?? '',
        content: map['content']?.toString() ?? '',
        createdAt: map['createdAt'] != null
            ? DateTime.tryParse(map['createdAt'].toString())
            : null,
      );
    }).toList();
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required String content,
    required String receiverId,
  }) async {
    await remoteDataSource.createChat(
      isGroup: false,
      members: [receiverId],
    );
  }

  @override
  Future<String?> decryptText(String encryptedText) async {
    return remoteDataSource.decryptText(encryptedText);
  }

  @override
  Future<String?> getUserId() async {
    final cached = await localDataSource.getCachedUserId();
    if (cached != null) return cached;

    final userId = await remoteDataSource.getUserId();
    if (userId != null) {
      await localDataSource.cacheUserId(userId);
    }
    return userId;
  }
}
