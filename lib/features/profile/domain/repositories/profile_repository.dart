import 'package:safe_chat/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();

  Future<void> updateActiveStatus(bool isActive);
}
