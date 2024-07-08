import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final dynamic type;
  final String? name;
  final String? email;
  final String? phone;
  final String? isActive;
  final String? isManager;
  final int? role;
  final String? fcmToken;
  final String? profilePhotoPath;
  final dynamic industry;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;

  const User({
    this.id,
    this.type,
    this.name,
    this.email,
    this.phone,
    this.isActive,
    this.isManager,
    this.role,
    this.fcmToken,
    this.profilePhotoPath,
    this.industry,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        type: json['type'] as dynamic,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        isActive: json['is_active'] as String?,
        isManager: json['is_manager'] as String?,
        role: json['role'] as int?,
        fcmToken: json['fcm_token'] as String?,
        profilePhotoPath: json['profile_photo_path'] as String?,
        industry: json['industry'] as dynamic,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'email': email,
        'phone': phone,
        'is_active': isActive,
        'is_manager': isManager,
        'role': role,
        'fcm_token': fcmToken,
        'profile_photo_path': profilePhotoPath,
        'industry': industry,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'token': token,
      };

  @override
  List<Object?> get props {
    return [
      id,
      type,
      name,
      email,
      phone,
      isActive,
      isManager,
      role,
      fcmToken,
      profilePhotoPath,
      industry,
      emailVerifiedAt,
      createdAt,
      updatedAt,
      token,
    ];
  }
}
