import 'package:flutter/material.dart';
import 'package:parking_app/screens/find_spot.dart';

class SlotPage extends StatelessWidget {
  final Slot slot;

  SlotPage({required this.slot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Slot ID: ${slot.id}'),
            Text('Floor: ${slot.floor}'),
            Text('Slot: ${slot.slot}'),
          ],
        ),
      ),
    );
  }
}
