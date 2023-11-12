import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParkingSpotProvider with ChangeNotifier{
  List<dynamic> parkingSpots = [];
  static const String _parkingSpotsLink = 'http://localhost:3000/parkingSpot/free';

  get freeParkingSpots => parkingSpots;

  Future <void> getFreeParkingSpaces() async {
    final response = await http.get(Uri.parse(_parkingSpotsLink));
    if (response.statusCode == 200) {
      notifyListeners();
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load parking spots');
    }
  }  
}