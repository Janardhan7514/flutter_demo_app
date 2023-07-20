import 'dart:convert';

import 'package:demo_app/data/dataSource/tariff_plans_datasource.dart';
import 'package:demo_app/data/model/tarrif_domain_model.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:flutter/services.dart';
import '../../functions.dart';

class TariffPlanDataSourceImpl extends TariffPlansDataSource {
  final Function1<TariffDomainModel, TariffDomainEntity> _planDomainModelMapper;

  TariffPlanDataSourceImpl(this._planDomainModelMapper);

  @override
  Future<TariffDomainEntity> getTariffDetails(
      {required String slotType, required String parkingSpace}) async {
    var testData = const TariffDomainModel(slotType: '', cost: '', duration: '', desc: '');

    String data = await rootBundle.loadString('assets/jsons/tarrif_new.json');
    var jsonResult = json.decode(data);
    var finalResult = jsonResult.map((data) => TariffDomainModel.fromJson(data)).toList();
    print("Slot is ${parkingSpace}");
    print(finalResult);

    late TariffDomainModel assignedSlot;

    assignedSlot = finalResult.firstWhere(
        (element) => (element.slotType == parkingSpace),
        orElse: () => testData);

    return _planDomainModelMapper(assignedSlot);
  }
}
