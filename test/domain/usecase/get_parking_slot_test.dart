import 'package:demo_app/data/repository/carparking_repository_impl.dart';
import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/repository/carparking_repository.dart';
import 'package:demo_app/domain/usecase/get_parking_slot.dart';
import 'package:demo_app/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_parking_slot_test.mocks.dart';

@GenerateMocks([CarParkingRepository])
void main() {
  late GetParkingSlotUseCase useCase;
  late CarParkingRepository mockCarRepository;

  const spaceId = "1";
  const tParkingDomainEntity = ParkingDomainEntity(slotType: 'S', floor: 'first', slotId: 'S-100', parkingSpaceId: '1');
  final tCarParkingParams = CarParkingUseCaseParams(slotType: 'S', id: '1');

  setUp(() {
    mockCarRepository = MockCarParkingRepository();
    useCase = GetParkingSlotUseCase(featuresRepository: mockCarRepository);
  });

  test(
    'should get slot for car from the repository',
    () async {
      when(mockCarRepository.getSlot(spaceId: '1', slotType: 'S')).thenAnswer((_) async => const Right(tParkingDomainEntity));
      Either<Failure, ParkingDomainEntity> result =
          await useCase(tCarParkingParams);
      expect(result, const Right(tParkingDomainEntity));
      verifyNever(mockCarRepository.getSlot(spaceId: 'S', slotType: '1'));
    },
  );
}
