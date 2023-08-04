import 'ParkingLot.dart';

class BookSlot{
  final String slotNumber;
  final Vehicle vehicle;
  final bool occupied;
  final ParkingSlotType parkingSlotType;

  BookSlot(this.slotNumber, this.vehicle, this.occupied, this.parkingSlotType);
}