import 'ParkingLot.dart';

abstract class ParkingSlot {
  final String slotNumber;
  late bool isAvailable;

  ParkingSlot(
    this.slotNumber, this.isAvailable
  );

  bool availability(bool value){
    return isAvailable=value;
  }

  ParkingSlotType getType();

}

class SmallParkingSlot extends ParkingSlot {
  SmallParkingSlot(
    super.slotNumber, super.isAvailable,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.S;
  }
}

class LargeParkingSlot extends ParkingSlot {
  LargeParkingSlot(
    super.slotNumber, super.isAvailable,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.L;
  }
}

class MediumParkingSlot extends ParkingSlot {
  MediumParkingSlot(
    super.slotNumber, super.isAvailable,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.M;
  }
}

class ExtraLargeParkingSlot extends ParkingSlot {
  ExtraLargeParkingSlot(
    super.slotNumber, super.isAvailable,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.XL;
  }
}

class ExtraExtraLargeParkingSlot extends ParkingSlot {
  ExtraExtraLargeParkingSlot(
    super.slotNumber, super.isAvailable,
  );

  @override
  ParkingSlotType getType() {
    return ParkingSlotType.XXL;
  }
}


