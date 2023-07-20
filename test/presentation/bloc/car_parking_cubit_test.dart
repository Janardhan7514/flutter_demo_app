import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:demo_app/data/model/tarrif_domain_model.dart';
import 'package:demo_app/domain/usecase/get_parking_slot.dart';
import 'package:demo_app/domain/usecase/get_tarrif_plans.dart';
import 'package:demo_app/domain/usecase/release_parking_slot.dart';
import 'package:demo_app/errors.dart';
import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart' as mock_It;
import 'package:demo_app/domain/usecase/get_parking_slot.dart' as myUsecase;
import 'package:demo_app/domain/usecase/release_parking_slot.dart' as patchUseCase;
import 'package:mockito/mockito.dart';

import 'car_parking_cubit_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}


@GenerateMocks([GetParkingSlotUseCase, ReleaseParkingSlotUseCase,GetTariffPlansUseCase])
void main() {
  late CarParkingCubit bloc;
  late MockGetParkingSlotUseCase mockGetSlotUseCase;
  late MockReleaseParkingSlotUseCase mockReleaseParkingSlotUseCase;
  late MockGetTariffPlansUseCase mockGetTariffPlansUseCase;
  late MockBuildContext _mockContext;

  final useParams = myUsecase.CarParkingUseCaseParams(id: "1", slotType: "S");
  final patchUseParams= patchUseCase.CarParkingUseCaseParams(id: "1", slotType: "S", parkingSpaceID: "1");
  final tariffParams=TariffPlanUseCaseParams( id: '1', slotType: 'S');
  const mParkingDomainModel = ParkingDomainModel(
    slotId: "",
    parkingSpaceId: "",
    slotType: "",
    floor: "",
  );
  const mtariffModel = TariffDomainModel(slotType: 'S-2', cost: '', duration: '', desc: '');

  setUp(() {
    _mockContext = MockBuildContext();
    mockGetSlotUseCase = MockGetParkingSlotUseCase();
    mockReleaseParkingSlotUseCase = MockReleaseParkingSlotUseCase();
    mockGetTariffPlansUseCase =MockGetTariffPlansUseCase();
    bloc = CarParkingCubit(
      getByServiceTypeUseCase: mockGetSlotUseCase,
      patchUseCase: mockReleaseParkingSlotUseCase,
      tariffPlansUseCase: mockGetTariffPlansUseCase,
    );
  });

  blocTest<CarParkingCubit, CarParkingState>(
    'getting slot for car parking',
    build: () => bloc,
    setUp: () {
      mock_It
          .when(mockGetSlotUseCase.call(useParams))
          .thenAnswer((_) async => const Right(mParkingDomainModel));
    },
    act: (CarParkingCubit cubit) async {
      bloc.getSlotForCarParking(_mockContext, "S", 1);
    },
    expect: () => [isA<CarParkingGettingSlotSuccessState>()],
  );

  blocTest<CarParkingCubit, CarParkingState>(
    'getting parking slot from APi failed',
    build: () => bloc,
    setUp: () {
      mock_It
          .when(mockGetSlotUseCase.call(useParams))
          .thenAnswer((_) async => const Left(ServerFailure("error")));
    },
    act: (CarParkingCubit cubit) async {
      bloc.getSlotForCarParking(_mockContext, "S", 1);
    },
    expect: () => [isA<CarParkingGettingSlotStateFailed>()],
  );


  blocTest<CarParkingCubit, CarParkingState>(
    'releasing parking slot from APi failed',
    build: () => bloc,
    setUp: () {
      mock_It
          .when(mockReleaseParkingSlotUseCase.call(patchUseParams))
          .thenAnswer((_) async => const Left(ServerFailure("error")));
    },
    act: (CarParkingCubit cubit) async {
      bloc.releaseSlotForCarParking(_mockContext, "", 1);
    },
    expect: () => [isA<CarParkingSlotReleasedStateFailed>()],
  );

  blocTest<CarParkingCubit, CarParkingState>(
    'releasing parking slot from APi Successful',
    build: () => bloc,
    setUp: () {
      mock_It.when(mockReleaseParkingSlotUseCase.call(patchUseParams)).thenAnswer((_) async => const Right(true));
      mock_It.when(mockGetTariffPlansUseCase.call(tariffParams)).thenAnswer((_) async => const Right(mtariffModel));
    },
    act: (CarParkingCubit cubit) async {
      bloc.releaseSlotForCarParking(_mockContext, "S-1", 1);
    },
    expect: () => [isA<CarParkingSlotReleasedState>()],
  );
}
