import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_chat/features/profile/domain/repositories/profile_repository.dart';
import 'package:safe_chat/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository})
      : super(const ProfileInitial());

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    try {
      final profile = await profileRepository.getProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> toggleActiveStatus(bool isActive) async {
    try {
      await profileRepository.updateActiveStatus(isActive);
      await loadProfile();
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
