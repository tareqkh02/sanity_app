import 'package:safe_chat/features/chat/domain/entities/message_entity.dart';
import 'package:safe_chat/features/chat/domain/repositories/chat_repository.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Future<List<MessageEntity>> call(String chatId) async {
    return await repository.getMessages(chatId);
  }
}
