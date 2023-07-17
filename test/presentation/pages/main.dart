import 'package:bloc_test/bloc_test.dart';
import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:demo_app/presentation/pages/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

class CarParkingCubitMock extends MockCubit<CarParkingState>
    implements CarParkingCubit {}

class CarParkingStateFake extends Fake implements CarParkingState {}

class CarParkingCubitFake extends Fake implements CarParkingCubit {}

@GenerateMocks([CarParkingCubit])
void main() {
  late CarParkingCubit bloc;
  final getIt = GetIt.instance;
  const mParkingDomainModel = ParkingDomainModel(
    slotId: "",
    parkingSpaceId: "",
    slotType: "",
    floor: "",
  );
  setUp(() {
    if (!GetIt.I.isRegistered<CarParkingState>()) {
      GetIt.instance
          .registerLazySingleton<CarParkingState>(() => CarParkingStateFake());
    }
    if (!GetIt.I.isRegistered<CarParkingCubit>()) {
      GetIt.instance
          .registerLazySingleton<CarParkingCubit>(() => CarParkingCubitMock());
    }

    bloc = getIt.get<CarParkingCubit>();
  });

  setUpAll(() {
    registerFallbackValue(CarParkingStateFake());
  });

  tearDownAll(() {
    GetIt.instance.unregister<CarParkingState>();
    GetIt.instance.unregister<CarParkingCubit>();
  });

  Widget testWidget = MediaQuery(
      data: const MediaQueryData(),
      child: BlocProvider<CarParkingCubit>(
        create: (context) => bloc,
        child: BlocBuilder<CarParkingCubit, CarParkingState>(
          builder: (context, state) {
            return const MaterialApp(home: MyHomePage(title: 'T'));
          },
        ),
      ));

  testWidgets('MyHomePage has a title', (tester) async {
    // Create the widget by telling the tester to build it.
    CarParkingLoadingSuccessState apiLoadingState =
        CarParkingLoadingSuccessState();
    when(() => bloc.state).thenReturn(apiLoadingState);
    await tester.pumpWidget(testWidget);
    final titleFinder = find.text('T');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('MyHomePage is loading state', (tester) async {
    CarParkingLoadingState apiLoadingState = CarParkingLoadingState();
    when(() => bloc.state).thenReturn(apiLoadingState);
    await tester.pumpWidget(
      MediaQuery(
        data:const MediaQueryData(),
        child: BlocProvider<CarParkingCubit>(
          create: (context) => bloc,
          child: BlocBuilder<CarParkingCubit, CarParkingState>(
            builder: (context, state) {
              if (state is CarParkingLoadingState) {
                return const MaterialApp(home: Text("Loading Page"));
              } else {
                return const MaterialApp(home: MyHomePage(title: 'T'));
              }
            },
          ),
        ),
      ),
    );
    final titleFinder = find.text('Loading Page');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('MyHomePage is get parking slot is success', (tester) async {
    CarParkingGettingSlotSuccessState apiLoadingState = const CarParkingGettingSlotSuccessState(mParkingDomainModel);
    when(() => bloc.state).thenReturn(apiLoadingState);
    await tester.pumpWidget(
      BlocProvider<CarParkingCubit>(
        create: (context) => bloc,
        child: BlocBuilder<CarParkingCubit, CarParkingState>(
          builder: (context, state) {
            if (state is CarParkingGettingSlotSuccessState) {
              return const MaterialApp(home: MyHomePage(title: 'T'));
            } else {
              return  Container();
            }
          },
        ),
      ),
    );
    const testKey = Key("K-container");
    const testButton = Key("Allocate");
    expect(find.byKey(testKey), findsOneWidget);
    expect(find.byKey(testButton), findsOneWidget);
    final titleFinder = find.text('click To DeAllocate');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('CarParkingGettingSlotStateFailed show error', (tester) async {
    CarParkingGettingSlotStateFailed apiLoadingState = const CarParkingGettingSlotStateFailed("error");
    when(() => bloc.state).thenReturn(apiLoadingState);
    await tester.pumpWidget(
      BlocProvider<CarParkingCubit>(
        create: (context) => bloc,
        child: BlocBuilder<CarParkingCubit, CarParkingState>(
          builder: (context, state) {
            if (state is CarParkingGettingSlotStateFailed) {
              return const MaterialApp(home: MyHomePage(title: 'T'));
            } else {
              return  Container();
            }
          },
        ),
      ),
    );
    final titleFinder = find.text('ERROR');
    expect(titleFinder, findsOneWidget);
  });

}
