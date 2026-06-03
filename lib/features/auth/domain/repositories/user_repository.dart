import 'package:safe_chat/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> signIn(String email, String password);

  Future<UserEntity> signUp(String email, String password);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String?> getUserEmail();
}
