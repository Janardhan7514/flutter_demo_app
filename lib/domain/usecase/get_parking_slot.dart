import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/usecase/usecase.dart';
import 'package:demo_app/domain/usecase/usecase_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../errors.dart';
import '../repository/carparking_repository.dart';


class GetParkingSlotUseCase implements UseCase<ParkingDomainEntity, CarParkingUseCaseParams> {
  final CarParkingRepository featuresRepository;
  GetParkingSlotUseCase({required this.featuresRepository});

  @override
  Future<Either<Failure, ParkingDomainEntity>> call(CarParkingUseCaseParams params) async {
    try {
      return await featuresRepository.getSlot(spaceId: params.id, slotType: params.slotType);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class CarParkingUseCaseParams extends BaseParams {
  final String id;
  final String slotType;

  CarParkingUseCaseParams({required this.id, required this.slotType});

  @override
  List<Object?> get props => [id, slotType];
}
