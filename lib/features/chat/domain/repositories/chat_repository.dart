import 'package:safe_chat/features/chat/domain/entities/chat_entity.dart';
import 'package:safe_chat/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<List<ChatEntity>> getChats();

  Future<ChatEntity> getChatById(String chatId);

  Future<ChatEntity> createChat({
    String? name,
    String? image,
    bool isGroup = false,
    String? adminId,
    required List<String> members,
  });

  Future<List<MessageEntity>> getMessages(String chatId);

  Future<void> sendMessage({
    required String chatId,
    required String content,
    required String receiverId,
  });

  Future<String?> decryptText(String encryptedText);

  Future<String?> getUserId();
}
