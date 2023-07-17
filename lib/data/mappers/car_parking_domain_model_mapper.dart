import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/functions.dart';

import '../model/parking_domain_model.dart';

class CarParkingDomainModelMapper
    implements Function1<ParkingDomainModel, ParkingDomainEntity> {
  @override
  ParkingDomainEntity call(ParkingDomainModel assignedSlot) {
    return ParkingDomainModel(
      slotId: assignedSlot.slotId ?? " ",
      parkingSpaceId: assignedSlot.parkingSpaceId ?? " ",
      slotType: assignedSlot.slotType ?? " ",
      floor: assignedSlot.floor ?? "",
    );
  }
}
