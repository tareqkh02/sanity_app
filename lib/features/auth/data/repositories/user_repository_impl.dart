import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_chat/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:safe_chat/features/auth/domain/entities/user_entity.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final credential = await remoteDataSource.signIn(email, password);
    final user = credential.user;
    return UserEntity(
      uid: user!.uid,
      email: user.email,
    );
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    final credential = await remoteDataSource.signUp(email, password);
    final user = credential.user;
    return UserEntity(
      uid: user!.uid,
      email: user.email,
    );
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<bool> isSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<String?> getUserEmail() async {
    return FirebaseAuth.instance.currentUser?.email;
  }
}
