// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:parking_app/screens/home_page.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ParkingApp',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color:Color.fromARGB(255, 47, 125, 121),
      ), 
    ),
    home: HomePage(),
  ),
);

 