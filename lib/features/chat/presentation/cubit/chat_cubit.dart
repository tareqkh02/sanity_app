import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:safe_chat/features/chat/presentation/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;

  ChatCubit({required this.chatRepository}) : super(const ChatInitial());

  Future<void> loadChats() async {
    emit(const ChatLoading());
    try {
      final chats = await chatRepository.getChats();
      emit(ChatsLoaded(chats: chats));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> loadMessages(String chatId) async {
    emit(const ChatLoading());
    try {
      final messages = await chatRepository.getMessages(chatId);
      emit(MessagesLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> createChat({
    String? name,
    String? image,
    bool isGroup = false,
    String? adminId,
    required List<String> members,
  }) async {
    emit(const ChatLoading());
    try {
      await chatRepository.createChat(
        name: name,
        image: image,
        isGroup: isGroup,
        adminId: adminId,
        members: members,
      );
      await loadChats();
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> sendMessage({
    required String chatId,
    required String content,
    required String receiverId,
  }) async {
    try {
      await chatRepository.sendMessage(
        chatId: chatId,
        content: content,
        receiverId: receiverId,
      );
      await loadMessages(chatId);
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }
}
