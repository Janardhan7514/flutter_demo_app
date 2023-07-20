import 'package:bloc_test/bloc_test.dart';
import 'package:demo_app/data/model/parking_domain_model.dart';
import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:demo_app/presentation/widgets/FloorPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarParkingCubitMock extends MockCubit<CarParkingState>
    implements CarParkingCubit {}

class CarParkingStateFake extends Fake implements CarParkingState {}

class CarParkingCubitFake extends Fake implements CarParkingCubit {}

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

  testWidgets("find the heading of AppBar", (WidgetTester tester) async {
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
                  body: FloorPage(
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

    expect(find.text("Parking Demo"), findsOneWidget);
    expect(tester.takeException().toString().contains('A RenderFlex overflowed by'),
      true,
    );
  });
}
