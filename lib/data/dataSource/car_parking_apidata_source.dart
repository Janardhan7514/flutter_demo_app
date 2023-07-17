import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/errors.dart';
import 'package:fpdart/fpdart.dart';

abstract class CarParkingAPIRemoteDataSource {
  Future<ParkingDomainEntity> getSlotForCar(
    String slotType,
    String parkingSpace,
  );

  Future<bool> releaseSlotForCar(
    String slotType,
    String parkingSpace,
  );
}
