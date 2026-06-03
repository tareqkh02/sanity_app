import 'package:safe_chat/core/constants/api_constants.dart';
import 'package:safe_chat/core/network/api_client.dart';

abstract class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();

  Future<void> updateActiveStatus(bool isActive);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final response = await apiClient.get(ApiConstants.user);
    final data = response.data as Map<String, dynamic>;
    return data['data'] as Map<String, dynamic>;
  }

  @override
  Future<void> updateActiveStatus(bool isActive) async {
    // TODO: implement if API supports it
    await Future.delayed(Duration.zero);
  }
}
