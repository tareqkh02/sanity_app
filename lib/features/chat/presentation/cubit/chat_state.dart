import 'package:equatable/equatable.dart';
import 'package:safe_chat/features/chat/domain/entities/chat_entity.dart';
import 'package:safe_chat/features/chat/domain/entities/message_entity.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

final class ChatInitial extends ChatState {
  const ChatInitial();
}

final class ChatLoading extends ChatState {
  const ChatLoading();
}

final class ChatsLoaded extends ChatState {
  final List<ChatEntity> chats;

  const ChatsLoaded({required this.chats});

  @override
  List<Object?> get props => [chats];
}

final class MessagesLoaded extends ChatState {
  final List<MessageEntity> messages;

  const MessagesLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];
}

final class ChatError extends ChatState {
  final String message;

  const ChatError({required this.message});

  @override
  List<Object?> get props => [message];
}
