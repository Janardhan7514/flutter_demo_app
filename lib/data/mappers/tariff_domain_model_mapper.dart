import 'package:demo_app/data/model/tarrif_domain_model.dart';
import 'package:demo_app/functions.dart';
import '../../domain/entity/tarrif_domain_entity.dart';


class TariffDomainModelMapper
    implements Function1<TariffDomainModel, TariffDomainEntity> {
  @override
  TariffDomainEntity call(TariffDomainModel tariffData) {
    print("tariff data ");
    return TariffDomainModel(
      slotType: tariffData.slotType ?? " ",
      cost: tariffData.cost ?? " ",
      duration: tariffData.duration ?? " ",
      desc: tariffData.desc ?? " ",
    );
  }
}
