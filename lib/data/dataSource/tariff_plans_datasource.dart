import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';

abstract class TariffPlansDataSource {
  Future<TariffDomainEntity> getTariffDetails(
      String slotType,
      String parkingSpace,
      );
}
