import 'package:flutter/material.dart';
import 'package:parking_app/screens/booking.dart';

class FindSpot extends StatefulWidget {
  const FindSpot({Key? key});

  @override
  State<FindSpot> createState() => _FindSpotState();
}

class Slot {
  final String slot;
  final int floor;
  final int id;

  Slot(this.floor, this.slot, this.id);
}

class _FindSpotState extends State<FindSpot> {
  int selectedFloor = 1;
  final List<int> availableFloors = [1, 2, 3];
  List<Slot> slots = [
    Slot(1, 'A0', 1),
    Slot(2, 'A1', 2),
    Slot(2, 'A2', 3),
    Slot(1, 'A3', 4),
    Slot(3, 'A4', 5),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.9;
    List<Slot> filteredSlots = slots.where((slot) => slot.floor == selectedFloor).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                width: buttonWidth,
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 86, 165),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Find your spot',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Find easy parking',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/phone.png',
                          width: 200,
                          height: 200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color.fromARGB(110, 0, 0, 0)),
                ),
                child: DropdownButtonFormField<int>(
                  value: selectedFloor,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedFloor = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    labelText: 'Select your floor',
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    border: InputBorder.none,
                  ),
                  items: availableFloors
                      .map((floor) => DropdownMenuItem<int>(
                            value: floor,
                            child: Text('Floor $floor'),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredSlots.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _navigateToSlotPage(context, filteredSlots[index]);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          SlotDisplay(filteredSlots[index]),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 200)
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSlotPage(BuildContext context, Slot slot) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SlotBooking(slot: slot),
      ),
    );
  }
}

class SlotDisplay extends StatelessWidget {
  final Slot slot;

  SlotDisplay(this.slot);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/car_slot.png',
          width: 110,
          height: 80,
        ),
        Text(
          '${slot.floor} ${slot.slot}',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

