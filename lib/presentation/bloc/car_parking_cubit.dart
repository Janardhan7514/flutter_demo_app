import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:demo_app/domain/entity/tarrif_domain_entity.dart';
import 'package:demo_app/domain/models/ParkingLot.dart';
import 'package:demo_app/domain/models/SlotFactory.dart';
import 'package:demo_app/domain/models/bookSlot.dart';
import 'package:demo_app/domain/usecase/get_parking_slot.dart' as myUsecase;
import 'package:demo_app/domain/usecase/get_tarrif_plans.dart';
import 'package:demo_app/domain/usecase/release_parking_slot.dart' as release;
import 'package:demo_app/domain/usecase/release_parking_slot.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/Floor.dart';
import '../../domain/models/parking_slots.dart';
import '../../domain/usecase/get_parking_slot.dart';
import 'car_parking_states.dart';

@injectable
class CarParkingCubit extends Cubit<CarParkingState> {
  final GetParkingSlotUseCase getByServiceTypeUseCase;
  final ReleaseParkingSlotUseCase patchUseCase;
  final GetTariffPlansUseCase tariffPlansUseCase;

  static String selectedSlot = '';
  static List<String> listOfSelectedSlots = [];
  List<ParkingSlotType> nSlots = ParkingSlotType.values;

  List<Floor> parkingFloors = <Floor>[];
  Map<ParkingSlotType, Map<String, ParkingSlot?>> allSlots = HashMap<ParkingSlotType, Map<String, ParkingSlot?>>();


  CarParkingCubit(
      {required this.getByServiceTypeUseCase,
      required this.tariffPlansUseCase,
      required this.patchUseCase})
      : super(CarParkingLoadingState());

  String get getSlot {
    return selectedSlot;
  }

  set setSlot(String name) {
    selectedSlot = name;
  }

  Future<void> getSlotForCarParking(
      BuildContext context, String slotType, int parkingSpace) async {
    selectedSlot = "$slotType-$parkingSpace";
    debugPrint("Slot io selected $selectedSlot");

    final failureOrData = await getByServiceTypeUseCase.call(
      myUsecase.CarParkingUseCaseParams(
        id: parkingSpace.toString(),
        slotType: slotType,
      ),
    );
    failureOrData.match(
      (failure) {
        emit(CarParkingGettingSlotStateFailed(failure.message));
      },
      (featuresModel) {
        selectedSlot =
            "${featuresModel.slotType}-${featuresModel.parkingSpaceId}";
        debugPrint("My Slot from API $selectedSlot");
        debugPrint('Features: $featuresModel');
        emit(CarParkingGettingSlotSuccessState(featuresModel));
      },
    );
  }

  Future<TariffDomainEntity> getTariff(
      BuildContext context, String slotType, int parkingSpace) async {
    TariffDomainEntity entity = const TariffDomainEntity(
        slotType: "", cost: "cost", duration: "duration", desc: "desc");

    final failureOrData = await tariffPlansUseCase.call(
      TariffPlanUseCaseParams(
        id: parkingSpace.toString(),
        slotType: slotType,
      ),
    );
    failureOrData.match(
      (failure) {
        emit(CarParkingTariffFetchedFailedState(failure.message));
        return entity;
      },
      (featuresModel) {
        debugPrint('Features: $featuresModel');
        entity = featuresModel;
      },
    );
    return entity;
  }

  Future<void> releaseSlotForCarParking(
      BuildContext context, String size, int parkingSpace) async {
    final failureOrData = await patchUseCase.call(
      release.CarParkingUseCaseParams(
        id: "1",
        slotType: "S",
        parkingSpaceID: parkingSpace.toString(),
      ),
    );
    failureOrData.match(
      (failure) {
        emit(CarParkingSlotReleasedStateFailed(message: failure.message));
      },
      (featuresModel) async {
        debugPrint('Features: $featuresModel');
        var slot = selectedSlot.split("-");
        var tariff = await getTariff(context, slot[0], int.parse(slot[1]));
        emit(CarParkingSlotReleasedState("released", tariff));
      },
    );
  }

  void setLoadedState() {
    emit(CarParkingLoadingSuccessState());
    for(int i=0;i<nSlots.length;i++){
      createSlotForParking(nSlots.elementAt(i), 100);
    }
  }

  //TODO unused now
  Future<String> nameRetriever(String name1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(name1) ?? '';
    return name;
  }

  void createSlotForParking(ParkingSlotType slotType, int capacity) async {
    debugPrint("Slot Name ${slotType.name}");

    Map<String, ParkingSlot?> compactSlot = HashMap<String, ParkingSlot?>();

    SlotFactory slotFactory = SlotFactory();

    for (int i = 0; i < capacity; i++) {
      compactSlot.putIfAbsent("${slotType.name}-$i", () => slotFactory.getParkingSlot(slotType, "${slotType.name}-$i"));
    }
    allSlots.putIfAbsent(slotType, () => compactSlot);

    Floor parkingFloor= Floor();
    parkingFloor.assignData("1", [], allSlots);

    parkingFloors.add(parkingFloor);

    ParkingLot parkingLot = ParkingLot();
    parkingLot.assignData("BT", parkingFloors,"BT-001");

  }

  Future<ParkingSlot?> getParkingSlot(String slotNumber) async{
    Vehicle vehicle = Vehicle("MH-12-RU-1121", VehicleType.bus);
    ParkingSlot? parkingSlot =await ParkingLot.instance.getParkingSlotForVehicle(vehicle,slotNumber);

    emit(CarParkingNewLocalSlotSuccess(parkingSlot!.slotNumber));
    return parkingSlot;
  }

  Future<ParkingSlot?> releaseParkingSlot(String slotNumber) async{
    Vehicle vehicle = Vehicle("MH-12-RU-1121", VehicleType.bus);
    ParkingSlot? parkingSlot =await ParkingLot.instance.releaseParkingSlot(vehicle,slotNumber);

    emit(CarParkingReleaseLocalSlotSuccess(parkingSlot!.slotNumber));
    return parkingSlot;
  }

  List<BookSlot> getBooksLostList(){
    return Floor.instance.getSlotList();
  }
}
