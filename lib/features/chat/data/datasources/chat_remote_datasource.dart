import 'package:safe_chat/core/constants/api_constants.dart';
import 'package:safe_chat/core/network/api_client.dart';

abstract class ChatRemoteDataSource {
  Future<List<dynamic>> getChats();

  Future<Map<String, dynamic>> getChatById(String chatId);

  Future<Map<String, dynamic>> createChat({
    String? name,
    String? image,
    bool isGroup = false,
    String? adminId,
    required List<String> members,
  });

  Future<List<dynamic>> searchUsers(String query);

  Future<String?> decryptText(String encryptedText);

  Future<String?> getUserId();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiClient apiClient;

  ChatRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<dynamic>> getChats() async {
    final response = await apiClient.get(ApiConstants.chats);
    final data = response.data as Map<String, dynamic>;
    return data['data'] as List<dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getChatById(String chatId) async {
    final response = await apiClient.get(ApiConstants.chatById(chatId));
    final data = response.data as Map<String, dynamic>;
    return data['data'] as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> createChat({
    String? name,
    String? image,
    bool isGroup = false,
    String? adminId,
    required List<String> members,
  }) async {
    final response = await apiClient.post(
      ApiConstants.chats,
      data: {
        'name': name,
        'image': image,
        'isGroup': isGroup,
        'adminId': adminId,
        'members': members,
      },
    );
    final data = response.data as Map<String, dynamic>;
    return data['data'] as Map<String, dynamic>;
  }

  @override
  Future<List<dynamic>> searchUsers(String query) async {
    final response = await apiClient.get(
      ApiConstants.searchUser,
      queryParameters: {'search': query},
    );
    final data = response.data as Map<String, dynamic>;
    return data['data'] as List<dynamic>;
  }

  @override
  Future<String?> decryptText(String encryptedText) async {
    try {
      final response = await apiClient.post(
        ApiConstants.decrypt,
        data: {'encryptedText': encryptedText},
      );
      final data = response.data as Map<String, dynamic>;
      return data['data'] as String?;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getUserId() async {
    try {
      final response = await apiClient.get(ApiConstants.user);
      final data = response.data as Map<String, dynamic>;
      return data['data']['id'].toString();
    } catch (e) {
      return null;
    }
  }
}
