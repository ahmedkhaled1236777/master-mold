import 'package:equatable/equatable.dart';

class Employer extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? isActive;

  const Employer({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.isActive,
  });

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json['id'] as int?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        isActive: json['is_active'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'is_active': isActive,
      };

  @override
  List<Object?> get props => [id, name, phone, email, isActive];
}
