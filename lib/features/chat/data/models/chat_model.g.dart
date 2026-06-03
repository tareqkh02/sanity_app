// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      image: json['image'] as String?,
      isGroup: json['isGroup'] as bool? ?? false,
      adminId: json['adminId'] as String?,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastMessage: json['lastMessage'] as String?,
      lastMessageTime: json['lastMessageTime'] as String?,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'isGroup': instance.isGroup,
      'adminId': instance.adminId,
      'members': instance.members,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
    };
