import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_chat/features/auth/data/datasources/auth_remote_datasours.dart';
import 'package:safe_chat/features/auth/domain/entitis/user_entit.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;
  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntit> signIn(String email, String password) async {
    final userCredential = await remoteDataSource.signIn(email, password);
    return UserEntit(
        uid: userCredential.user!.uid, email: userCredential.user!.email);
  }

    @override
  Future<UserEntit> signUp(String email, String password) {
   final userCredential = remoteDataSource.signUp(email, password);
    return userCredential.then((credential) => UserEntit(
        uid: credential.user!.uid, email: credential.user!.email));
  }

  @override
  Future<String?> getUserEmail() {
    // TODO: implement getUserEmail
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<UserEntit> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }


}
