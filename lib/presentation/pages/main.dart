import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:demo_app/presentation/widgets/FloorPage.dart';
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
      title: 'Parking Demo',
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
      child: BlocConsumer<CarParkingCubit, CarParkingState>(
        listener: (BuildContext context, state) {},
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
      return genericScaffold(
        const CircularProgressIndicator(),
      );
    } else if (state is CarParkingGettingSlotStateFailed) {
      return carParkingFailedUI();
    } else if (state is CarParkingTariffFetchedFailedState) {
      return carParkingFailedUI();
    } else if (state is CarParkingLoadingSuccessState) {
      return carParkingLoadingSuccessUI(context);
    } else if (state is CarParkingSlotIsSelected) {
      return Container();
    } else {
      return Container();
    }
  }

  Scaffold carParkingLoadingSuccessUI(BuildContext context) {
    Widget column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        myCard(),

        SizedBox(
          width: 300,
          child: elevatedButtonAllocate(context),
        ),
        SizedBox(
          width: 300,
          child: elevatedButtonDeAllocate(context),
        ),
      ],
    );
    return genericScaffold(column);
  }

  ElevatedButton elevatedButtonDeAllocate(BuildContext context) {
    return ElevatedButton(
      key: const Key("DeAllocate"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => BlocProvider.value(
            value: bloc,
            child: const FloorPage(
              type: "D",
              slotSelected: '',
            ),
          ),
        ));
      },
      child: const Text('click DeAllocate'),
    );
  }

  ElevatedButton elevatedButtonAllocate(BuildContext context) {
    return ElevatedButton(
      key: const Key("Allocate"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => BlocProvider.value(
            value: bloc,
            child: const FloorPage(
              type: "A",
              slotSelected: '',
            ),
          ),
        ));
      },
      child: const Text('click Allocate'),
    );
  }

  Widget carParkingFailedUI() {
    return genericScaffold(const Text("ERROR"));
  }

  Scaffold genericScaffold(Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: child),
    );
  }

  Widget myCard() {
    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.lightGreen[100],
      shadowColor: Colors.blueGrey,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.local_parking, color: Colors.cyan, size: 45),
            title: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Welcome to Amanora Parking",
                style: TextStyle(fontSize: 20),
              ),
            ),
            subtitle: Text('Vehicle under CCTV surveillance',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          ),
        ],
      ),
    );
  }
}
