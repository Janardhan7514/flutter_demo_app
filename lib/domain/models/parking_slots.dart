import 'ParkingLot.dart';

abstract class ParkingSlot {
  final String slotNumber;
  final bool isAvailable=true;

  ParkingSlot(
    this.slotNumber
  );

  ParkingSlotType getType();
}

class SmallParkingSlot extends ParkingSlot {
  SmallParkingSlot(
    super.slotNumber,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.S;
  }
}

class LargeParkingSlot extends ParkingSlot {
  LargeParkingSlot(
    super.slotNumber,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.L;
  }
}

class MediumParkingSlot extends ParkingSlot {
  MediumParkingSlot(
    super.slotNumber,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.M;
  }
}

class ExtraLargeParkingSlot extends ParkingSlot {
  ExtraLargeParkingSlot(
    super.slotNumber,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.XL;
  }
}

class ExtraExtraLargeParkingSlot extends ParkingSlot {
  ExtraExtraLargeParkingSlot(
    super.slotNumber,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.XXL;
  }
}


