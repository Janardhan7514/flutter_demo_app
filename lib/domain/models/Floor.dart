import 'dart:collection';
import 'package:demo_app/domain/models/parking_slots.dart';
import 'package:flutter/cupertino.dart';
import 'ParkingLot.dart';

class Floor {
  final String floorId;
  final Map<ParkingSlotType, Map<String, ParkingSlot?>> mallSlots;

  Floor(this.floorId, this.mallSlots);

  removeParkingSlot(ParkingSlot slot) {
    mallSlots
        .removeWhere((key, value) => key.name == slot.getType().toString());
  }

  getTotalSLots() {
    return mallSlots.length;
  }

  ParkingSlot? getSlot(Vehicle vehicle) {
    ParkingSlot? parkingSlot;
    VehicleType vehicleCategory = vehicle.getVehicleType;
    ParkingSlotType parkingSlotType = _pickCorrectSlot(vehicleCategory);
    Iterable<MapEntry<ParkingSlotType, Map<String, ParkingSlot?>>> entries =
        mallSlots.entries;
    for (final entry in entries) {
      parkingSlot = entry.value.values.firstWhere(
          (element) =>
              element?.isAvailable == true &&
              element?.getType().name.toString() ==
                  parkingSlotType.name.toString(),
          orElse: () => SmallParkingSlot("NA"));

      debugPrint("Random Available Slot is ${parkingSlot?.slotNumber.toString()}");

      if (parkingSlot != null) {
        if (parkingSlot.slotNumber != "NA") {
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
