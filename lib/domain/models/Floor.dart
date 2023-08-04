import 'package:demo_app/domain/models/bookSlot.dart';
import 'package:demo_app/domain/models/parking_slots.dart';
import 'package:flutter/cupertino.dart';
import 'ParkingLot.dart';

class Floor {
  late String floorId;
  late Map<ParkingSlotType, Map<String, ParkingSlot?>> mallSlots;
  late List<BookSlot> bookSlotList;

  static Floor get instance => _instance;

  static final Floor _instance = Floor._internal();

  Floor._internal() {
    print("ABC calling multiple times");
  }

  factory Floor() {
    return _instance;
  }

  List<BookSlot> getSlotList() {
    return bookSlotList;
  }

  void assignData(String floorId, List<BookSlot> bookSlotList,
      Map<ParkingSlotType, Map<String, ParkingSlot?>> mallSlots) {
    this.mallSlots = mallSlots;
    this.floorId = floorId;
    this.bookSlotList = bookSlotList;
  }

  removeParkingSlot(ParkingSlot slot) {
    mallSlots
        .removeWhere((key, value) => key.name == slot.getType().toString());
  }

  getTotalSLots() {
    return mallSlots.length;
  }

  ParkingSlot? getSlot(Vehicle vehicle, String slotNumber) {
    ParkingSlot? parkingSlot;
    VehicleType vehicleCategory = vehicle.getVehicleType;

    Iterable<MapEntry<ParkingSlotType, Map<String, ParkingSlot?>>> entries =
        mallSlots.entries;
    for (final entry in entries) {
      parkingSlot = entry.value.values.firstWhere(
          (element) =>
              element?.slotNumber == slotNumber && element?.isAvailable == true,
          orElse: () => SmallParkingSlot("NA", false));

      if (parkingSlot != null) {
        if (parkingSlot.slotNumber != "NA") {
          parkingSlot.availability(false);
          print("slot is occupied ${parkingSlot.slotNumber}");
          break;
        }
      }
    }
    return parkingSlot;
  }

  ParkingSlot? releaseSlot(Vehicle vehicle, String slotNumber) {
    ParkingSlot? parkingSlot;
    VehicleType vehicleCategory = vehicle.getVehicleType;

    Iterable<MapEntry<ParkingSlotType, Map<String, ParkingSlot?>>> entries =
        mallSlots.entries;
    for (final entry in entries) {
      parkingSlot = entry.value.values.firstWhere(
          (element) =>
              element?.slotNumber == slotNumber &&
              element?.isAvailable == false,
          orElse: () => SmallParkingSlot("NA", false));

      debugPrint(
          "Random Available Slot is ${parkingSlot?.slotNumber.toString()}");

      if (parkingSlot != null) {
        if (parkingSlot.slotNumber != "NA") {
          parkingSlot.availability(true);
          print("slot is released ${parkingSlot.slotNumber}");
          break;
        }
      }
    }
    return parkingSlot;
  }
}

ParkingSlotType _pickCorrectSlot(VehicleType vehicleType) {
  if (vehicleType.name == VehicleType.bike.name) {
    return ParkingSlotType.S;
  } else if (vehicleType.name == VehicleType.car.name) {
    return ParkingSlotType.M;
  } else if (vehicleType.name == VehicleType.auto.name) {
    return ParkingSlotType.M;
  } else if (vehicleType.name == VehicleType.bus.name) {
    return ParkingSlotType.L;
  } else if (vehicleType.name == VehicleType.truck.name) {
    return ParkingSlotType.XL;
  }

  return ParkingSlotType.S;
}
