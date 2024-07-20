import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePhotoPath;

  const Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhotoPath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        profilePhotoPath: json['profile_photo_path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profile_photo_path': profilePhotoPath,
      };

  @override
  List<Object?> get props => [id, name, email, phone, profilePhotoPath];
}
