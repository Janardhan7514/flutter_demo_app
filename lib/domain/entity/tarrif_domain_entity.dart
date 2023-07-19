import 'package:equatable/equatable.dart';

class TariffDomainEntity extends Equatable {
  final String tariffID;
  final String cost;
  final String duration;
  final String desc;

  const TariffDomainEntity({
    required this.tariffID,
    required this.cost,
    required this.duration,
    required this.desc,
  });

  @override
  List<Object?> get props => [tariffID, cost, duration, desc];
}
