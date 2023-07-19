import 'package:demo_app/domain/usecase/usecase.dart';
import 'package:demo_app/domain/usecase/usecase_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../errors.dart';
import '../entity/tarrif_domain_entity.dart';
import '../repository/tariff_plans_repository.dart';

class GetTariffPlansUseCase
    implements UseCase<TariffDomainEntity, TariffPlanUseCaseParams> {
  final TariffsPlanRepository featuresRepository;

  GetTariffPlansUseCase({required this.featuresRepository});

  @override
  Future<Either<Failure, TariffDomainEntity>> call(
      TariffPlanUseCaseParams params) async {
    try {
      return await featuresRepository.getTariff(
          spaceId: params.slotType, slotType: params.id);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class TariffPlanUseCaseParams extends BaseParams {
  final String id;
  final String slotType;

  TariffPlanUseCaseParams({required this.id, required this.slotType});

  @override
  List<Object?> get props => [id, slotType];
}
