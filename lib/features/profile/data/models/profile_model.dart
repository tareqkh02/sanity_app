import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String name;
  final String email;
  final String? photoUrl;
  final bool isActive;

  const ProfileModel({
    required this.name,
    required this.email,
    this.photoUrl,
    this.isActive = true,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
