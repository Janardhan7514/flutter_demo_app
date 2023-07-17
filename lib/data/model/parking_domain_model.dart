import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:equatable/equatable.dart';

class ParkingDomainModel extends ParkingDomainEntity {
  final String slotType;
  final String slotId;
  final String parkingSpaceId;
  final String floor;

  const ParkingDomainModel({
    required this.slotId,
    required this.parkingSpaceId,
    required this.slotType,
    required this.floor,
  }) : super(slotId: '', parkingSpaceId: '', slotType: '', floor: '');

  @override
  List<Object?> get props => [slotType, slotId, parkingSpaceId, floor];

  factory ParkingDomainModel.fromJson(Map<String, dynamic> json) {
    return ParkingDomainModel(
      slotId: json['slotId'],
      parkingSpaceId: json['parkingSpaceId'],
      slotType: json['slotType'],
      floor: json['floor'],
    );

  }
  Map<String, dynamic> toJson() {
    return {
      'slotId': slotId,
      'parkingSpaceId': parkingSpaceId,
      'slotType': slotType,
      'floor': floor,
    };
  }
}
