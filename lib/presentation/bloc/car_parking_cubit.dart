import 'package:bloc/bloc.dart';
import 'package:demo_app/domain/usecase/get_parking_slot.dart' as myUsecase;
import 'package:demo_app/domain/usecase/release_parking_slot.dart' as release;
import 'package:demo_app/domain/usecase/release_parking_slot.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecase/get_parking_slot.dart';
import 'car_parking_states.dart';

@injectable
class CarParkingCubit extends Cubit<CarParkingState> {
  final GetParkingSlotUseCase getByServiceTypeUseCase;
  final ReleaseParkingSlotUseCase patchUseCase;

  CarParkingCubit(
      {required this.getByServiceTypeUseCase, required this.patchUseCase})
      : super(CarParkingLoadingState());

  Future<void> getSlotForCarParking(
      BuildContext context, String size, int parkingSpace) async {
    final failureOrData =
        await getByServiceTypeUseCase.call(myUsecase.CarParkingUseCaseParams(
      id: "1",
      slotType: "S",
    ));
    failureOrData.match(
      (failure) {
        emit(CarParkingGettingSlotStateFailed(failure.message));
      },
      (featuresModel) {
        debugPrint('Features: $featuresModel');
        emit(CarParkingGettingSlotSuccessState(featuresModel));
      },
    );
  }

  Future<void> releaseSlotForCarParking(BuildContext context, String size, int parkingSpace) async {
    final failureOrData = await patchUseCase.call(release.CarParkingUseCaseParams(id: "1", slotType: "S", parkingSpaceID: "1"));
    failureOrData.match(
      (failure) {
        emit(CarParkingSlotReleasedStateFailed(message: failure.message));
      },
      (featuresModel) {
        debugPrint('Features: $featuresModel');
        emit(const CarParkingSlotReleasedState("released"));
      },
    );
  }

  void setLoadedState() {
    emit(CarParkingLoadingSuccessState());
  }
}
