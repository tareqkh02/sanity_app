import 'package:equatable/equatable.dart';

sealed class UserAuthState extends Equatable {
  const UserAuthState();

  @override
  List<Object?> get props => [];
}

final class UserAuthInitial extends UserAuthState {
  const UserAuthInitial();
}

final class UserAuthLoading extends UserAuthState {
  const UserAuthLoading();
}

final class UserAuthSuccess extends UserAuthState {
  final String? uid;

  const UserAuthSuccess({required this.uid});

  @override
  List<Object?> get props => [uid];
}

final class UserAuthFailure extends UserAuthState {
  final String errorMessage;

  const UserAuthFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
