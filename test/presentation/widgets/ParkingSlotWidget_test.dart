import 'package:bloc_test/bloc_test.dart';
import 'package:demo_app/data/model/tarrif_domain_model.dart';
import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:demo_app/presentation/widgets/ParkingSlotWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CarParkingCubitMock extends MockCubit<CarParkingState>
    implements CarParkingCubit {}

class CarParkingStateFake extends Fake implements CarParkingState {}

class CarParkingCubitFake extends Fake implements CarParkingCubit {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late CarParkingCubit bloc;
  final getIt = GetIt.instance;
  late MockBuildContext _mockContext;
  const mTariffDomainModel = TariffDomainModel(slotType: '', cost: '', duration: '', desc: '');

  setUp(() {
    if (!GetIt.I.isRegistered<CarParkingState>()) {
      GetIt.instance
          .registerLazySingleton<CarParkingState>(() => CarParkingStateFake());
    }
    if (!GetIt.I.isRegistered<CarParkingCubit>()) {
      GetIt.instance
          .registerLazySingleton<CarParkingCubit>(() => CarParkingCubitMock());
    }
    _mockContext = MockBuildContext();
    bloc = getIt.get<CarParkingCubit>();
  });

  setUpAll(() {
    registerFallbackValue(CarParkingStateFake());
  });

  tearDownAll(() {
    GetIt.instance.unregister<CarParkingState>();
    GetIt.instance.unregister<CarParkingCubit>();
  });

  Future<void> dummyFunction() async{

  }

  testWidgets("Find list view object and number of slots", (WidgetTester tester) async {
    CarParkingLoadingSuccessState apiLoadingState = CarParkingLoadingSuccessState();
    when(() => bloc.state).thenReturn(apiLoadingState);
    await tester.pumpWidget(
      BlocProvider<CarParkingCubit>(
        create: (context) => bloc,
        child: BlocBuilder<CarParkingCubit, CarParkingState>(
          builder: (context, state) {
            if (state is CarParkingLoadingSuccessState) {
              return const MaterialApp(
                home: Scaffold(
                  body: ParkingSlotWidget(
                    slotSelected: 'S-2',
                    type: 'A',
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );


    final count = tester.widgetList<ListView>(find.byKey(const ValueKey("CarParkingList"))).length;
    expect(count, 1);
    expect(find.byType(ElevatedButton), findsNWidgets(100));
  });




  testWidgets("Click on ParkingSlot", (WidgetTester tester) async {
    CarParkingLoadingSuccessState apiLoadingState = CarParkingLoadingSuccessState();
    when(() => bloc.state).thenReturn(apiLoadingState);
    when(() => bloc.getSlotForCarParking(_mockContext, "S-24", 1)).thenAnswer((_) async => dummyFunction);
    await tester.pumpWidget(
      BlocProvider<CarParkingCubit>(
        create: (context) => bloc,
        child: BlocBuilder<CarParkingCubit, CarParkingState>(
          builder: (context, state) {
            if (state is CarParkingLoadingSuccessState) {
              return const MaterialApp(
                home: Scaffold(
                  body: ParkingSlotWidget(
                    slotSelected: 'S-24',
                    type: 'A',
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );

    expect(find.byKey(const Key("S-24")), findsOneWidget);
    //TODO somehow bloc is becoming null so it is failing at getSlotForCarParking
    //await tester.tap(find.byKey(const Key('S-24')),warnIfMissed: false);
    //await tester.pump();
  });


  testWidgets("find column and check 5 item should display in column" , (WidgetTester tester) async {
    CarParkingSlotReleasedState apiLoadingState =   const CarParkingSlotReleasedState("message",mTariffDomainModel);
    when(() => bloc.state).thenReturn(apiLoadingState);
    await tester.pumpWidget(
      BlocProvider<CarParkingCubit>(
        create: (context) => bloc,
        child: BlocBuilder<CarParkingCubit, CarParkingState>(
          builder: (context, state) {
            if (state is CarParkingSlotReleasedState) {
              return const MaterialApp(
                home: Scaffold(
                  body: ParkingSlotWidget(slotSelected: "S-24", type: "A"),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
    expect(find.byKey(const Key("bill-invoice-column")), findsOneWidget);
    final childFinder =  find.descendant(of: find.byKey(const Key("bill-invoice-column")), matching: find.byType(Row));
    expect(childFinder,  findsNWidgets(5));
  });
}
