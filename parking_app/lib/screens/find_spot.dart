import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:parking_app/providers/log_in_provider.dart';
import 'package:parking_app/providers/parking_spots_provider.dart';
import 'package:parking_app/screens/booking.dart';
import 'package:provider/provider.dart';


class FindSpot extends StatefulWidget {
  const FindSpot({Key? key});

  @override
  State<FindSpot> createState() => _FindSpotState();
}

class _FindSpotState extends State<FindSpot> {

  List<dynamic> filteredSlots = [];
  
  @override
  void initState() {
    super.initState();
    _getFreeParkingSpaces();
  }

  Future<void> _getFreeParkingSpaces() async {
    const String parkingSpotsLink = 'http://localhost:3000/parkingSpot/free';
    final response = await http.get(Uri.parse(parkingSpotsLink));
    print(response); 
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        filteredSlots = responseData;
        print(filteredSlots[0]['floor']);
        print(filteredSlots[0]['row']);
        print(filteredSlots[0]['number']);
      });
    } else {
      throw Exception('Failed to load parking spots');
    }
  }

  @override   
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.9;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: buttonWidth,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 86, 165),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Column(
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
                const SizedBox(height: 40),
                Expanded(
                  child: ListView.builder( // List builder for the spots obtained through the provider
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredSlots.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if ( filteredSlots[index]['floor'] != null &&
                           filteredSlots[index]['row'] != null && 
                          filteredSlots[index]['number'] != null){
                            Provider.of<ParkingSpotProvider>(context, listen: false).reserveParkingSpace(
                              filteredSlots[index]['floor'], 
                              filteredSlots[index]['row'], 
                              filteredSlots[index]['number'], 
                              Provider.of<LogInProvider>(context, listen: false).id
                            ).then((value) {
                              _navigateToSlotPage(context, filteredSlots[index]['floor'], filteredSlots[index]['row'], filteredSlots[index]['number']);
                            });
                          }
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 30),
                            SlotDisplay(
                              (filteredSlots[index]['floor']) != null ? filteredSlots[index]['floor'] : 0, 
                              (filteredSlots[index]['row']) != null ? filteredSlots[index]['row'] : 0, 
                              (filteredSlots[index]['number']) != null ? filteredSlots[index]['number'] : 0, 
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 200)
              ],
            ),
          ),
        ),
      );
  }

  void _navigateToSlotPage(BuildContext context, int floor_d, int line_d, int spot_d) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SlotBooking(floor: floor_d, line: line_d, spot: spot_d),
      ),
    );
  }
}

class SlotDisplay extends StatelessWidget {
  int floor = 0;
  int line = 0;
  int spot = 0;

  SlotDisplay(this.floor, this.line, this.spot);

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
        Column(
          children: [
            Text(
              'Piso: ${floor}',
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Línea: ${line}',
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Cajón: ${spot}',
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Available',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                color: Colors.green,
              ),
            ),],
        )
      ],
    );
  }
}
