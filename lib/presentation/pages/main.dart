import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:flutter/material.dart';

import '../../injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CarParkingCubit bloc = getIt<CarParkingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarParkingCubit>(
      create: (_) => bloc,
      child: BlocBuilder<CarParkingCubit, CarParkingState>(
        builder: (BuildContext context, state) {
          return buildScaffold(state, context, bloc);
        },
      ),
    );
  }

  Widget buildScaffold(
      CarParkingState state, BuildContext context, CarParkingCubit bloc) {
    if (state is CarParkingLoadingState) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        BlocProvider.of<CarParkingCubit>(context).setLoadedState();
      });

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is CarParkingGettingSlotStateFailed) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center(
          child: Text("ERROR"),
        ),
      );
    } else if (state is CarParkingGettingSlotSuccessState) {
      var desc;
      var SlotType = state.featuresModel.slotType;
      var SlotId = state.featuresModel.slotId;
      var floor = state.featuresModel.floor;
      if (SlotType.isEmpty) {
         desc = "Sorry no slot available";
      } else {
         desc =
            "You have been alloted parking on  ${floor} floor of slotType ${SlotType} having slotId ${SlotId} ";
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          key: const Key("K-container"),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 5, color: Colors.amberAccent),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    key: const Key("Allocate"),
                    onPressed: () {
                      BlocProvider.of<CarParkingCubit>(context)
                          .releaseSlotForCarParking(context, "S", 1);
                    },
                    child: const Text('click To DeAllocate'),
                  ),
                ),
                Text(desc),
              ],
            ),
          ),
        ),
      );
    } else if (state is CarParkingSlotReleasedState) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 5, color: Colors.amberAccent),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    key: const Key("Allocate"),
                    onPressed: () {
                      BlocProvider.of<CarParkingCubit>(context)
                          .getSlotForCarParking(context, "S", 1);
                    },
                    child: const Text('Allocate'),
                  ),
                ),
                const Text("your parking slot has been released"),
              ],
            ),
          ),
        ),
      );
    } else if (state is CarParkingLoadingSuccessState) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  key: const Key("Allocate"),
                  onPressed: () {
                    BlocProvider.of<CarParkingCubit>(context)
                        .getSlotForCarParking(context, "S", 1);
                  },
                  child: Text('Allocate'),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
