import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? type;
  final int? clientId;
  final String? date;
  final String? description;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Datum({
    this.id,
    this.type,
    this.clientId,
    this.date,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        type: json['type'] as String?,
        clientId: json['client_id'] as int?,
        date: json['date'] as String?,
        description: json['description'] as String?,
        price: json['price'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'client_id': clientId,
        'date': date,
        'description': description,
        'price': price,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      type,
      clientId,
      date,
      description,
      price,
      createdAt,
      updatedAt,
    ];
  }
}
