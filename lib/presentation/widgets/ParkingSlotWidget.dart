import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../injection.dart';
import '../bloc/car_parking_cubit.dart';

class ParkingSlotWidget extends StatefulWidget {
  const ParkingSlotWidget({super.key, required this.slotSelected, required this.type});

  final String slotSelected;
  final String type;

  @override
  State<ParkingSlotWidget> createState() => _ParkingSlotWidgetState();
}

class _ParkingSlotWidgetState extends State<ParkingSlotWidget> {
  List<String> slots = ["S", "M", "L", "XL"];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  late CarParkingCubit bloc = getIt<CarParkingCubit>();
  List<String> listOFSlots = [];

  @override
  Widget build(BuildContext context) {
    listOFSlots = bloc.getSlotList();
    return BlocConsumer<CarParkingCubit, CarParkingState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CarParkingGettingSlotSuccessState) {
            var desc;
            var SlotType = state.featuresModel.slotType;
            var SlotId = state.featuresModel.slotId;
            var floor = state.featuresModel.floor;
            if (SlotType.isEmpty) {
              desc = "Sorry no slot available";
            } else {
              desc = "You have been alloted parking on  ${floor} floor of slotType ${SlotType} having slotId ${SlotId} ";
            }

            final snackBar = SnackBar(
              content: Text(desc),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if(state is CarParkingSlotReleasedState){

            var SlotType = state.release;
            var desc;
            if (SlotType.isEmpty) {
              desc = "Sorry no slot available";
            } else {
              desc =
              "Your alloted slot has been released";
            }

            final snackBar = SnackBar(
              content: Text(desc),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var selectedSlot = "";
          var releaseSlot = "";
          if (state is CarParkingGettingSlotSuccessState) {
            selectedSlot = state.featuresModel.slotId;
          } else if(state is CarParkingSlotReleasedState){
            releaseSlot=state.release;
          }else {
            selectedSlot = widget.slotSelected;
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, outerIndex) {
                  return GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 4,
                    crossAxisCount: 10,
                    children: List.generate(100, (index) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            var getColor=assignColorToSlot(index, outerIndex, selectedSlot, releaseSlot);
                            if(widget.type=="D"){
                              if(getColor==Colors.teal){
                                final snackBar = SnackBar(
                                  content: const Text("You are not allowed to do so!!!"),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{
                                bloc.releaseSlotForCarParking(context, slots[outerIndex], index + 1);
                              }
                            }else{
                              print('Slot Clicked ${slots[outerIndex]}-${index + 1}');
                              if(getColor==Colors.red){
                                final snackBar = SnackBar(
                                  content: const Text("This is slot is already booked.."),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{
                                bloc.getSlotForCarParking(context, slots[outerIndex], index + 1);
                              }



                            }
                            },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: assignColorToSlot(index, outerIndex, selectedSlot, releaseSlot), // This is what you need!
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              '${slots[outerIndex]}-${index + 1}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
                separatorBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Slot Type - ${slots[index + 1].toString()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Total Capacity - 100",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    )),
          );
        });
  }

  Color assignColorToSlot(int index, int outerIndex, String slotSelected, String releaseSlot) {
    print("index is ${index} and slots[outerIndex] is ${slots[outerIndex]}");
    print("JD slot ${slotSelected}");
    var slotColor;
    print("MYlist size ${listOFSlots.length}");

    /*String item =  nameRetriever("${slotSelected}");
    if (item.isNotEmpty) {
      List<String> words = item.split("-");
      int intVal = int.parse(words[1]);
      if (slots[outerIndex] == words[0] && index + 1 == intVal) {
        print("item found");
        return slotColor = Colors.red;
      }
    }*/

    if (slotSelected.isNotEmpty) {
      List<String> words = slotSelected.split("-");
      int intVal = int.parse(words[1]);
      if (slots[outerIndex] == words[0] && index + 1 == intVal) {
        print("item found");
        return slotColor = Colors.red;
      }
    }else if(releaseSlot.isNotEmpty){
      //List<String> words = slotSelected.split("-");
      //int intVal = int.parse(words[1]);
      //if (slots[outerIndex] == words[0] && index + 1 == intVal) {
        print("item found");
        return slotColor = Colors.teal;
      //}
    }
    if (index == 1) {
      slotColor = Colors.teal;
    } else if (index == 2) {
      //slotColor = index.floor().isEven ? Colors.red[400] : Colors.teal;
      slotColor = Colors.teal;
    } else if (index == 3) {
      /*slotColor = (outerIndex == 1)
          ? Colors.red[400]
          : (index.floor().isOdd
              ? Colors.red[400]
              : Colors.teal); */ // This is what you need!

      slotColor = Colors.teal;
    } else {
      slotColor = Colors.teal;
      /*slotColor = (outerIndex == 1)
          ? Colors.red[400]
          : (index.floor().isOdd ? Colors.red[400] : Colors.teal); */ // T
    }
    return slotColor;
  }
}
