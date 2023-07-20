import 'package:equatable/equatable.dart';

class TariffDomainEntity extends Equatable {
  final String slotType;
  final String cost;
  final String duration;
  final String desc;

  const TariffDomainEntity({
    required this.slotType,
    required this.cost,
    required this.duration,
    required this.desc,
  });

  @override
  List<Object?> get props => [slotType, cost, duration, desc];
}
