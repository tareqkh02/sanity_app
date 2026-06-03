class ProfileEntity {
  final String name;
  final String email;
  final String? photoUrl;
  final bool isActive;

  const ProfileEntity({
    required this.name,
    required this.email,
    this.photoUrl,
    this.isActive = true,
  });
}
