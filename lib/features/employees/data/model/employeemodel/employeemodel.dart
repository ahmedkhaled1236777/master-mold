import 'package:equatable/equatable.dart';

import 'employer.dart';

class Employeemodel extends Equatable {
  final bool? status;
  final List<Employer>? employers;

  const Employeemodel({this.status, this.employers});

  factory Employeemodel.fromJson(Map<String, dynamic> json) => Employeemodel(
        status: json['status'] as bool?,
        employers: (json['employers'] as List<dynamic>?)
            ?.map((e) => Employer.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'employers': employers?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [status, employers];
}
