import 'package:equatable/equatable.dart';

import 'actions.dart';

class Actionmodel extends Equatable {
	final bool? status;
	final Actions? actions;
	final int? totalMaintenance;
	final int? totalPayment;
	final int? totalDue;

	const Actionmodel({
		this.status, 
		this.actions, 
		this.totalMaintenance, 
		this.totalPayment, 
		this.totalDue, 
	});

	factory Actionmodel.fromJson(Map<String, dynamic> json) => Actionmodel(
				status: json['status'] as bool?,
				actions: json['actions'] == null
						? null
						: Actions.fromJson(json['actions'] as Map<String, dynamic>),
				totalMaintenance: json['total_maintenance'] as int?,
				totalPayment: json['total_payment'] as int?,
				totalDue: json['total_due'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'actions': actions?.toJson(),
				'total_maintenance': totalMaintenance,
				'total_payment': totalPayment,
				'total_due': totalDue,
			};

	@override
	List<Object?> get props {
		return [
				status,
				actions,
				totalMaintenance,
				totalPayment,
				totalDue,
		];
	}
}
