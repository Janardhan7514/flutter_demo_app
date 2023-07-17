import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/repository/carparking_repository.dart';
import 'package:demo_app/domain/usecase/usecase.dart';
import 'package:demo_app/domain/usecase/usecase_params.dart';
import 'package:demo_app/errors.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

class ReleaseParkingSlotUseCase
    implements UseCase<bool, CarParkingUseCaseParams> {
  final CarParkingRepository _featuresRepository;

  ReleaseParkingSlotUseCase({
    required CarParkingRepository featuresRepository,
  }) : _featuresRepository = featuresRepository;

  @override
  Future<Either<Failure, bool>> call(CarParkingUseCaseParams params) async {
    try {
      return await _featuresRepository.releaseSlot(slotType: params.slotType, spaceId: params.parkingSpaceID);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class CarParkingUseCaseParams extends BaseParams {
  final String id;
  final String slotType;
  final String parkingSpaceID;

  CarParkingUseCaseParams(
      {required this.id, required this.slotType, required this.parkingSpaceID});

  @override
  List<Object?> get props => [id, slotType, parkingSpaceID];
}
