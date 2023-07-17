import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/repository/carparking_repository.dart';
import 'package:demo_app/domain/usecase/release_parking_slot.dart';
import 'package:demo_app/domain/usecase/release_parking_slot.dart' as releaseSlot;
import 'package:demo_app/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_parking_slot_test.mocks.dart';

@GenerateMocks([CarParkingRepository])
void main() {
  late ReleaseParkingSlotUseCase useCase;
  late CarParkingRepository mockCarRepository;

  const spaceId = "1";
  final tCarParkingParams = releaseSlot.CarParkingUseCaseParams(id: "1", slotType: "S", parkingSpaceID: "1");

  setUp(() {
    mockCarRepository = MockCarParkingRepository();
    useCase = ReleaseParkingSlotUseCase(featuresRepository: mockCarRepository);
  });

  test(
    'should release slot for car from the repository',
        () async {
      when(mockCarRepository.releaseSlot(spaceId: '1', slotType: 'S')).thenAnswer((_) async => const Right(true));
      Either<Failure, bool> result = await useCase(tCarParkingParams);
      expect(result, const Right(true));
      verifyNever(mockCarRepository.getSlot(spaceId: 'S', slotType: '1'));
    },
  );
}
