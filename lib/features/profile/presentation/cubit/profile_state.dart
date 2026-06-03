import 'package:equatable/equatable.dart';
import 'package:safe_chat/features/profile/domain/entities/profile_entity.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
