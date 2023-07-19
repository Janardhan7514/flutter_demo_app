import 'package:bloc/bloc.dart';
import 'package:demo_app/domain/usecase/get_parking_slot.dart' as myUsecase;
import 'package:demo_app/domain/usecase/release_parking_slot.dart' as release;
import 'package:demo_app/domain/usecase/release_parking_slot.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecase/get_parking_slot.dart';
import 'car_parking_states.dart';

@injectable
class CarParkingCubit extends Cubit<CarParkingState> {
  final GetParkingSlotUseCase getByServiceTypeUseCase;
  final ReleaseParkingSlotUseCase patchUseCase;

  static String selectedSlot = '';
  static List<String> listOfSelectedSlots=[];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  CarParkingCubit(
      {required this.getByServiceTypeUseCase, required this.patchUseCase})
      : super(CarParkingLoadingState());

  Future<void> getSlotForCarParking(BuildContext context, String slotType, int parkingSpace) async {
    selectedSlot = "${slotType}-${parkingSpace}";
    print("My SLot ${selectedSlot}");

    final failureOrData = await getByServiceTypeUseCase.call(myUsecase.CarParkingUseCaseParams(
      id: parkingSpace.toString(),
      slotType: slotType,
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

  Future<void> releaseSlotForCarParking(
      BuildContext context, String size, int parkingSpace) async {
    final failureOrData = await patchUseCase.call(
        release.CarParkingUseCaseParams(
            id: "1", slotType: "S", parkingSpaceID: "1"));
    failureOrData.match(
      (failure) {
        emit(CarParkingSlotReleasedStateFailed(message: failure.message));
      },
      (featuresModel) {
        debugPrint('Features: $featuresModel');
        selectedSlot ="";
        emit(const CarParkingSlotReleasedState("released"));
      },
    );
  }

  Future<void> slotSelection(BuildContext context, String slotType, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("${slotType}-${index}", "${slotType}-${index}");
    selectedSlot = "${slotType}-${index}";
    print("My SLot ${selectedSlot}");
    if(!listOfSelectedSlots.contains(selectedSlot)){
      listOfSelectedSlots.add(selectedSlot);
    }
    emit(CarParkingSlotIsSelected("${slotType}-${index}"));
  }

  String get getSlot {
    return selectedSlot;
  }

  set setSlot(String name) {
    selectedSlot = name;
  }

  List<String>  getSlotList() {
    return listOfSelectedSlots;
  }



  void setLoadedState() {
    emit(CarParkingLoadingSuccessState());
  }

  Future<String> nameRetriever(String name1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(name1) ?? '';
    return name;
  }
}
