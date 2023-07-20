import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:demo_app/presentation/widgets/ParkingSlotWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloorPage extends StatelessWidget {
  const FloorPage({super.key, required this.slotSelected, required this.type});

  final String slotSelected;
  final String type;

  @override
  Widget build(BuildContext context) {
    late CarParkingCubit bloc = context.read<CarParkingCubit>();
    String slotName;
    if (slotSelected.isEmpty) {
      slotName = bloc.getSlot;
    } else {
      slotName = slotSelected;
    }
    return BlocBuilder<CarParkingCubit, CarParkingState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Parking Demo'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 700,
              child: ParkingSlotWidget(type: type, slotSelected: slotName),
            ),
          ],
        ),
      );
    });
  }
}
