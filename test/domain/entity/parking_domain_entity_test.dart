import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tParkingDomainEntity = ParkingDomainEntity(slotType: 'S', floor: 'first', slotId: 'S-100', parkingSpaceId: '1');

  test(
    'should be a subclass of NumberTrivia entity',
        () async {
      // assert
      expect(tParkingDomainEntity, isA<ParkingDomainEntity>());
    },
  );
}