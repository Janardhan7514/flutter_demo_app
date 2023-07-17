import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../errors.dart';


abstract class CarParkingRepository {
  Future<Either<Failure, ParkingDomainEntity>> getSlot({
    required String? spaceId,
    required String? slotType,
  });
  Future<Either<Failure, bool>> releaseSlot({String? slotType, String? spaceId});
}
