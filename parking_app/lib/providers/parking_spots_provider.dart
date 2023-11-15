import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/providers/log_in_provider.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

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

  Future<void> reserveParkingSpace(int floor, int row, int number, String userId) async{
    const String url = 'http://localhost:3000/parkingSpot/reservation';
    print('floor: $floor, row: $row, number: $number, user: $userId');
    final Map<String, dynamic> data = {
      'floor': floor,
      'row': row,
      'number': number,
      'user': userId
    };
    print(data);
        

    final response = await http.post(Uri.parse(url), body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to change parking spot');
    }
  }  
}