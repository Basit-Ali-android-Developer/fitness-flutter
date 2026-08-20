class UserModel {
  final int id;
  final String name;
  final String email;
  final String userType;
  final double? height;
  final double? weight;
  final int? age;
  final String? gender;
  final bool isProfileComplete;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    this.height,
    this.weight,
    this.age,
    this.gender,
    required this.isProfileComplete,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      userType: json['usertype'] as String? ?? '',
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      isProfileComplete: json['is_profile_complete'] == 1,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}