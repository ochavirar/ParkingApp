import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parking_app/providers/log_in_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ParkingHistory extends StatelessWidget {
  const ParkingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: ParkingHisotrylist()
      ),
    );
  }
}

class ParkingHisotrylist extends StatefulWidget {
  const ParkingHisotrylist({super.key});

  @override
  State<ParkingHisotrylist> createState() => _ParkingHisotrylistState();
}

class _ParkingHisotrylistState extends State<ParkingHisotrylist> {
  List<dynamic> filteredCosts = [];

  @override
  void initState() {
    super.initState();
    _getParkingCosts();
  }

  Future<void> _getParkingCosts() async{
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
      child: ListView.builder(
        itemCount: filteredCosts.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
              child: Column(
              children: [
                Text(filteredCosts[index]['hours'].toString()),
                Text(filteredCosts[index]['totalPayed'].toString()),
                Text(filteredCosts[index]['parkingSpot']['floor'].toString()),
              ],
            )
          );
        },
      )
    );
  }
}