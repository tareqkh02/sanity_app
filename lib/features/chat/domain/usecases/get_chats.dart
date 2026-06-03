import 'package:safe_chat/features/chat/domain/entities/chat_entity.dart';
import 'package:safe_chat/features/chat/domain/repositories/chat_repository.dart';

class GetChats {
  final ChatRepository repository;

  GetChats(this.repository);

  Future<List<ChatEntity>> call() async {
    return await repository.getChats();
  }
}
