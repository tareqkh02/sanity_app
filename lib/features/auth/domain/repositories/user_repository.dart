

import 'package:safe_chat/features/auth/domain/entitis/user_entit.dart';

abstract class UserRepository {
  Future<UserEntit> signIn(String email, String password);
  Future<UserEntit> signUp(String email, String password);
  Future<UserEntit> signOut();
  Future<bool> isSignedIn();
  Future<String?> getUserEmail();
}