import 'dart:convert';

import 'package:demo_app/data/model/parking_domain_model.dart';

import 'package:flutter/services.dart';

import '../../domain/entity/parking_domain_entity.dart';
import '../../functions.dart';
import 'car_parking_apidata_source.dart';

class CarParkingAPIRemoteDataSourceImpl extends CarParkingAPIRemoteDataSource {
  final Function1<ParkingDomainModel, ParkingDomainEntity>
      _planDomainModelMapper;

  CarParkingAPIRemoteDataSourceImpl(this._planDomainModelMapper);


  //To check how other slots are assigned if S slot is not present remove that slot from Json file "car_parking_json_response"
  @override
  Future<ParkingDomainEntity> getSlotForCar(
      String slotType, String parkingSpace) async {
    var testData = const ParkingDomainModel(
      slotId: "",
      parkingSpaceId: "",
      slotType: "",
      floor: "",
    );

    late ParkingDomainModel slotModelS;
    late ParkingDomainModel slotModelM;
    late ParkingDomainModel slotModelL;
    late ParkingDomainModel slotModelXL;
    late ParkingDomainModel assignedSlot;

    String data = await rootBundle
        .loadString('assets/jsons/car_parking_json_response.json');
    var jsonResult = json.decode(data);
    var finalResult =
        jsonResult.map((data) => ParkingDomainModel.fromJson(data)).toList();

    slotModelS = finalResult.firstWhere((element) => element.slotType == "S",
        orElse: () => testData);
    slotModelM = finalResult.firstWhere((element) => element.slotType == "M",
        orElse: () => testData);
    slotModelL = finalResult.firstWhere((element) => element.slotType == "L",
        orElse: () => testData);
    slotModelXL = finalResult.firstWhere((element) => element.slotType == "XL",
        orElse: () => testData);

    if (slotModelS.slotType.isEmpty) {
      if (slotModelM.slotType.isEmpty) {
        if (slotModelL.slotType.isEmpty) {
          if (slotModelXL.slotType.isEmpty) {
            assignedSlot = testData;
          } else {
            assignedSlot = slotModelXL;
          }
        } else {
          assignedSlot = slotModelL;
        }
      } else {
        assignedSlot = slotModelM;
      }
    } else {
      assignedSlot = slotModelS;
    }

    return _planDomainModelMapper(assignedSlot);
  }

  @override
  Future<bool> releaseSlotForCar(String slotType, String parkingSpace) {
    //Assuming Api return true
    return Future.value(true);
  }
}
