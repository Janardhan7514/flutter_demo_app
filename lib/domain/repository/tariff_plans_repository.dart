import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../errors.dart';


abstract class TariffsPlanRepository {
  Future<Either<Failure, TariffDomainEntity>> getTariff({required String? spaceId, required String? slotType,
  });

}
