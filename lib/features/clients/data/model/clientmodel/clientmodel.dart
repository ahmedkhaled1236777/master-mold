import 'package:equatable/equatable.dart';

import 'clients.dart';

class Clientmodel extends Equatable {
  final bool? status;
  final Clients? clients;

  const Clientmodel({this.status, this.clients});

  factory Clientmodel.fromJson(Map<String, dynamic> json) => Clientmodel(
        status: json['status'] as bool?,
        clients: json['clients'] == null
            ? null
            : Clients.fromJson(json['clients'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'clients': clients?.toJson(),
      };

  @override
  List<Object?> get props => [status, clients];
}
