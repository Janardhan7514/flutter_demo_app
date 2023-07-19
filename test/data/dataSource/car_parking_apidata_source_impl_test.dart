import 'dart:io';
import 'package:demo_app/data/dataSource/car_parking_apidata_source_impl.dart';
import 'package:demo_app/data/mappers/car_parking_domain_model_mapper.dart';
import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/functions.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'car_parking_apidata_source_impl_test.mocks.dart';

@GenerateMocks([HttpClient, CarParkingAPIRemoteDataSourceImpl])
void main() {
  late MockCarParkingAPIRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late Function1<ParkingDomainModel, ParkingDomainEntity>
      _planDomainModelMapper;

  setUp(() {
    mockHttpClient = MockHttpClient();
    _planDomainModelMapper = CarParkingDomainModelMapper();
    dataSource = MockCarParkingAPIRemoteDataSourceImpl();
  });

  group('get slot using API', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        const tParkingDomainModel = ParkingDomainModel(
            slotType: 'S',
            floor: 'first',
            slotId: 'S-100',
            parkingSpaceId: '1');
        when(dataSource.getSlotForCar("S", "1"))
            .thenAnswer((_) async => tParkingDomainModel);
        final result = await dataSource.getSlotForCar("S", "1");
        verify(dataSource.getSlotForCar("S", "1"));
        expect(result, tParkingDomainModel);
      },
    );
  });
}
