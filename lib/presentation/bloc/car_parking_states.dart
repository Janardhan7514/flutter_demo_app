import 'package:demo_app/domain/entity/parking_domain_entity.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CarParkingState extends Equatable {
  const CarParkingState();

  @override
  List<Object> get props => [];
}

class CarParkingLoadingState extends CarParkingState {
  @override
  List<Object> get props => [];
}

class CarShowSlotUI extends CarParkingState {
  @override
  List<Object> get props => [];
}

class CarParkingLoadingSuccessState extends CarParkingState {
  @override
  List<Object> get props => [];
}

class CarParkingGettingSlotSuccessState extends CarParkingState {
  final ParkingDomainEntity featuresModel;

  const CarParkingGettingSlotSuccessState(this.featuresModel);

  @override
  List<Object> get props => [featuresModel];
}

class CarParkingNewLocalSlotSuccess extends CarParkingState {
  final String slot;

  const CarParkingNewLocalSlotSuccess(this.slot);

  @override
  List<Object> get props => [slot];
}

class CarParkingReleaseLocalSlotSuccess extends CarParkingState {
  final String slot;

  const CarParkingReleaseLocalSlotSuccess(this.slot);

  @override
  List<Object> get props => [slot];
}

class CarParkingSlotReleasedState extends CarParkingState {
  final String release;
  final TariffDomainEntity tariffData;

  const CarParkingSlotReleasedState(this.release, this.tariffData);

  @override
  List<Object> get props => [release,tariffData];
}

class CarParkingSlotReleasedStateFailed extends CarParkingState {
  final String message;

  const CarParkingSlotReleasedStateFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class CarParkingGettingSlotStateFailed extends CarParkingState {
  final String message;

  const CarParkingGettingSlotStateFailed(this.message);

  @override
  List<Object> get props => [message];
}

class CarParkingSlotIsSelected extends CarParkingState {
  final String message;

  const CarParkingSlotIsSelected(this.message);

  @override
  List<Object> get props => [message];
}

class CarParkingTariffFetchedState extends CarParkingState {
  final TariffDomainEntity featuresModel;

  const CarParkingTariffFetchedState(this.featuresModel);

  @override
  List<Object> get props => [featuresModel];
}

class CarParkingTariffFetchedFailedState extends CarParkingState {
  final String message;

  const CarParkingTariffFetchedFailedState(this.message);

  @override
  List<Object> get props => [message];
}
