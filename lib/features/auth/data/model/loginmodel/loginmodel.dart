import 'package:equatable/equatable.dart';

import 'user.dart';

class Loginmodel extends Equatable {
  final bool? status;
  final User? user;

  const Loginmodel({this.status, this.user});

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        status: json['status'] as bool?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'user': user?.toJson(),
      };

  @override
  List<Object?> get props => [status, user];
}
