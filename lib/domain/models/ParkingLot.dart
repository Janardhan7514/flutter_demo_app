import 'package:demo_app/domain/models/parking_slots.dart';

import 'Floor.dart';

class ParkingLot {
  late String name;
  late List<Floor> floors;
  late String parkingLotId;

  static ParkingLot get instance => _instance;

  static final ParkingLot _instance = ParkingLot._internal();

  factory ParkingLot() {
    return _instance;
  }

  ParkingLot._internal();


  void assignData(String sName, List<Floor> sFloors, String sParkingLotId) {
    name = sName;
    floors = sFloors;
    parkingLotId = sParkingLotId;
  }

  addFloors(String floorId,
      Map<ParkingSlotType, Map<String, ParkingSlot>> parkSlots) {
    Floor parkingFloor = Floor(floorId, parkSlots);
    floors.add(parkingFloor);
  }

  removeFloor(Floor floorId) {
    floors.remove(floorId);
  }

  ParkingSlot? getParkingSlotForVehicle(Vehicle vehicle) {
    return floors.elementAt(0).getSlot(vehicle);
  }
}

class Vehicle {
  String vehicleNumber;
  VehicleType vehicleType;

  Vehicle(this.vehicleNumber, this.vehicleType);

  String get getVehicleNumber {
    return vehicleNumber;
  }

  VehicleType get getVehicleType {
    return vehicleType;
  }

  void setVehicleCategory(VehicleType vehiclesType) {
    vehicleType = vehiclesType;
  }

  void setVehicleNumber(String number) {
    vehicleNumber = number;
  }
}

enum VehicleType { bike, auto, car, bus, truck }

enum ParkingSlotType { S, M, L, XL, XXL }
