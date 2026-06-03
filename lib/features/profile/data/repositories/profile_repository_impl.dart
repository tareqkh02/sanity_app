import 'package:safe_chat/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:safe_chat/features/profile/domain/entities/profile_entity.dart';
import 'package:safe_chat/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProfileEntity> getProfile() async {
    final profile = await remoteDataSource.getProfile();
    return ProfileEntity(
      name: profile['name']?.toString() ?? '',
      email: profile['email']?.toString() ?? '',
      photoUrl: profile['photoUrl']?.toString(),
    );
  }

  @override
  Future<void> updateActiveStatus(bool isActive) async {
    await remoteDataSource.updateActiveStatus(isActive);
  }
}
