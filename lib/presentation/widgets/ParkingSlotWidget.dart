import 'package:demo_app/presentation/bloc/car_parking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/ParkingLot.dart';
import '../../injection.dart';
import '../bloc/car_parking_cubit.dart';

class ParkingSlotWidget extends StatefulWidget {
  const ParkingSlotWidget(
      {super.key, required this.slotSelected, required this.type});

  final String slotSelected;
  final String type;

  @override
  State<ParkingSlotWidget> createState() => _ParkingSlotWidgetState();
}

class _ParkingSlotWidgetState extends State<ParkingSlotWidget> {
  List<ParkingSlotType> nSlots = ParkingSlotType.values;

  var textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  late CarParkingCubit bloc = getIt<CarParkingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarParkingCubit, CarParkingState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is CarParkingGettingSlotSuccessState) {
          var desc = getDescriptionDetails(state);
          final snackBar = genericSnackBar(desc, () {
            Navigator.pop(context);
          });
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is CarParkingSlotReleasedState) {
          var desc = carSlotReleasedDescription(state);
          bloc.setSlot="";
          final snackBar = SnackBar(
            content: Text(desc),
            action: SnackBarAction(label: 'Ok', onPressed: () {}),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var selectedSlot = "";
        var releaseSlot = "";
        if (state is CarParkingGettingSlotSuccessState) {
          selectedSlot = state.featuresModel.slotId;
        } else if (state is CarParkingSlotReleasedState) {
          releaseSlot = state.release;
          return showYourBillInvoice(state);
        } else {
          selectedSlot = widget.slotSelected;
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 50, 50),
          child: ListView.separated(
            key: const Key("CarParkingList"),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: nSlots.length,
            itemBuilder: (context, outerIndex) {
              bloc.createSlotForParking(nSlots.elementAt(outerIndex),100);
              return Column(
                children: [
                  separatorRowWidget(outerIndex, "Total Capacity - 100"),
                  const SizedBox(height: 20),
                  GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 4,
                      crossAxisCount: 10,
                      children: List.generate(100, (index) {
                        return Center(
                            child: selectParkingSlotButton(index, outerIndex,
                                selectedSlot, releaseSlot, context),
                          );
                        },
                      )),
                ],
              );
              },
            separatorBuilder: (context, index) => separatorWidgetForList(),
          ),
        );
      },
    );
  }

  Widget selectParkingSlotButton(
    int index,
    int outerIndex,
    String selectedSlot,
    String releaseSlot,
    BuildContext context,
  ) {
    return ElevatedButton(
      key: Key("${nSlots.elementAt(outerIndex).name}-$index"),
      onPressed: () {
        debugPrint("button is pressed");
        var getColor = assignColorToSlot(
          index,
          outerIndex,
          selectedSlot,
          releaseSlot,
        );
        if (widget.type == "D") {
          if (getColor == Colors.teal) {
            final snackBar = genericSnackBar("You are not allowed to do so!!!", () {});
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            //bloc.releaseSlotForCarParking(context, slots[outerIndex], index + 1);
            bloc.releaseSlotForCarParking(context, nSlots.elementAt(outerIndex).name, index + 1);
          }
        } else {
          debugPrint('Slot Clicked ${nSlots.elementAt(outerIndex).name}-${index + 1}');
          if (getColor == Colors.red) {
            final snackBar = genericSnackBar("This is slot is already booked..", () {});
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
           // bloc.getSlotForCarParking(context, slots[outerIndex], index + 1);
            bloc.getSlotForCarParking(context, nSlots.elementAt(outerIndex).name, index + 1);
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: assignColorToSlot(
          index,
          outerIndex,
          selectedSlot,
          releaseSlot,
        ), // This is what you need!
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          '${nSlots.elementAt(outerIndex).name}-${index + 1}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  SnackBar genericSnackBar(String text, Function() onTap) {
    return SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: onTap,
      ),
    );
  }

  Column separatorWidgetForList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 20),
        Divider(
            height: 10,
            color: Colors.black
        ),
      ],
    );
  }

  Row separatorRowWidget(int index, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Slot Type - ${nSlots.elementAt(index).name.toString()}", style: textStyle),
        Text(text2, style: textStyle)
      ],
    );
  }

  String carSlotReleasedDescription(CarParkingSlotReleasedState state) {
    var desc = "";
    if (state.release.isEmpty) {
      desc = "Sorry no slot available";
    } else {
      desc =
          "Your allotted slot has been released and we are generating your bill please wait";
    }
    return desc;
  }

  String getDescriptionDetails(CarParkingGettingSlotSuccessState state) {
    var desc = "";
    var slotType = state.featuresModel.slotType;
    var slotId = state.featuresModel.slotId;
    var floor = state.featuresModel.floor;
    if (slotType.isEmpty) {
      desc = "Sorry no slot available";
    } else {
      desc =
          "You have been allotted parking on  $floor floor of slotType $slotType having slotId $slotId ";
    }
    return desc;
  }

  Color assignColorToSlot(
      int index, int outerIndex, String slotSelected, String releaseSlot) {
    MaterialColor slotColor;
    if (slotSelected.isNotEmpty) {
      List<String> words = slotSelected.split("-");
      int intVal = int.parse(words[1]);
      if (nSlots.elementAt(outerIndex).name == words[0] && index + 1 == intVal) {
        debugPrint("Button color changed");
        return slotColor = Colors.red;
      }
    } else if (releaseSlot.isNotEmpty) {
      return slotColor = Colors.teal;
    }
    if (index == 1) {
      slotColor = Colors.teal;
    } else if (index == 2) {
      slotColor = Colors.teal;
    } else if (index == 3) {
      slotColor = Colors.teal;
    } else {
      slotColor = Colors.teal;
    }
    return slotColor;
  }

  Widget showYourBillInvoice(CarParkingSlotReleasedState state) {
    return Container(
      width: 500,
      height: 300,
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          key: const Key("bill-invoice-column"),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rowItem("Vehicle Id -", "MHG 12 RU 7667"),
            rowSeparatorSizedBox(),
            rowItem("Vehicle SlotType -", state.tariffData.slotType),
            rowSeparatorSizedBox(),
            rowItem("In time -", "10.20AM"),
            rowSeparatorSizedBox(),
            rowItem("Out time -", "1.00 PM"),
            rowSeparatorSizedBox(),
            rowItem("Parking Cost -", state.tariffData.cost),
          ],
        ),
      ),
    );
  }

  Row rowItem(String text1, String text2) {
    return Row(
      children: [
        Expanded(child: Text(text1, style: textStyle)),
        Expanded(child: Text(text2, style: textStyle)),
      ],
    );
  }

  SizedBox rowSeparatorSizedBox() => const SizedBox(height: 10);
}
