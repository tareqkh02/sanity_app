class UserEntity {
  final String uid;
  final String? name;
  final String? email;

  const UserEntity({
    required this.uid,
    this.name,
    this.email,
  });
}
