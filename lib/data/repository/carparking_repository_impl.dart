import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/errors.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/carparking_repository.dart';
import '../dataSource/car_parking_apidata_source.dart';

@injectable
class CarParkingRepositoryImpl extends CarParkingRepository {
  final CarParkingAPIRemoteDataSource remoteDataSource;

  CarParkingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ParkingDomainEntity>> getSlot(
      {required String? spaceId, required String? slotType}) async {
    try {
      return Right((await remoteDataSource.getSlotForCar(slotType!, spaceId!)));
    } catch (e) {
      return const Left(ServerFailure("Failure"));
    }
  }

  @override
  Future<Either<Failure, bool>> releaseSlot(
      {String? slotType, String? spaceId}) async {
    try {
      return Right((await remoteDataSource.releaseSlotForCar(slotType!, spaceId!)));
    } catch (e) {
      return const Left(ServerFailure("Failure"));
    }
  }
}
