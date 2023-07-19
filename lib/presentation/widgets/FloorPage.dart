import 'package:demo_app/presentation/bloc/car_parking_cubit.dart';
import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:demo_app/presentation/widgets/ParkingSlotWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';

class FloorPage extends StatelessWidget {
  const FloorPage({super.key, required this.slotSelected, required this.type});

  final String slotSelected;
  final String type;

  @override
  Widget build(BuildContext context) {
    late CarParkingCubit bloc = context.read<CarParkingCubit>();
    var slotName;
    if(slotSelected.isEmpty){
      slotName=bloc.getSlot;
    }else{
      slotName=slotSelected;
    }
    print("NAME ${slotName}");
    return BlocBuilder<CarParkingCubit,CarParkingState>(
        builder: (context,state){
         return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('My App'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Slot Type - S",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Total Capacity - 100",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 700,
                    child:  ParkingSlotWidget(type:type,slotSelected: slotName),
                ),
              ],
            ),
          );
        }

      );
  }
}
