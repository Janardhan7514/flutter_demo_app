import 'package:equatable/equatable.dart';

class ParkingDomainEntity extends Equatable {
  final String slotType;
  final String slotId;
  final String parkingSpaceId;
  final String floor;

  const ParkingDomainEntity({
    required this.slotId,
    required this.parkingSpaceId,
    required this.slotType,
    required this.floor,
  });

  @override
  List<Object?> get props => [slotType, slotId, floor, parkingSpaceId];
}
