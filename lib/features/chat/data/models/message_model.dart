import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime? createdAt;
  final bool isEncrypted;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    this.createdAt,
    this.isEncrypted = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
