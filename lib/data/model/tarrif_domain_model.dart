import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:equatable/equatable.dart';

class TariffDomainModel extends TariffDomainEntity {
  final String slotType;
  final String cost;
  final String duration;
  final String desc;

  const TariffDomainModel({
    required this.slotType,
    required this.cost,
    required this.duration,
    required this.desc,
  }) : super(slotType: '', cost: '', duration: '', desc: '');

  @override
  List<Object?> get props => [slotType, cost, duration, desc];

  factory TariffDomainModel.fromJson(Map<String, dynamic> json) {
    return TariffDomainModel(
      slotType: json['slotType'],
      cost: json['cost'],
      duration: json['duration'],
      desc: json['desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotType': slotType,
      'cost': cost,
      'duration': duration,
      'desc': desc,
    };
  }
}
