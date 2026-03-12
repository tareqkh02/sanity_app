import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn(String email, String password);
  Future<UserCredential> signUp(String email, String password);
}

class AuthRemoteDatasoursImp implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDatasoursImp({required this.firebaseAuth});
  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
    return  await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      return  await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
