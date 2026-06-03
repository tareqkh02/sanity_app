import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final String id;
  final String? name;
  final String? image;
  @JsonKey(name: 'isGroup')
  final bool isGroup;
  final String? adminId;
  final List<String> members;
  final String? lastMessage;
  final String? lastMessageTime;

  const ChatModel({
    required this.id,
    this.name,
    this.image,
    this.isGroup = false,
    this.adminId,
    this.members = const [],
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
