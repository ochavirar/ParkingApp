import 'package:flutter/material.dart';

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

class ParkingHisotrylist extends StatelessWidget {
  const ParkingHisotrylist({super.key});

  @override
  Widget build(BuildContext context) {
    return const ParkingHistoryItem();
  }
}

class ParkingHistoryItem extends StatelessWidget {
  const ParkingHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
        child: Column(
        children: [
          Text("Piso: 1"),
          Text("Linea: 1"),
          Text("Spot: 1"),
        ],
      )
    );
  }
}