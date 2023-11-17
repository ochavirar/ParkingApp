// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:parking_app/providers/log_in_provider.dart';
import 'package:parking_app/providers/parking_spots_provider.dart';
import 'package:parking_app/screens/find_spot.dart';
import 'package:parking_app/screens/home_page.dart';
import 'package:provider/provider.dart';

class SlotBooking extends StatelessWidget {
  String formattedDate = "";
  String bookinghour = "";
  int floor_d = 0; 
  int line_d = 0;
  int spot_d = 0;

  SlotBooking({required int floor, required int line, required int spot}) {
    DateTime now = DateTime.now();
    formattedDate = "${now.year}-${now.month}-${now.day}";
    bookinghour = "${now.hour}:${now.minute}";
    floor_d = floor;
    line_d = line;
    spot_d = spot;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/car1.png', 
              width: 500,
              height: 200,
            ),
            Container(
              margin: EdgeInsets.all(16), 
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2, // Ancho del margen
                    color: Color.fromARGB(36, 0, 0, 0), // Color del margen
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle, 
                      size: 48,
                      color: Colors.green,
                    ),
                    Text(
                      "Booking successful",
                      style: TextStyle(fontFamily: 'Lexend', fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text(
                      "${formattedDate}", 
                      style: TextStyle(fontFamily: 'Lexend', fontSize: 19),
                    ),
                    Divider(), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center, 
                          children: [
                            Text(
                              "Check-in",
                              style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                            ),
                            Text(
                              "${bookinghour}",
                              style: TextStyle(fontFamily: 'Lexend', fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center, 
                          children: [
                            Text(
                              "Mall",
                              style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                            ),
                            Text(
                              "Andares",
                              style: TextStyle(fontFamily: 'Lexend', fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(width: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center, 
                          children: [
                            Text(
                              "Floor",
                              style: TextStyle(fontFamily: 'Lexend', fontSize: 15),
                            ),
                            Text(
                              "${floor_d}",
                              style: TextStyle(fontFamily: 'Lexend', fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(), 
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 109, 49, 237), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), 
                          ),
                        ),
                        child: Text(
                          'Home',
                          style: TextStyle(fontFamily: 'Lexend', fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<ParkingSpotProvider>(context, listen: false).checkoutFromSpace(
                          Provider.of<LogInProvider>(context, listen: false).loggedInUserId
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                      },
                      child: Text(
                        'Check out',
                        style: TextStyle(fontFamily: 'Lexend', fontSize: 20, color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}