import 'package:demo_app/data/dataSource/car_parking_apidata_source.dart';
import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:demo_app/data/repository/carparking_repository_impl.dart';
import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'car_parking_repository_impl_test.mocks.dart';

@GenerateMocks([CarParkingAPIRemoteDataSource])
void main() {
  late CarParkingRepositoryImpl repository;
  late CarParkingAPIRemoteDataSource mockCarRemoteAPIDataSource;

  setUp(() {
    mockCarRemoteAPIDataSource = MockCarParkingAPIRemoteDataSource();
    repository = CarParkingRepositoryImpl(remoteDataSource: mockCarRemoteAPIDataSource);
  });

  group('get slot using API', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        const tParkingDomainModel = ParkingDomainModel(slotType: 'S', floor: 'first',slotId: 'S-100', parkingSpaceId: '1');
        const ParkingDomainModel tNumberTrivia = tParkingDomainModel;
        when(mockCarRemoteAPIDataSource.getSlotForCar("S", "1"),).thenAnswer((_) async => tParkingDomainModel);
        final result = await repository.getSlot(spaceId: "1", slotType: "S");
        verify(mockCarRemoteAPIDataSource.getSlotForCar("S", "1"));
        expect(result, equals(const Right(tNumberTrivia)));
      },
    );
  });
}
