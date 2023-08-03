import 'dart:ffi';

import 'package:demo_app/domain/models/ParkingLot.dart';
import 'package:demo_app/domain/models/parking_slots.dart';

class Ticket {
  final String ticketNumber;
  final Long startTime;
  final Long endTime;
  final Vehicle vehicle;
  final ParkingSlot parkingSlot;

  Ticket(this.ticketNumber, this.startTime, this.endTime, this.vehicle, this.parkingSlot);
}
