import 'package:demo_app/domain/entity/parking_domain_entity.dart';
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

class CarParkingSlotReleasedState extends CarParkingState {
  final String release;

  const CarParkingSlotReleasedState(this.release);

  @override
  List<Object> get props => [release];
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
