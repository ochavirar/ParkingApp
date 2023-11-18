import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parking_app/providers/log_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/screens/home_page.dart';

class ParkingHistory extends StatelessWidget {
  const ParkingHistory({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: ParkingHistoryList(),
      ),
    );
  }
}

class ParkingHistoryList extends StatefulWidget {
  const ParkingHistoryList({Key? key});

  @override
  State<ParkingHistoryList> createState() => _ParkingHistoryListState();
}

class _ParkingHistoryListState extends State<ParkingHistoryList> {
  List<dynamic> filteredCosts = [];

  @override
  void initState() {
    super.initState();
    _getParkingCosts();
  }

  Future<void> _getParkingCosts() async {
    final String userId = Provider.of<LogInProvider>(context, listen: false).id;
    const String parkingCostsLink = 'http://localhost:3000/cost/';
    final response = await http.get(Uri.parse(parkingCostsLink + userId));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        filteredCosts = responseData;
      });
    } else {
      throw Exception('Failed to load parking costs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          ),
          Text(
            "Congrats! You've booked",
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 109, 49, 237),
            ),
            child: Center(
              child: Text(
                filteredCosts.length.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lexend',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCosts.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  color: index % 2 == 0
                      ? Color.fromARGB(255, 109, 49, 237) // Color del círculo
                      : Colors.white, // Color alternativo
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hours: ${filteredCosts[index]['hours']}',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Total Payed: ${filteredCosts[index]['totalPayed']}',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Floor: ${filteredCosts[index]['parkingSpot']['floor']}',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Row: ${filteredCosts[index]['parkingSpot']['row']}',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Number: ${filteredCosts[index]['parkingSpot']['number']}',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: index % 2 == 0 ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
