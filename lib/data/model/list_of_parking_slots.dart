import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:equatable/equatable.dart';

class ParkingDomainModelList {
  final List<ParkingDomainModel> parkingDomainModelList;

  const ParkingDomainModelList({
    required this.parkingDomainModelList,
  });
}
