import 'package:demo_app/domain/models/parking_slots.dart';

import 'ParkingLot.dart';

class SlotFactory {
  ParkingSlot? getParkingSlot(ParkingSlotType planType, String slotNumber) {
    if (planType.name == "S") {
      return SmallParkingSlot(slotNumber);
    } else if (planType.name == "M") {
      return MediumParkingSlot(slotNumber);
    } else if (planType.name == "L") {
      return LargeParkingSlot(slotNumber);
    } else if (planType.name == "XL") {
      return ExtraLargeParkingSlot(slotNumber);
    }else if (planType.name == "XXL") {
      return ExtraExtraLargeParkingSlot(slotNumber);
    }
    return null;
  }
}
