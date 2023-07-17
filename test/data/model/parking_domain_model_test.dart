import 'dart:convert';
import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/json_reader.dart';

void main() {
  const tParkingDomainModel = ParkingDomainModel(slotType: 'S', floor: 'first',slotId: 'S-100', parkingSpaceId: '1');

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      expect(tParkingDomainModel, isA<ParkingDomainModel>());
    },
  );

  group('fromJson and toJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(fixture('car_get_slot.json'));
        final result = ParkingDomainModel.fromJson(jsonMap);
        expect(result, tParkingDomainModel);
      },
    );

    test(
      'should return a JSON map containing the proper data',
      () async {
        final result = tParkingDomainModel.toJson();

        final expectedJsonMap = {
          "slotId": "S-100",
          "parkingSpaceId": '1',
          'slotType': 'S',
          'floor': 'first'
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
