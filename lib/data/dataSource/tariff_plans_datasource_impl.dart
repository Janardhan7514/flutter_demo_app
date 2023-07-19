import 'dart:convert';

import 'package:demo_app/data/dataSource/tariff_plans_datasource.dart';
import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:demo_app/data/model/tarrif_domain_model.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';

import 'package:flutter/services.dart';

import '../../domain/entity/parking_domain_entity.dart';
import '../../functions.dart';
import 'car_parking_apidata_source.dart';

class TariffPlanDataSourceImpl extends TariffPlansDataSource {
  final Function1<TariffDomainModel, TariffDomainEntity>_planDomainModelMapper;

  TariffPlanDataSourceImpl(this._planDomainModelMapper);


  @override
  Future<TariffDomainEntity> getTariffDetails(String slotType, String parkingSpace) async{
    var testData = const TariffDomainModel(
      tariffID: "",
      cost: "",
      duration: "",
      desc: "",
    );

    late TariffDomainModel tariffDomainModel;
    String data = await rootBundle.loadString('assets/jsons/tarrif_new.json');
    var jsonResult = json.decode(data);
    var finalResult = jsonResult.map((data) => TariffDomainModel.fromJson(data)).toList();

    return _planDomainModelMapper(finalResult[0]);
  }
}
