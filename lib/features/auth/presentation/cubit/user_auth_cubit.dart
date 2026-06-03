import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository.dart';
import 'package:safe_chat/features/auth/presentation/cubit/user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  final UserRepository userRepository;

  UserAuthCubit({required this.userRepository})
      : super(const UserAuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(const UserAuthLoading());
    try {
      final user = await userRepository.signIn(email, password);
      emit(UserAuthSuccess(uid: user.uid));
    } catch (e) {
      emit(UserAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(const UserAuthLoading());
    try {
      final user = await userRepository.signUp(email, password);
      emit(UserAuthSuccess(uid: user.uid));
    } catch (e) {
      emit(UserAuthFailure(errorMessage: e.toString()));
    }
  }
}
