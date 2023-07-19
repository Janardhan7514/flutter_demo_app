import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:equatable/equatable.dart';

class TariffDomainModel extends TariffDomainEntity {
  final String tariffID;
  final String cost;
  final String duration;
  final String desc;

  const TariffDomainModel({
    required this.tariffID,
    required this.cost,
    required this.duration,
    required this.desc,
  }) : super(tariffID: '', cost: '', duration: '', desc: '');

  @override
  List<Object?> get props => [tariffID, cost, duration, desc];

  factory TariffDomainModel.fromJson(Map<String, dynamic> json) {
    return TariffDomainModel(
      tariffID: json['slotId'],
      cost: json['parkingSpaceId'],
      duration: json['slotType'],
      desc: json['floor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotId': tariffID,
      'parkingSpaceId': cost,
      'slotType': duration,
      'floor': desc,
    };
  }
}
