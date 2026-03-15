import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safe_chat/features/auth/domain/entitis/user_entit.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository.dart';
import 'package:safe_chat/features/auth/domain/repositories/user_repository_impl.dart';

part 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  final UserRepository? userRepository;
  UserAuthCubit({this.userRepository}) : super(UserAuthInitial());

  Future<void> singin(String email, String password) async {
    emit(UserAuthLoading());
    try {
      final user = await userRepository?.signIn(email, password);
      emit(UserAuthSuccess(uid: user?.uid));
    } catch (e) {
      emit(UserAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(UserAuthLoading());
    try {
      final user = await userRepository?.signUp(email, password);
      emit(UserAuthSuccess(uid: user?.uid));
    } catch (e) {
      emit(UserAuthFailure(errorMessage: e.toString()));
    }
  }
}
