import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:demo_app/errors.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/tariff_plans_repository.dart';
import '../dataSource/tariff_plans_datasource.dart';

@injectable
class TariffPlanRepositoryImpl extends TariffsPlanRepository {
  final TariffPlansDataSource dataSource;

  TariffPlanRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, TariffDomainEntity>> getTariff({required String? spaceId, required String? slotType}) async{
    try {
    return Right((await dataSource.getTariffDetails(slotType: slotType!, parkingSpace: spaceId!)));
    } catch (e) {
    return const Left(ServerFailure("Failure"));
    }
  }
}
