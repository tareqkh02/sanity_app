part of 'user_auth_cubit.dart';

sealed class UserAuthState extends Equatable {
  const UserAuthState();

  @override
  List<Object> get props => [];
}

final class UserAuthInitial extends UserAuthState {}
final class UserAuthLoading extends UserAuthState {}
final class UserAuthSuccess extends UserAuthState {
  final String uid; 
  const UserAuthSuccess({required this.uid});
  @override
  List<Object> get props => [uid];
}
final class UserAuthFailure extends UserAuthState {
  final String errorMessage;
  const UserAuthFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}