import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatLocalDataSource {
  Future<void> cacheUserId(String userId);

  Future<String?> getCachedUserId();

  Future<void> clearCache();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final SharedPreferences sharedPreferences;

  ChatLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserId(String userId) async {
    await sharedPreferences.setString('cached_user_id', userId);
  }

  @override
  Future<String?> getCachedUserId() async {
    return sharedPreferences.getString('cached_user_id');
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove('cached_user_id');
  }
}
